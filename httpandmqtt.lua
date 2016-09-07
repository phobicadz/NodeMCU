  sk=net.createConnection(net.TCP, false)
  sk:on("receive", function(sck, c) print(sck) end )
  sk:on("connection", function(sck, c) print(sck) end )
  sk:connect(3000,"192.168.0.12")
  sk:send("GET / HTTP/1.1\r\nHost: 192.168.0.12:3000/test/example1/?fields=['Name']\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
   
