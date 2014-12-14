require "bunny"
require "pry"
require "json"

user = "admin"
pass = "1Le6VZsVsSpY"
host = "rabbitmq-1.45c4208d-bmoyles0117.node.tutum.io"
port = 5672

conn = Bunny.new(
  host:     host,
  user:     user,
  password: pass,
  port:     port
  )

conn.start

ch  = conn.create_channel
x   = ch.direct("amq.topic", durable: true)
q   = ch.queue("rjrobinson")
q.bind(x, routing_key: "formula")

ch.prefetch(1)

puts " [x] Waiting for data. To exit press CTRL+C"
finish = Time.now + 5 * 60

while Time.now < finish
begin
  n = 0
  q.subscribe(block: true, manual_ack: true) do |delivery_info, properties, body|
    response = JSON.parse(body)
    solution = eval(response['formula'])

    send =[
    response['uuid'],
    response['contestant_uuid'] = "86ac3491-8257-11e4-9f42-0242ac110016",
    response['formula'],
    solution
    ].to_json

    x.publish(send, routing_key:'formula_solution')
    n =+ 1
    p n
    binding.pry
  end
rescue Interrupt => _
  ch.close
  conn.close
end
end
