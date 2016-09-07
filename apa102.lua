
apa102.write(2,3,string.char(5,0,0,32):rep(120))

function glowLeds()

   -- get brigter then darker by 20%
      luminance_inc = 0.20
      luminance_dec = -0.20
 ""

     for i=1,100 do   
         g = (math.ceil(math.min(math.max(0, g + (g * luminance_inc)), 255)))
         r = (math.ceil(math.min(math.max(0, r + (r * luminance_inc)), 255)))
         b = (math.ceil(math.min(math.max(0, b + (b * luminance_inc)), 255)))
   
         apa102.write(2,3, string.char(a,b, g, r):rep(num_leds))       
     end
     
  --[[   for i=1,100 do   
        g = (math.ceil(math.min(math.max(0, g + (g * luminance_dec)), 255)))
      r = (math.ceil(math.min(math.max(0, r + (r * luminance_dec)), 255)))
      b = (math.ceil(math.min(math.max(0, b + (b * luminance_dec)), 255)))

      apa102.write(2,3, string.char(a,b, g, r):rep(num_leds))        
    end
 --]]

end



 local espress = require 'espress'
 local port = 80
  -- Initialize a server creation (lazy)
 local server = espress.createserver()
  -- Declare desired plugins one by one
  -- syntax is server:use("plugin" [, opts)
  --server:use("auth_api_key.lc", {apikey = "1234-abcd", includes = "/api"})
  server:use("routes_auto.lc")
  server:listen(port)






