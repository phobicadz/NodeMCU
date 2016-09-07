myStr0 = "Hello"
myStr1 = "Hello"
myStr2 = "Hello" -- place holders for the other lines
myStr3 = "Hello" -- place holders for the other lines
myStr4 = "Hello"
myStr5 = "Hello"
myStr6 = "Hello"
myStr7 = "Hello"

-- setup SPI and connect display
function init_spi_display()
     -- Hardware SPI CLK  = GPIO14   5
     -- Hardware SPI MOSI = GPIO13   7
     -- Hardware SPI MISO = GPIO12 (not used)
     -- CS, D/C, and RES can be assigned freely to available GPIOs
     local cs  = 8 -- GPIO15, pull-down 10k to GND
     local dc  = 4 -- GPIO2
     local res = 0 -- GPIO16
     spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, spi.DATABITS_8, 0)
     disp = u8g.ssd1306_128x64_spi(cs, dc, res)
end

function init_i2c_display()
    -- SDA and SCL can be assigned freely to available GPIOs
    local sda = 5 -- GPIO14
    local scl = 6 -- GPIO12
    local sla = 0x3c
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g.ssd1306_128x64_i2c(sla)
end

-- graphic test components
function prepare()
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
end


function draw(void) 
    prepare()
    disp:drawStr(0,0,myStr0)
    disp:drawStr(0,8,myStr1)
    disp:drawStr(0,16,myStr2)
    disp:drawStr(0,24,myStr3)
    disp:drawStr(0,32,myStr4)
    disp:drawStr(0,40,myStr5)
    disp:drawStr(0,48,myStr6)
    disp:drawStr(0,56,myStr7)
end


function loop(void) 
-- this is the loop that u8g apparently needs for display
  disp:firstPage() 
  repeat
    draw()
  until disp:nextPage() == false
 end

 

 
-- below is to set up the timer to keep hitting the display
init_i2c_display()

tmr.alarm(3,1000,1,function()   
   disp:firstPage() 
   repeat
      draw()
   until disp:nextPage() == false 
end)