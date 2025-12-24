# ScanLabs Smart BMS data Extractor aka BMSAssistant
DALY - JK - 100Balance - DALY Clones such as Hi - ALL in ONE Assistant - SMART BMS Data Extractor

# COMPATIBILITY LIST:
-  **DALY** – NEWER & FORMER Models with UART(1) Interface ( RS232 )
-  JK BMS via GPS port - JK-Bx
    -  JK-BD6AxxS-10P / JK-BD6AxxS-12P / JK-BD6AxxS-15P/ JK-B1AxxS-15PJK-B2AxxS-15P/ JK-B2AxxS-20P
-  JK BMS via **RS485** port ( RS485A only for the moment)
    -  JK-BD6AxxS-10P, JK-BD6AxxS-12P, JK-BD6AxxS-15P, JK-B1AxxS-15P , JK-B2AxxS-15P, JK-B2AxxS-20P

# Feauture set :
- **BUILD YOURSELF** full guide available at http://www.smartbms.it
-	CONFIGURE in 2 minutes !
    -	Dongle starts as Access Point – you connect via WiFi and configure
    -	Simple AT serial command interface for first provisioning available as well
-	Support for Remote **COLOR DISPLAY**
    - **openHasp** and **TASMOTA** supported
    - Pre-formatted DASHBOARD
    - each display can monitor multiple battery packs even placed on different locations via MQTT
    - POINT 2 POINT connection between BMS dongle and TASMOTA display without internet via MODBUS
-	**BMS to MQTT**  ( TLS & JSON ) to export main battery pack parameters and alarms
    - publish time can be set from 5 seconds to hours
	  - select which parameter you want to publish
	  - Exports auto-generated .json config file for **IoTMqttPanel** mobile app
	  - export multiple JSON-format or raw-format
	  - BROKER tested:
	      - https://www.hivemq.com/ (TLS)
	      - Mosquitto on Home Assistant ( TLS / uncrypted )
	      - MQTTHQ ( uncrypted )
	      - Home Assistant compatibility proven
-	**BMS to MODBUS Server**
	Perfect for Home Assistant TCP MODBUS Users
	Perfect for Smartphone APPs like **Virtuino** 
-	**BMS to MODBUS Client**
  	Publish BMS data to a ModBus Server - simple setup via Json file
-	**BMS to PUSH NOTIFICATION**
      support **PUSHSAFER** and **PUSHOVER** serives
      Send push Notification to your Mobile or PC, Telegram etc !
	    Daily report sent at SunSet / SunRise / SOC 100% / Alarms info
-	**Works WITH or WHITHOUT INTERNET** connection ( Acces Point or Station )
	    Perfect when you don’t have Internet connection – Like on Boat, Cottage …
	    almost All the feature sets are available on both AP and STA mode .
- **STORAGE 6++ months of daily BMS hystory** onboard
      Monitor your batteries 24/7 with 
	    Auto setup depending on how many batteries are on the pack (up to 16)
	    Each battery is monitored , graph ease the way to detect anything is wrong
	    Tired batteries -  battery under / overcapacity specs
	    Balancer malfunctional ( MOS broken or bad wiring )
	    **Each and every anomaly on you battery pack you find in a second!**
	    SOC is monitored as well and synchronized with battery status
      **CHARGE-DISCHARGE** current cycles shown on daily graphs
-	**PASS-THROUGH**
      DALY Smart Bluetooth WiFi or BLE original dongle, can be connected too and works in "parallel"
 	    DALY Graph Panel connected to UART1 can keep working
 	    JK extension connected to GPS Port can be used as well
-	**PACKET SNIFFER** between Bluetooth LE Dongle and DALY Smart BMS
- **Inject RAW command to BMS** via web page
-	**Virtual UART over TCP** to use BmsMonitorVx.x.x or JK equivalent sw via internet
    manage advanced parameters using DALY / JK SW wherever you are !
-	**WEATHER FORECAST** and SunRise/SunSet based on your coordinates
-	**TimeZone detection** based on your coordinates
-	**UPGRADABLE** platform for improvement – and I release many …..

