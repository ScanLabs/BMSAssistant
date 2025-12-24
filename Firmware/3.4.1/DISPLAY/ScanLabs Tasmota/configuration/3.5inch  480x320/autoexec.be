#VERSION 5.1 - Needs ScanLabs dongle version 3.3.0 for ESP32-35 480x320
import global
import haspmota
import string
import json
import math
haspmota.start(false, "pages.jsonl")

#global VAR - SETUP VAR
var maxPage = 1           
var autoBrightness = 0        # **NEED HW Modification** 
var Brighness_max = 30        # Brighness_max[s] (%Brighness_max_lvl) -> Brighness_avg[s] (%Brighness_avg_lvl) -> Brighness_min[s] (%Brighness_min_lvl)
var Brighness_max_lvl = 100   
var Brighness_avg = 20        
var Brighness_avg_lvl = 45
var Brighness_min_lvl = 10
var localSecsCounter = 0
var rollingPages = 0
var rollingPagesSecs = 0 
var chartEnb = 0
var chartTimeSpan = 8

#global VAR - Internal NO TOUCH
var backLightTimer = 0
var dimmerBef = 0
var Pg = "p0"
var cpage = 1
var ledSt = 0  
var ledblk = 0
var barValue = 100
var barTime = 60
var payload_json
var payload_json_list = []
var displayUpdateSem = 0
var index = 1
var RPcPage = 1 
var tempVar = 0
var timeNow
var tnow=["1","2","3","4","5","6","7"]
var pwMm=[0,0]
var pwMm10pc=[0,0]
var maxChartPoints = 50
var chartBkp=[]


# RULE LABEL IP ADDRESS # 
def LabelIPOFF ()
  global.p0b239.bg_opa = 0
  global.p0b239.text_opa=0
  global.p0b239.border_opa=0
end

#switch on LABEL IP - after 5s switch off
def rule_IP(IPvalue)
  global.p0b239.text=IPvalue
  global.p0b239.bg_opa = 255
  global.p0b239.text_opa=255
  global.p0b239.border_opa=255
  tasmota.set_timer(5000, LabelIPOFF )
end

#Rule on "GOT an IP"
tasmota.add_rule("Info2#IPAddress", def (IPvalue) rule_IP(IPvalue) end )

# TOUCH SCREEN EVENT TRACER
def touchTracer()
  var touchNow = lv.get_ts_calibration()
  if  ( touchNow.state )
    if autoBrightness == 0
      backLightTimer = 0
      tasmota.cmd(f"displaydimmer {Brighness_max_lvl}", true)
    end
  end
  tasmota.set_timer(500, touchTracer )
end

# ADJUST DISPLAY BRIGHNESS check every 5s
def check_Brightness()
  if autoBrightness == 0 
    backLightTimer=backLightTimer+1
    if backLightTimer <= Brighness_max/5
      tasmota.cmd(f"displaydimmer {Brighness_max_lvl}")
    elif backLightTimer <= (Brighness_max+Brighness_avg)/5
      tasmota.cmd(f"displaydimmer {Brighness_avg_lvl}", false)
    else 
      tasmota.cmd(f"displaydimmer {Brighness_min_lvl}", false)
      backLightTimer = backLightTimer-1 
    end
  else
    var payload = json.load(tasmota.read_sensors())
    var raw = payload.find("ANALOG",{}).find("A1")
    if raw != nil
      var dimmer
      if raw > 1000 raw=1000 end
      dimmer = ( 1000-raw )/10
      if dimmer==0 dimmer=15 end
      if dimmer != dimmerBef
        dimmerBef = dimmer
        tasmota.cmd(f"displaydimmer {dimmer}", false)
      end
    end
  end
end

tasmota.cmd(f"displaydimmer {100}")  #default set luminance at max
tasmota.add_cron("*/5 * * * * *", check_Brightness)   # check every 5s

# MANAGE GAUGE on DISPLAY
# rM = Max Radius ,  rm = Min Radius , cx = centerX , cy = centerY
def drawline(val, obj, rM, rm, cx, cy)
  var bobj = f"b{obj}"
  var angle = ((210-(val*(240.0/100)))*math.pi/180)
  var pt1x = math.round(cx + (rM * math.cos(angle)))
  var pt1y = math.round(cy - (rM * math.sin(angle)))
  var pt2x = math.round(cx + (rm * math.cos(angle)))
  var pt2y = math.round(cy - (rm * math.sin(angle)))
  global.(Pg + bobj ).points=[[pt1x,pt1y],[pt2x,pt2y]]
end

def calcPos( StrIn, offset)
  var calcX=0
  calcX += size(StrIn) * 16
  calcX += string.count(StrIn, '0') * 3
  calcX += string.count(StrIn, '8') * 3
  calcX += string.count(StrIn, '9') * 1
  calcX -= string.count(StrIn, '1') * 5
  calcX -= string.count(StrIn, '.') * 6
  calcX -= string.count(StrIn, '-') * 5
  return (calcX+offset)
end

#update the Current DashBoard vs Number of Pages
def pageSet( what, bright )
  maxPage = size(haspmota.get_pages())

  cpage = cpage + what
  if ( cpage > maxPage ) cpage=1 end
  if ( cpage ==0  ) cpage=maxPage end
  RPcPage = cpage
  global.p0b110.text = string.format("%d-%d", cpage, maxPage )
  if ( bright )
    backLightTimer = 0
    tasmota.cmd(f"displaydimmer {Brighness_max_lvl}", true)
  end
end
tasmota.add_rule("hasp#p0b101#event=up", / ->pageSet(-1,1))
tasmota.add_rule("hasp#p0b103#event=up", / ->pageSet(1,1))

# DINAMIC CREATION OF A NEW DASHBOARD
def strReplace(stringIn, from, to)
  import string
  return string.split(stringIn, from).concat(to)
end

def addDashBoard( pageID )
  var logFile = open('template.jsonl', 'r')
  var lineBuf = " "
  while (lineBuf != nil && lineBuf != "$$$")
    tasmota.yield()
    lineBuf = logFile.readline()
    tasmota.yield()
    if ( !string.find(lineBuf,"$$$") )
      break
    end
    lineBuf = strReplace( lineBuf, "$#PID#$", str(pageID))
    if (lineBuf != nil && lineBuf != "" && string.byte(lineBuf) != 13)
      tasmota.yield()
      haspmota.parse(lineBuf)
      tasmota.yield()
    end
  end
  logFile.close()
end

def addChart()
  var logFile = open('chart.jsonl', 'r')
  var lineBuf = " "
  while (lineBuf != nil && lineBuf != "$$$")
    tasmota.yield()
    lineBuf = logFile.readline()
    tasmota.yield()
    if ( !string.find(lineBuf,"$$$") )
      break
    end
    if (lineBuf != nil && lineBuf != "" && string.byte(lineBuf) != 13)
      tasmota.yield()
      haspmota.parse(lineBuf)
      tasmota.yield()
    end
  end
  logFile.close()
end

# EOF DINAMIC

# PARSE MQTT Json coming from ScanLabs DONGLE Smartbms.it 
def mqttDequeuing()

  var SOC = -1
  var tempColor = "#0000D0"
  
  if (payload_json_list.size() == 0 && displayUpdateSem == 0 )
    return
  end

  if (payload_json_list.size() && displayUpdateSem == 0 )
     payload_json = payload_json_list.pop()
     displayUpdateSem = 1
  end

#  No json or NO dashboard page (Pd) ? Malformed Json -> exit
  if ( payload_json == nil || payload_json.find("Pd") == nil )
    print("json missing or packet format error")
    displayUpdateSem = 0
    return 
  end

  #Json -> page to update
  var thePage=int(payload_json.find("Pd")) 
  Pg = f"p{thePage}"

  if ( thePage==0 )
    print("ModBus not ready or parsing error")
    displayUpdateSem = 0
    return 
  end

  var pageArray = haspmota.get_pages()
  if pageArray.find(thePage) == nil 
    addDashBoard( thePage )
  end

  #get the X points of superscripts
  var Vtx = global.("p1b18").x
  var Ax = global.("p1b28").x
  var Wx = global.("p1b38").x
  var Cpx = global.("p1b58").x
  var Avx = global.("p1b78").x
  var Dlx = global.("p1b88").x
  var Tx = global.("p1b98").x

  if (payload_json.find("SOC") != nil)
    SOC = int(payload_json.find("SOC"))
    if    SOC < 10  tempColor = "#0000D0"
    elif  SOC < 50  tempColor = "#03c6fc"
    elif  SOC < 75  tempColor = "#03fc98"
    else  tempColor = "#00FF00"
    end 
  end

  if (index == 1 && SOC>=0 ) 
    global.(Pg + "b3").text_color = tempColor
    
  elif (index == 2  && SOC>=0 )
    global.(Pg + "b4").line_color = tempColor
    
  elif (index == 3  && SOC>=0 )
    global.(Pg + "b3").text= SOC
    
  elif (index == 4 && SOC>=0 )
    drawline(SOC, 4, 78, 104, 100, 100)
    
  elif (index == 5 && payload_json.find("Vt") != nil)                 #total battery voltage
    global.(Pg + "b18").text=str(payload_json.find("Vt"))
    global.(Pg + "b20").x = calcPos(str(payload_json.find("Vt")),Vtx)
    
  elif (index == 6 && payload_json.find("Am") != nil)                 #Ampere In/Out 
    global.(Pg + "b28").text=str(payload_json.find("Am"))
    global.(Pg + "b30").x = calcPos(str(payload_json.find("Am")),Ax)
    
  elif (index == 7 && payload_json.find("W") != nil)                  #Watt 
    global.(Pg + "b38").text=str(payload_json.find("W"))
    global.(Pg + "b40").x = calcPos(str(payload_json.find("W")),Wx)

  elif (index == 8 && payload_json.find("Ca") != nil)
    global.(Pg + "b58").text=str(payload_json.find("Ca"))             #Capacity
    global.(Pg + "b60").x = calcPos(str(payload_json.find("Ca")),Cpx)
    
  elif (index == 9 && payload_json.find("Ch") != nil)
    tempColor="#00FFFF"
    if ( payload_json.find("Ch") == "OFF" ) tempColor="#03c6fc" end
    global.(Pg + "b48").text_color=tempColor
    global.(Pg + "b48").text=str(payload_json.find("Ch"))             #Charge MOS
    
  elif (index == 10 && payload_json.find("Av") != nil)
    global.(Pg + "b78").text=str(payload_json.find("Av"))             #Voltage average
    global.(Pg + "b80").x = calcPos(str(payload_json.find("Av")),Avx)
    
  elif (index == 11 && payload_json.find("Dv") != nil)                #delta V on batts
    global.(Pg + "b88").text=str(payload_json.find("Dv"))
    global.(Pg + "b90").x = calcPos(str(payload_json.find("Dv")),Dlx)
    
  elif (index == 12 && payload_json.find("T") != nil)                 #Temperature
    global.(Pg + "b98").text=str(payload_json.find("T"))
    global.(Pg + "b100").x = calcPos(str(payload_json.find("T")),Tx)
    
  elif (index == 13 && payload_json.find("Bt") != nil)                #Number of Batts
    global.(Pg + "b118").text=str(payload_json.find("Bt"))
    
  elif (index == 14 && payload_json.find("Dh") != nil)                #Discharge MOS
    tempColor="#00FFFF"
    if ( payload_json.find("Dh") == "OFF" ) tempColor="#03c6fc" end
    global.(Pg + "b108").text_color=tempColor
    global.(Pg + "b108").text=str(payload_json.find("Dh"))
    
  elif (index == 15 && payload_json.find("Fa") != nil)                #Failure flag -> enable Led Blinking
    ledblk = int(payload_json.find("Fa"))
    
  elif (index == 16 && payload_json.find("Pd") != nil)                #HaspMota page ID defined on dongle
    # do something
  elif (index == 17 && payload_json.find("Rt") != nil && cpage==thePage)  #Refresh MQTT Time
    barTime = int(payload_json.find("Rt"))
    #maxChartPoints = chartTimeSpan/barTime 
    barValue=100

  elif (index == 18 )                #Auto Brighness Enable - needs HW fix
    if ( payload_json.find("Al1") != nil)
       tempVar = int(payload_json.find("Al1"))
       chartEnb = (tempVar & 0x04000000)?1:0
       chartTimeSpan = (((tempVar & 0xF8000000)>>27)&0x1F)*3600

       rollingPages = (tempVar & 0x02000000)?1:0
       autoBrightness = (tempVar & 0x01000000)?1:0
       Brighness_max_lvl = (tempVar & 0x00FF0000)>>16
       Brighness_avg_lvl = (tempVar & 0x0000FF00)>>8
       Brighness_min_lvl = (tempVar & 0x000000FF)
       pageSet(0,0)
    
       #rollingPages = 0  #CASOOOOOOOO questo crea problemi !!!

       if chartEnb
         try 
           global.p100b1.x=8
         except
           addChart()
         end
       end

    end

    if ( payload_json.find("Al2") != nil)
       var tempVar = int(payload_json.find("Al2"))
       rollingPagesSecs = ((tempVar & 0xFF000000)>>24)&0xFF
       Brighness_max = (tempVar & 0x00FFF000)>>12
       Brighness_avg = (tempVar & 0x00000FFF)
    end    
  elif (index == 19 && payload_json.find("MST") != nil) 
    global.(Pg + "b5").text=payload_json.find("MST")
    
  elif (index == 20 && payload_json.find("SM") != nil)  
    drawline(int(payload_json.find("SM")), 2, 79, 105, 100, 100)
    
  elif (index == 21 && payload_json.find("Nm") != nil)
    global.(Pg + "b150").text=str(payload_json.find("Nm"))
    
    #Place for Chart Updates
  elif (index == 22 && chartEnb && payload_json.find("W") )

    #fix chart size and set values
    maxChartPoints = chartTimeSpan/barTime 
    global.p100b1.series1_color="#0fd960"
    global.p100b1.series2_color="#0f2dd9"
    global.p100b1.point_count=maxChartPoints
    if int(payload_json.find("W")) >= 0
      global.p100b1.val=int(payload_json.find("W"))
      global.p100b1.val2=0
    else
      global.p100b1.val2=int(payload_json.find("W"))
      global.p100b1.val=0
    end

   
    chartBkp.push(int(payload_json.find("W")))

    #calc x time scale label
    timeNow = tasmota.rtc("local")  #UTC
    for ii:0..6 
       tnow[6-ii]=tasmota.strftime("%H:%M", timeNow-(ii*(maxChartPoints/6)*barTime))
    end
    global.p100b2.text_src=tnow

  elif ( index == 23 && chartEnb )

    #calc Min MAX of the shown series
    if chartBkp.size() > maxChartPoints
      chartBkp.pop(0)
    end
    if chartBkp.size()
      pwMm[0]=0
      pwMm[1]=0
      for ii:0..chartBkp.size()-1
        if chartBkp.item(ii) > pwMm[0] pwMm[0]=chartBkp.item(ii) end
        if chartBkp.item(ii) < pwMm[1] pwMm[1]=chartBkp.item(ii) end
      end
    end

    #10% margin for the chart limits in y
    pwMm10pc[1]=math.round(pwMm[1]*1.1)
    pwMm10pc[0]=math.round(pwMm[0]*1.1)

    global.p100b1.y_min=pwMm10pc[1]
    global.p100b1.y_max=pwMm10pc[0]
    global.p100b1.y2_min=pwMm10pc[1]
    global.p100b1.y2_max=pwMm10pc[0]
    global.p100b3.min=pwMm10pc[1]
    global.p100b3.max=pwMm10pc[0]
    global.p100b5.text=str(pwMm[0])+"W"
    global.p100b6.text=str(pwMm[1])+"W"
    if SOC >=0 global.p100b4.text=str(SOC)+"%" end

  elif ( index == 24 && payload_json.find("Tz") != nil && thePage==1) #Time Zone is get ONLY from battery pack ID=1
    var TZ = int(payload_json.find("Tz"))
    tasmota.cmd(f"Timezone {TZ}", true)    
  end

  #Work Around - doing like this Tasmota does not crash - under investigation
  index+=1
  if (index==25) 
    index=1 
    displayUpdateSem = 0
  end 
  
  tasmota.set_timer(5, mqttDequeuing)  
end

#Command invoked by MQTT to store on queue the MQTT packet 
def parseAll(cmd, idx, payload, Jpayload)
  payload_json_list.push( Jpayload )
  tasmota.resp_cmnd_done()
end
tasmota.add_cmd('pAll', parseAll)

def queueit( Jpayload )
  payload_json_list.push( Jpayload )
end

#TASK CALLED EVERY SECOND Managing multiple stuffs
def oneSecondTasks()     
  
  localSecsCounter+=1

  #Auto Rolling pages? 
  if ( rollingPagesSecs && rollingPages && !(localSecsCounter % rollingPagesSecs) )
    RPcPage+=1
    if ( RPcPage > size(haspmota.get_pages())) RPcPage=1 end
    if ( RPcPage == size(haspmota.get_pages()) && chartEnb ) RPcPage=100 end
    Pg = f"p{RPcPage}"
    global.(Pg).show()
    pageSet(1,0)
  end
	
  #MQTT dequeuing 
  mqttDequeuing()

  #MQTT time progressing BAR
  if (barValue > 0 && barTime )
    import math
    barValue = barValue - ( math.round(100.0 / barTime) )
  else
    barValue=0 
  end 
  global.p0b105.val = barValue

  #BLINK LED Alarm
  if (Pg == "p0" || Pg == "p100") return end
  
  if ledblk == 0
    global.(Pg + "b140").bg_opa=0
    global.(Pg + "b140").bg_color = "#00FF00"
    global.(Pg + "b140").border_color = "#00FF00"
    global.(Pg + "b140").color = "#00FF00"
    return
  end
  if ledSt == 0 
    global.(Pg + "b140").bg_opa=0
    global.(Pg + "b140").bg_color = "#03e8FC"
    global.(Pg + "b140").color = "#03e8FC"
    ledSt=1
  else
    global.(Pg + "b140").bg_opa=255
    global.(Pg + "b140").bg_color = "#0000D0"
    global.(Pg + "b140").color = "#0000D0"
    ledSt = 0
  end 
end

def checkConfFile()  
  import path
  var theFileName = 'config.txt'
  print("Checking For ScanLabs config file")

  if !path.exists(theFileName)
    return
  end
 
  var theFile = open(theFileName, 'r')
  var jsn = json.load(theFile.read())
  var command = ""

  if jsn == nil
    return
  end

  #SSID is checked as trigger to change the password as well    
  command = command + f"Backlog SSID1 0;SSID2 0;SSID1 {jsn.find('wssid')};Password {jsn.find('wpwd')};WifiConfig 5;"
  command = command + f"MqttHost {jsn.find('mqtt_server')};"
  command = command + f"MqttUser {jsn.find('mqtt_uname')};"
  command = command + f"MqttPassword {jsn.find('mqtt_pwd')};"
  command = command + f"MqttPort {jsn.find('mqtt_port')};"
  command = command + f"SO3 {int(jsn.find('mqtt_Publish'))};"
  command = command + f"SO103 {int(jsn.find('mqtt_Sec'))};"

  theFile.close()
  path.remove(theFileName)
  tasmota.cmd(command)
end

### MAIN
checkConfFile()
touchTracer()
tasmota.add_cron("*/1 * * * * *", oneSecondTasks,"oneS")
tasmota.add_rule("SMA#", def (SOC) queueit(SOC) end )
tasmota.add_rule("SMA1#", def (MST) queueit(MST) end )