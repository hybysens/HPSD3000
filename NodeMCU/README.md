# NodeMCU example for HPSD3000

Connect NodeMCU to HPSD3000: 
* sda to --> GPIO12
* scl to --> GPIO14

NodeMCU acts as WiFi access point (AP) with SSID hybysens001 and pass wifipass123




*Communication with WiFi pressure sensor*

1. connect to WiFi sensor access point. SSID is hybysens001 and password is wifipass123: 
2. Install Android UDP Terminal application form play store:
https://play.google.com/store/apps/details?id=com.mightyit.gops.udpterminal&hl=en
 
3. Start application UDP Terminal and enter WiFi sensor UDP IP and ports: 
The Receive IP will be filled automatically with the IP address assigend by DHCP in the WiFi sensor. Use port 11000 for receiving packets and port 4096 to send packets. 

4. Assign button macros. First button will be used for requesting the pressure channel request and second button will be used for temperature channel request: 
 
5. Now press the »Press« or »Temp« button to receive the readouts. 
  
*Custom applications to get the readouts* 
6.	Pressure channel: 
send ascii 80(dec), capital letter »P«, followed by ascii 10(dec), LineFeed

7.	Temperature channel: 
send ascii 84(dec), capital letter »T«, followed by ascii 10(dec), LineFeed

Use port 4096 for sending packets to the NodeMCU. 
IP address of the sensor is 192.168.199.1 (see the LUA source code)
Use port 11000 for receiving UDP packets with the readouts from the sensor. 

For more details check the PDF file: 
https://github.com/hybysens/HPSD3000/raw/master/NodeMCU/UDP%20Communication%20with%20WiFi%20pressure%20sensor%20NodeMCU.pdf
