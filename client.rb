require 'bunny'
require 'pry'
require 'json'

user = 'admin'
pass = '1Le6VZsVsSpY'
host = 'rabbitmq-1.45c4208d-bmoyles0117.node.tutum.io'
port = 5672

conn = Bunny.new(
  host:     host,
  user:     user,
  password: pass,
  port:     port
  )

conn.start

ch  = conn.create_channel
x   = ch.direct('amq.topic', durable: true)
q   = ch.queue('rjrobinson')
q.bind(x, routing_key: 'formula')
binding.pry
puts " [x] Waiting for data. To exit press CTRL+C"
begin
  q.subscribe(block: true) do |delivery_info, properties, body|
    p " [x] #{delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end
