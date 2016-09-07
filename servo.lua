function set_pwm_on_pins (pin1)
   -- Close off pwm on pins to free them up
   pwm.close (1)

   -- Set the pins sent in as pwm
 --  pin 1~12, IO index
--clock 1~1000, pwm frequency
--duty 0~1023, pwm duty cycle, max 1023 (10bit)
   pwm.setup (pin1, 50, 10)

   -- Start up the timer on pins
   pwm.start (pin1)

    delay_ms(1000)
   

end


function left ()

   set_pwm_on_pins (1)
   
-- pin 1~12, IO index
-- duty 0~1023, pwm duty cycle, max 1023 (10bit)
  pwm.setduty (1, 300)

   delay_ms (1000) -- Delay 500ms

end


function middle ()

   set_pwm_on_pins (1)
   
-- pin 1~12, IO index
-- duty 0~1023, pwm duty cycle, max 1023 (10bit)
 pwm.setduty (1, 250)
   delay_ms (1000) -- Delay 500ms
  halt ()
   
end


function halt()

  --  pwm.stop (1)
   pwm.close (1)

end

function delay_ms (milli_secs)
   local ms = milli_secs * 1000
   local timestart = tmr.now ( )

   while (tmr.now ( ) - timestart < ms) do
      tmr.wdclr ( )
   end
end

--delay_ms(1000)

middle()
--left()
