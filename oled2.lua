function init_spi_display()
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


function draw()
   disp:setFont(u8g.font_6x10)
   disp:drawStr( 30, 10, "Hello IoT!")
   disp:drawStr( 20, 50, "www.jizz.com")
   disp:drawLine(0, 25, 128, 25);
   disp:setFont(u8g.font_chikita)
   disp:drawStr( 20, 40, "Bunch of Slags") 
   
end
  
function display()
  disp:firstPage()
  repeat
       draw()
  until disp:nextPage() == false      
end

init_i2c_display()

display()
