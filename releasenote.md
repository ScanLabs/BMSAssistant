[DALYBMSWIFI.com](https://dalydmswifi.com) or [SMARTBMS.it](https://smartbms.it) for instructions

REMEMBER! Default html USERNAME: **admin** and PASSWORD: **admin!**

SUPPORT on BOTH **[DISCORD](https://discord.com/invite/AypajkSGgQ)** and onsite **[FORUM](https://dalybmswifi.com/forum)**

Step By Step DIY & Configuration Manual @ **[MANUAL](https://www.dalybmswifi.com/build-it/)**

---

### 3.6.4 released on 03 Oct 2026

* **NEW: IoTMQTTPanel Layout Builder**
  * Accessible from MQTT page of SSBdE
* **AT COMMAND**
  * added AT-NET, AT-DHCP to manage network parameter
  * added to AT-WMODE modes 11B 11G 11N to permanently set radio phy as you wish
* **WEB PAGE LAYOUT**
  * Added SOC percentage superimposed on the Graphical Gauge

### 3.6.3 released on 31 Aug 2026

* **MONITOR GRAPH**
  * Fix: Monitor Graph sometimes cannot detect day rollover resulting in a neverending logging consuming all the flash
  * Add: Monitor page now takes history of the settings made
* **JK -001- protocol**
  * Fix: Reporting positive WATTs even with negative Currents - patch added to detect JK bug and fix
* **VIRTUAL COM PAGES**
  * Fix: Slow Internet connection prevent to change MODE and IP
* **WEBPAGES**
  * Fix: Settings page COORDINATE select back operative
  * Fix: Welcome page in factory mode now support RFPOWER AUTO=127 + page layout redesign
* **MODBUS**
  * Fix: ModBus ID 106 and 107 now contains Cell MAX[mV] and Cell MIN[mV] while 190 and 191 the ID of battery having MAX[mV] and MIN[mV]
  * Fix: Balance current - ModBus ID 180 support uint16_t

### 3.6.2 released on 30 July 2026

* **AUTO TIME ZONE**
  * Fix: Dongle now use Internet IP to retrieve roughly COORDINATES to assume TZ
* **AUTO WIFI POWER**
  * in MISC page, setting output WiFi Power to 127, it enable auto-power set function of signal strength
* **FIXES**
  * Fix: Race condition on OLED display driver bring to display to stuck after a while

### 3.6.1 released on 14 July 2026

* **HOME ASSISTANT DISCOVERY**
  * Home Assistant Discovery now disabled by default
* **FIXES**
  * Fix: Safari do not open the welcome page (websocket)
  * Fix: bms DeviceID not correctly migrated from 3.5.x to 3.6.x
  * Fix: added new ModBus Server Register Table

### 3.6.0 released on 11 July 2026

* **JK‑PBx CAN BUS**
  * Full support for the CAN BUS protocol on JK‑PBx
* **DALY CAN BUS**
  * CAN BUS support for DALY (HW + protocol) $\rightarrow$ Postponed to next releases
* **OLED RAM OPTIMIZED**
  * New RAM‑optimized OLED version $\rightarrow$ becomes the standard choice for the Smart Data Extractor dongle DIY
  * SEE IT IN ACTION ON YOUTUBE
* **FW UPGRADE**
  * Optimized the firmware upgrade process via webpages
* **mDNS DISCOVERY**
  * Improved mDNS system for dongle discovery through Network Scanning App
* **WEBPAGES**
  * Multiple fixes and enhancements to the webpages
* **MBUS SERVER**
  * New BMS parameters now exposed via MBUS Server
* **MQTT EXPORT**
  * New set of values now exportable via MQTT (refer to the Manual for details)
* **JK‑PBx BMS‑ID**
  * Fix: Previously JK-PBx BMS-ID=1 was hard-set on fw. Now is fully customizable.
  * Introduced graphical configuration of the BMS‑ID on Settings->MISC (dip‑switches view)
* **HOME ASSISTANT DISCOVERY**
  * Home Assistant Discovery mode now fully supported
  * HA automatically discovers all parameters exposed by the dongle via MQTT
* **FIXES**
  * Fix: Race condition with MQTT MOS Management causing unpredictable publish timing
  * Fix: MQTT Subscriber $\rightarrow$ BALANCE MOS now working correctly
  * Fix: MQTT Subscriber $\rightarrow$ multiple MOS Switch status updates now handled properly

### 3.5.2 released on 25 Apr 2026

* **MQTT SUBSCRIBER**
  * Rewrote the full MQTT subscribing Procedure to make it safer and more efficient
* **MQTT SWITCH**
  * Added BALANCE SWITCH from MQTT
* **IOTMQTT PANEL**
  * New IoTMQTT Panel template - ADD Balance Switch and Virtual UART setup
* **VIRTUAL UART**
  * Now Virtual UART works as MASTER or CLIENT
  * as MASTER - the remote Virtual UART end point connect to the dongle IP:PORT
  * as CLIENT - the dongle connects to remote UART TUNNEL SERVER via its own IP/HOSTNAME:PORT
* **NEW BATTERY MONITOR**
  * MONITOR TAB now logs at the BMS Polling pace, the Power, SOC, delta Volt and Vbat

### 3.5.1 released on 08 Mar 2026

* **CHART BATTERY & MONITOR**
  * Fix Charts not loaded
  * added New info exported on Charts: Delta Voltage, MIN-MAX over the series, detailed views
* **BMS PROTOCOL**
  * Fix JK-Bx reporting wrong remaining battery capacity
* **MODBUS SERVER**
  * Exporting Vmin and Vmax - offset 6 and 7 UINT16 - see manual v 3.5.1

### 3.5.0 released on 28 Feb 2026

* **BMS PROTOCOL**
  * New architecture based on full C++ classes to easily support new protocols
  * JK BMS now supports the following protocols:
    * -000 – 4G‑GPS Remote Module, Common Protocol V4.2
    * -001 – JK BMS RS485 Modbus V1.0
    * *NOTE: Protocol 001 is recommended for JK‑PBx users, as it enables JK‑BMS‑MONITOR to work remotely via the Virtual UART feature*
* **WEBPAGES**
  * Restyling and HTML/CSS/JavaScript fixes
  * + Added a new simple method to select plant coordinates
  * + Added a new Settings tab showing weather and solar radiation
* **CAPTIVE PORTAL**
  * When the dongle is in Factory Mode, it starts as an AP without a password for faster setup
* **VIRTUAL UART**
  * Completely redesigned Virtual UART engine and web interface
  * **DALY BmsMonitor and JK JK‑BMS‑MONITOR** PC software supported
  * When Virtual UART is enabled, you can use the PC software to manage the battery pack over the Internet
* **MQTT**
  * + Added extra information published via MQTT — see the MQTT page for details
* **NOTIFICATIONS**
  * + Overvoltage alarms are no longer sent via push notifications when SOC > 98%

### 3.4.2 released on 22 Dec 2025

* **MQTT**
  * Even without BMS data communication an MQTT packet is sent
  * `{"Status":1,"ts":"12/14/25 08:12:13","cnt":155,"mem":10584}`
  * See the manual for a complete description of the MQTT parameters published
* **CAPTIVE PORTAL**
  * In Factory mode the dongle works as Access Point without Password
  * Captive Portal page now is part of the main binary
* **Global Improvements**

### 3.4.1 released on 26 November 2025

* **CAPTIVE PORTAL**
  * Fixed bug on Captive Portal
* **AUTO FIRMWARE UPDATE**
  * Fixed a bug during download of new webpage set

### 3.4.0 released on 31 October 2025

* **CAPTIVE PORTAL**
  * Added Captive Portal for first provisioning
* **WEBPAGES**
  * + Access Point SCAN feature
  * + check button to show Passwords
* **AUTO FIRMWARE UPDATE**
  * Enhanced with Auto upgrade of Web Pages set
  * + Enable button added on MISC page
* **DALY BMS**
  * SET Current SOC* on MISC page added
  * *DALY Only*
* **ONBOARD OLED DISPLAY**
  * Added LCD Page with Status of Active services
* **TASMOTA COLOR MQTT/MODBUS DISPLAY**
  * Support for Display 3.5" ESP32-035 fully managed
* **CURRENT MONITOR**
  * To save memory needed to reduce the time windows to 8h (24h before)

### 3.3.0 released on 28 August 2025

* **NTP improvement**
  * tnx to user David from Italy, a bug on Network Time Server lib has been found and fixed
* **HTTP PORT**
  * now HTTP Server Port 80 is selectable from Settings page
  * NOTE: New Default HTTP Port is 80 ( formerly 6789 )
* **MODBUS Client**
  * tnx to user IONUT Romania, MODBUS Client has been added and debugged
  * Configuration through file **"ModBusClient.json"**
  * Instruction on the webpage "ModBus"
* **ONBOARD OLED DISPLAY**
  * NodeMCU with OLED Display now supported. Need HW changes, see the manual!
* **AUTO FIRMWARE UPDATE**
  * Latest FW available checked at boot time - if present, self upgrade
* **NOTIFICATION**
  * New "Filter" added to avoid ALARMS+SOC 100 are sent at the same time
  * PUSHSAFER now send also the remaining number API TOKEN
* **UART TUNNEL**: Fix Virtual tunnel to allow PC Sw to remotely manage the BMS
* **TASMOTA COLOR MQTT/MODBUS DISPLAY**
  * AUTOCONFIG: copy the dongle's "config.txt" file on the Tasmota's file system
  * POWER CHART: from Display page, select if Chart are enabled and the Time Windows duration
   * NOTE: TASMOTA DISPLAY with **PSRAM** is mandatory especially for time windows > 1h

### 3.2.4 released on 16 June 2025

* **MODBUS**
  * New Registers to support MODBUS Remote Color Display
  * details on the dongle's MODBUS page
* **NOTIFICATION**
  * New "Time Filters" on Alarms to avoid the same alarm is sent multiple times
* **COLOR DISPLAY MODBUS**
  * Now Tasmota Color display support MODBUS and MQTT ( also in parallel )
  * Tasmota MODBUS is perfect for Dongle-to-Display Point 2 Point or for ModBus Lovers

### 3.2.3 released on 01 May 2025

* + Improved stability : WDT Reset in case of long MQTT connection time
* + Addressed crash at boot time: new switch-on services sequence added
* + Added Time Zone Management *Thanks to Kyle Australia for debugging*
* + Fixed MODBUS SWAP BYTE issue
* + Added PUSHSAFER now is working for daily-reports with free license
* + Added PUSHOVER Service - similar to PUSHSAFER with 10K free messages to mobile *Thanks Jean Germany*
* + Added on JK layout added Battery Remaining Ah *Thanks to Theo Greece asking*
* + Added MQTT PREFIX for NON Json export - mode **Flat1**
* **COLOR DISPLAY**
  * + Added "DashBoard NAME" Exported for TASMOTA remote display & on main web page
  * + Added Display Brightness and multi page rolling timing settings
  * + Added Dongle export its "Time Zone" to TASMOTA display
  * + Rewritten from scratch a new TASMOTA autoexec.be configuration file now supporting dynamic configuration

### 3.2.2 released on 25 Feb 2025

* + Add selection of time format 24h/12h
* **COLOR DISPLAY**
  * + Add support of TASMOTA based MQTT Color Display

### 3.2.1 released on 05 Jan 2025

* + Fixed Race Condition on MQTT with very fast Publish time

### 3.2.0 released on 04 Jan 2025

* + Platform Architecture partially reviewed to gain memory
* + WebSocket introduced on BMS pages to avoid old style web page refresh
  * $\rightarrow$ BMS data web page is refreshed every 5s
* + WebServer HTTP PORT now customizable on "Settings" page
* **COLOR DISPLAY**
  * + Fixed openHASP generated page to avoid to jump nowhere when touching the screen
* **LCD DISPLAY ON BOARD *EXPERIMENTAL***
  * + added support for I2C LCD on board

### 3.1.0 released on 23 Nov 2024

* + REMOTE MQTT DISPLAY based on openHASP config file generator & Manuals
* + CHARGE-DISCHARGE MOS SETTINGS from WebPage and MQTT
  * Note: Enable this feature from MISC page - iotMQTT Panel users need to REgenerate and import Json file
  * Note: MQTT Mos status is checked every 30s or at half of the MQTT Publish time
* + MODBUS TCP SWAP BYTES on float 32
  * added ALERT on main web page about “NEW FIRMWARE AVAILABLE”
* + on MISC the possibility to NOT check the RESET button to avoid self restore to factory due to missing energy
* + support of RS485 Transceiver Enable signals for JK PB2
* + control on MQTT publish time vs BMS Polling time to avoid race conditions
* * fixed (again :-( ) JK cycle counting
* + improved robustness on file system management

### 3.0.8 released on 14 Sept 2024

* * fixed: Type2 MQTT-export reported as unfunctional - THANKS: to Rolf H.- Germany - for bug discovery & reporting
* * fixed: Cycle Counter for JK BMS reported as always 0 - THANKS: to Georg K.- Hungary - for bug discovery & reporting
* + on "/config" page added the possibility to edit the Host Name - useful in case of multiple dongles on the same network
  * use ping HostName or ping HostName.local ( where HostName is the Host name you set )
* + on "/config" page added WiFi signal strength in Station mode

### 3.0.7 released on 10 Sept 2024

* * fixed: Restore to Factory feature broken
* ++NOTE++ : users with rel 3.0.6 needs to use the Serial Console to Restore to factory
* THANKS: to Georg K.- Hungary - for bug discovery & reporting

### 3.0.6 released on 07 Sept 2024

* * fixed: wrong race condition can lead to system crash

### 3.0.5 released on 15 Aug 2024

* * fixed: Free SW had trouble getting BMS fresh data
* THANKS: to edbu10 - Germany - for sw bug discovery

### 3.0.4 released on 04 Aug 2024

* * fixed deadlock after Restore to Factory
* THANKS to Gianluca -Italy- for testing new DALY (small connector) reporting full compatibility

### 3.0.3 released on 03 Aug 2024

* + Platform changes to enable remote licensing
  * $\rightarrow$ free platform is full functional with limited BMS/MQTT/ModBUS TCP polling/publishing time and no PUSHSAFER services
* + General improvement on platform stability and available memory
* + DALY protocol re-written from scratch - lighter, quicker and better
* + Added Newer DALY protocol selectable from MISC web page
* THANKS: to Paul S. -Germany- for remote debugging on his platform

### 2.1.4 released on 06 June 2024

* * fixed some webpage check-buttons were not reporting the real state of the setting (introduced with 2.1.3 )
  * thanks to user Paolo G. for testing and trouble reporting
* + on MISC page added 3 new settings:
  * $\rightarrow$ MidNight Dongle Self Reboot
  * $\rightarrow$ Wireless Link missing Self Reboot
  * $\rightarrow$ Switch between DALY and JK webpage Layout
* + added new controls on PushSafer in case of Push TX issue
* + improvements on file system management
* + added link to website to get access to configuration procedures

### 2.1.3 released on 25 May 2024

* + PUSHSAFER username field to get access to #of Push credits
* + RESET BUTTON now acts as:
  * $\rightarrow$ **Switch to AP mode** : Press RESET Button 3 times - **after each press wait about 5s till blue led quick blink**
  * $\rightarrow$ **Restore to Factory default** : Press RESET Button 6 times - **after each press wait about 5s till blue led quick blink**
* + New Blue LED mimic: Slow Blinking = STATION MODE // quick Blinking = AP Mode
* + Added the possibility to download all the .CSV files for the selected month at once
* + clicking on the weather you access the 1w forecast

### 2.1.2 released on 11 May 2024

* * fixed - PushSafer Fix multiple alarm push sent very close

### 2.1.1 released on 08 May 2024

* + added new MODBUS TCP registers
* + added new Service PUSHSAFER
* x to improve AP interoperability - removed WiFi Sleep mode
* * fixed - Virtual console timeout
* = experimental - emails manager for daily reporting

### 2.1.0 released on 14 Apr 2024

* + added MODBUS TCP on port 502
* * fixed Json Topic length increased to 19 chars - *thanks to Ross M. for reporting the limit*
* x to improve AP interoperability - WiFi is now set to G Mode only

### 2.0.7 released on 30 Mar 2024

* + added the following AT commands

| Command | Description |
| :--- | :--- |
| `AT+WPORT=port` | SET WebServer HTTP Port default port **6789** |
| `AT+WPORT?` | GET WebServer HTTP Port |
| `AT+WPWR=dBm` | SET WiFi power in dBm 0-20 , default 15dBm |
| `AT+WPWR?` | GET WiFi power in dBm |

* + added BONJOUR/mDNS $\rightarrow$ ping **smartbms** , return the IP of the dongle
* + added BONJOUR/mDNS $\rightarrow$ http://**smartbms**:6789 (or your PORT) access to web pages
* + added EXPERIMENTAL export of json config file for IoTMQTT Panel APP for IoS and Android
* - removed access to "fileSystem" upload to avoid from / catastrophic upload on field

### 2.0.6 released on 20 Mar 2024

* + After "Factory Reset" dongle starts as Access Point
  * SSID : **dalyBMSWiFi.com** , password: **123456789** default IP: **192.168.0.1**
  * connect to AP and configure as you wish.
  * **NOTE1**: this works as an alternative to UART AT Command Console
  * **NOTE2**: to Restore to Factory default, either you use UART AT Command or the "Settings" web page
* + Time Zone automatically detected through the geo Coordinates. No need to adjust TZ any longer in STA mode
* + Anomaly detection triggered on MQTT failures
* @ Experimental : adding "/IoTMQTTPanel" to url it generates a JSON config file to be used with IoTMQTTPanel Android app
* * Fix : MQTT dynamic memory allocation

### 2.0.5 released on 08 Mar 2024

* + multiple type of MQTT Json export added with webpage showing different configurations
* + main MQTT Json TOPIC editable
* + FULLY Functional with JK-BMS UART (GPS) tested on JK-B2AxxS-15P : standing to JK protocol docs it works also with
  * JK-BD6AxxS-10P / JK-BD6AxxS-12P / JK-BD6AxxS-15P/ JK-B1AxxS-15P / JK-B2AxxS-15P/ JK-B2AxxS-20P
* * Fix: JSON MQTT limit on parameter length
* + Added MQTT Connection-Test Button
* + Added fixes and patched to MQTT Library to make it more robust
* * Fix: DALY $\rightarrow$ now working with odd battery number ( Thanks to Elio form SARDEGNA )
* * Fix: View of Stored Battery files not working with odd number of batteries

### 2.0.4 released on 17 Feb 2024

* + WiFi output power on "Config" page
* **NOTE:** if you notice missing PING to the dongle try to LOWER the output power - No reboot needed

### 2.0.3 released on 16 Feb 2024

* * Fix wrong conversion on pack watts
* + web.all file cannot be accidentally loaded from "upgrade page"

### 2.0.2 released on 15 Feb 2024

* + Added MQTT Json flag on MQTT config page
```json
{
  "bat": {
    "0": 2947,
    "1": "...",
    "15": 2949
  },
  "SOC": 27,
  "PWT": 42,
  "PMV": "47.10",
  "PMA": "0.90",
  "PDV": 6,
  "AMV": "2946.00",
  "TMP": 10,
  "ALM": "0,0,0,0,0,0,0"
}
```
* NOTE: due to limited memory NOT all the parameters can be exported at the same time

### 2.0.1

* * Fixed Involuntary DISCHARGE MOSFET OFF at startup

### 2.0.0 released on Feb 11 2024

* * Fixed - weather forecast
* * Fixed wrong file name "batt_"
* + New SW structure now supporting DALY-BMS and JK-BMS
* + BMS data polling and MQTT publish time now selectable from 5s to 300s
  * NOTE: Suggested settings are : BMS polling time 60s - MQTT Publish time 60s
  * NOTE: JK BMS needs only 0.35s for a full data request WHILE DALY needs about 0.9s ! don't stress this poor machine too much ;-)
* + Static IP settings on config page
* + Backup file are automatically removed
* + JSON MQTT *beta*

### 1.10.0 Internal release

* + 600% speed up web pages with 24h log

### 1.9.0 released on dec 29th 2023

* + Added possibility to Select Secure MQTT TLS or Insecure via WebPage . Not Secure tested with Mosquitto
  * NOTE !!! a reboot is needed everytime the TLS checkmark changes. May be fixed on next release
* * Fix a problem on getting current battery package Watt
* * Fix memory leakage during file upload
* + Virtual UART Tunnel for remote PCMaster - Inactivity timeout increased to 90s (was 60 )
* + possibility to Clock Sync from web page - needed in case of AP (stand alone) mode without internet connection
* + lightTime delta duration vs previous day :-)
* + when in AP mode - user can change default AP password "123456789" from "AT+PWD=" command or from web page
  * AP password will be the same used for Station mode.
* + AT+WMODE command automatically triggers a SAVE & REBOOT

### 1.8.0 released on dec 21th 2023

* + auto recovery of current graph in case of reboot or missing energy .
  * last available "today" battery samples are taken and load in memory.
* * fixed missing BMS get samples

### 1.7.0 release on dec 11th 2023

* + 6 months daily storage of Batteries + SOC- rolling $\rightarrow$ old files are removed
  * + list of "batt_" files on SETTINGS->FILE CONFIG page
    * + download as .csv
    * + show as html graph
* + auto export of each battery+SOC every 20minutes
* + Access Point mode for stand alone installation: SSID dalyBMSWiFi.com - PWD 123456789 def.IP : 192.168.0.1
  * + AT+WMODE?
  * + AT+WMODE=STA or AP ( + AT+SAR )
* + MQTT is disconnected between publish to avoid memory issues

#### 1.7.0 KNOWN Issues/bugs
1. in AP mode there's no way to set the current time $\rightarrow$ fixing ready on rel 1.8.0
2. MQTT Connection Status on SETTINGS->MQTT is refreshed after 1 minute from the set $\rightarrow$ fixing on rel 1.8.0

### 1.6.0 release date nov 19th 2023

* + Virtual Console to remotely access to BMS via DalyBmsMonitorV1.1.5
* + Added Virtual Console enable button on MISC page. Default port : 6790
  * Virtual com used : [HW VSP3 Single v3.1.2](https://www.hw-group.com/software/hw-vsp3-virtual-serial-port)

### 1.5.0 release date sept 29th 2023

* + Fixed Graph dates
* + html layout pages changed with top TAB selection
* + Graph length depends on configuration to save memory
* + Added console active on the first 15s to support out of the box config : 57600,8,N,1

| Command | Description |
| :--- | :--- |
| `AT+SCAN?` | Scan AP in the range |
| `AT+SSID?` | GET AP's SSID |
| `AT+SSID=myAPSSID` | SET AP SSID |
| `AT+PWD?` | GET AP's passphrase |
| `AT+PWD=myAPPasspherase` | SET AP passpharse |
| `AT+STAT?` | GET WiFi Connection Status + IP and MAC |
| `AT+SYSUSR=systemUser` | SET Protected Pages username default="**admin**" |
| `AT+SYSPWD=systemPassword` | SET Protected Pages password default="admin!" |
| `AT+SAR` | COMMAND : Save and Reboot |
| `AT+FACTORY` | COMMAND : Restore to factory defaults |
| `AT+CMD` | COMMAND : List all the available commands |

* **NOTE**: each AT command MUST end with 0x0D 0x0A ( `<CR><LF>` )
* + MQTT configuration exported on config page
* + add FILE MANAGER webpage to download/upload the config.txt file

### 1.4.0 release date Aug 1st 2023

* + added watch-dog ping to default gateway, reset after failures

### 1.0.0 release date July 3rd 2022
