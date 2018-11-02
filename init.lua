wifi.setmode(wifi.STATION)
-- Replace here with your wifi config
wifi.sta.config("xxxx", "xxxx")
wifi.sta.connect()
print("---------------------------")
print("Connecting to Wifi")
tmr.alarm(1, 1000, 1, function()
 if wifi.sta.getip() == nil then
  print("IP unavailable, Waiting...")
 else
  tmr.stop(1)
  print("MAC address is: " .. wifi.ap.getmac())
  print("IP is " .. wifi.sta.getip())
  print(node.heap())

 dofile("apa102.lua")
 end
end)


 -- Compatibility: Lua-5.0
function Split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end
