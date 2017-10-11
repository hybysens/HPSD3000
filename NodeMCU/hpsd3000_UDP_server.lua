----- Startup Access point

--- Set AP Configuration Variables ---
AP_CFG={}
--- SSID: 1-32 chars
AP_CFG.ssid="hybysens001"
--- Password: 8-64 chars. Minimum 8 Chars
AP_CFG.pwd="wifipass123"
--- Authentication: AUTH_OPEN, AUTH_WPA_PSK, AUTH_WPA2_PSK, AUTH_WPA_WPA2_PSK
AP_CFG.auth=AUTH_WPA_WPA2_PSK
--- Channel: Range 1-14
AP_CFG.channel = 6
--- Hidden Network? True: 1, False: 0
AP_CFG.hidden = 0
--- Max Connections: Range 1-4
AP_CFG.max=4
--- WiFi Beacon: Range 100-60000
AP_CFG.beacon=100

--- Set AP IP Configuration Variables ---
AP_IP_CFG={}
AP_IP_CFG.ip="192.168.199.1"
AP_IP_CFG.netmask="255.255.255.0"
AP_IP_CFG.gateway="192.168.199.1"

--- Set AP DHCP Configuration Variables ---
--- There is no support for defining last DHCP IP ---
AP_DHCP_CFG ={}
AP_DHCP_CFG.start = "192.168.199.20"
---------------------------------------

--- Configure ESP8266 into AP Mode ---
wifi.setmode(wifi.SOFTAP)
--- Configure 802.11n Standard ---
wifi.setphymode(wifi.PHYMODE_N)

--- Configure WiFi Network Settings ---
wifi.ap.config(AP_CFG)
--- Configure AP IP Address ---
wifi.ap.setip(AP_IP_CFG)

--- Configure DHCP Service ---
wifi.ap.dhcp.config(AP_DHCP_CFG)
--- Start DHCP Service ---
wifi.ap.dhcp.start()
---------------------------------------


-- Prepare UDP socket for listening on port 4096
udpSocket = net.createUDPSocket()
udpSocket:listen(4096)
udpSocket:on("receive", function(s, data, port, ip)
    --print(string.format("received '%s' from %s:%d", data, ip, port))
    if (data == "P\n") then 
     udpSocket:send(11000,ip,string.format("p=%x\n", pressure_sensor(0)))    
   end

    if (data == "T\n") then 
     udpSocket:send(11000,ip,string.format("T=%x\n", pressure_sensor(1)))   
   end
   
end)

--port, ip = udpSocket:getaddr()
--print(string.format("local UDP socket address / port: %s:%d", ip, port))

function pressure_sensor(param)
    id  = 0
    sda = 6  -- GPIO12
    scl = 5  -- GPIO14
    
    -- initialize i2c, set pin1 as sda, set pin2 as scl
    i2c.setup(id, sda, scl, i2c.SLOW)
    
    i2c.start(id)
    i2c.address(id, 0x78, i2c.RECEIVER)
    p = i2c.read(id, 2)
    t = i2c.read(id, 2)
    i2c.stop(id)
    
    press = string.byte(p,1)*256+string.byte(p,2)
    temp = string.byte(t,1)*256+string.byte(t,2)
    
    --print(string.format('p=%x \t T=%x',press,temp))
    if (param == 0) then return press end
    if (param == 1) then return temp end
end
