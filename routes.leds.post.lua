
    return function(req,res)
        local ledArray = Split(req.body,",")
        local ledString="";
  
        for i = 1,#ledArray,4
            do
                ledString = ledString .. string.char(tonumber(ledArray[i]),tonumber(ledArray[i+1]),tonumber(ledArray[i+2]),tonumber(ledArray[i+3]))
            end

        apa102.write(2,3,ledString)
        res:send("ok")
    end
