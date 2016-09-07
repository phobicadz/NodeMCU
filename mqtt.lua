m = mqtt.Client("ESP1-ManCave",60000)
m:connect("adamandlindsey.co.uk", 1883, 0, function(client) end)
num_leds = 100
node_name = "home/bathroom"
pin = 3
pulse1 = 0
du = 0
gpio.mode(pin,gpio.INT)

function pin1cb(level)
  du = tmr.now() - pulse1
  print(du)
  pulse1 = tmr.now()
 http.get("https://maker.ifttt.com/trigger/tesco/with/key/dZYY0nu2ifIkgHEVW7Z-6T?value1=" .. du, nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)

 -- if level == gpio.HIGH then gpio.trig(pin, "down") else gpio.trig(pin, "up") end
end

gpio.trig(pin, "down", pin1cb)

-- setup I2c and connect display
function init_i2c_display()
    local sda = 5 -- GPIO14
    local scl = 6 -- GPIO12
    local sla = 0x3c
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g.ssd1306_128x64_i2c(sla)
end

-- graphic test components
function prepare()
--     disp:begin()
    disp:setFont(u8g.font_6x10)
    disp:setFontRefHeightExtendedText()
    disp:setDefaultForegroundColor()
    disp:setFontPosTop()
   
end

function draw(message)
    disp:setFont(u8g.font_6x10)
    disp:setScale2x2()
    disp:drawStr(0,10,message)
end

function display(message)
  disp:firstPage()
  repeat
       draw(message)
  until disp:nextPage() == false      
end

init_i2c_display()

display("IP is " .. wifi.sta.getip())

m:on("connect", 
function(client) 

    -- subscribe to the required topics
    m:subscribe(node_name .. "/ledcolour",0)
    m:subscribe(node_name .. "/ledcolourglow",0)
    
    tmr.alarm(0, 30000, tmr.ALARM_SEMI, function()
        tmr.start(0)
        pin = 4
        status, temp, humi, temp_dec, humi_dec = dht.read(pin)
        if status == dht.OK then
            -- Float firmware using this example
            print("Temperature:"..temp..";".."Humidity:"..humi)
            display(temp)
            t = {}
            t["temp"]  = temp
            t["humidity"] = humi
            m:publish(node_name .. "/temp",cjson.encode(t),0,1)
            
        elseif status == dht.ERROR_CHECKSUM then
            print( "DHT Checksum error." )
        elseif status == dht.ERROR_TIMEOUT then
            print( "DHT timed out." )
            display("timed out.")
        end
    end) 
  end)

m:on("offline", function(client)

print("offline") 
m:connect("adamandlindsey.co.uk", 1883, 0, function(client) end)

end)

-- led colour message
m:on("message", function(client, topic, data) 

 print("Message for you Sir")

 if topic == node_name .. "/ledcolour" then
    -- tonumber('0xFF')
     g = tonumber('0x' .. string.sub(data,4,5))
     r = tonumber('0x' .. string.sub(data,2,3))
     b = tonumber('0x' .. string.sub(data,6,7))

     display(data)
     
    if data == "red" then
        ws2812.writergb(4, string.char(0, 255, 0):rep(num_leds))
    elseif data =="blue" then
        ws2812.writergb(4, string.char(0, 0, 255):rep(num_leds))
    elseif data =="green" then
        ws2812.writergb(4, string.char(255, 0, 0):rep(num_leds))
    else
        ws2812.writergb(4, string.char(g, r, b):rep(num_leds))
    end
 end

 if topic == node_name .. "/ledcolourglow" then
      -- get brigter then darker by 20%
      luminance_inc = 0.002
      luminance_dec = -0.002
         -- tonumber('0xFF')
     g = tonumber('0x' .. string.sub(data,4,5))
     r = tonumber('0x' .. string.sub(data,2,3))
     b = tonumber('0x' .. string.sub(data,6,7))

     for i=1,100 do   
         g = (math.ceil(math.min(math.max(0, g + (g * luminance_inc)), 255)))
         r = (math.ceil(math.min(math.max(0, r + (r * luminance_inc)), 255)))
         b = (math.ceil(math.min(math.max(0, b + (b * luminance_inc)), 255)))
   
         ws2812.writergb(4, string.char(g, r, b):rep(num_leds))       
     end
     for i=1,100 do   
         g = (math.ceil(math.min(math.max(0, g + (g * luminance_dec)), 255)))
         r = (math.ceil(math.min(math.max(0, r + (r * luminance_dec)), 255)))
         b = (math.ceil(math.min(math.max(0, b + (b * luminance_dec)), 255)))

        ws2812.writergb(4, string.char(g, r, b):rep(num_leds))        
     end
 end
end

)
