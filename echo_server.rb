require "socket" # classes for creating servers

server = TCPServer.new("localhost", 3003) # vytvoří server (TCP je vrstva pod http)
                                          # .. který reaguje na requests to localhost
                                          # .. = s hostname localhost

loop do
  client = server.accept  # vytvoří connection (vrací socket object) poté co někdo
                          # .. zadá request

  request_line = client.gets # zachytíme request
  client.puts "HTTP/1.1 200 OK\r\n\r\n"  # musíme vrátit (aby nehlásil chybu, toto je povinné)
  puts request_line # vytiskneme request na terminál

  client.puts request_line # pošleme text klientovi
  client.close   # zavřeme socket pro tento konkrétní request
end