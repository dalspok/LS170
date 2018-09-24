require "socket"

server = TCPServer.new("localhost", 3003)

loop do
  client = server.accept
  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  p request_line
  http_method, path_raw, protocol = request_line.split(" ")
  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html><body>"
  client.puts "<h1>DICES</h1>"
  params = path_raw.split("?")[1].split("&")
  params = params.map {|pair| pair.split("=")}.to_h

  params["rolls"].to_i.times {client.puts "<h2>#{rand(params["sides"].to_i) + 1}</h2>"}
  client.puts "</body></html>"
  client.close
end