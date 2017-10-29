-- server listens on 5000, if data received, print data to console and send "hello world" back to caller
-- 30s time out for a inactive client
sv = net.createServer(net.TCP, 30)

function receiver(sck, data)
  print(data)
  sck:close()
end

if sv then
  sv:listen(5000, function(conn)
    conn:on("receive", receiver)
    conn:send("hello world")
  end)
end