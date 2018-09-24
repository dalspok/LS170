require "socket"

server = TCPServer.new("localhost", 3003)

def parse_input(request_line)
  http_method, path_raw, protocol = request_line.split(" ")
  return {} unless path_raw.split("?")[1]
  params = path_raw.split("?")[1].split("&")
  params.map {|pair| pair.split("=")}.to_h
end

loop do

  client = server.accept
  request_line = client.gets
  next if !request_line || request_line =~ /favicon/

  p request_line
  params = parse_input(request_line)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html><body>"
  counter = params["counter"].to_i || 0
  client.puts "<h1>#{counter}</h1>"
  client.puts "<p><a href = \"?counter=#{counter + 1}\">increase</a></p>"
  client.puts "<p><a href = \"?counter=#{counter - 1}\">decrease</a></p>"
  client.puts "</body></html>"
  client.close
end