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

puts " [x] Waiting for data. To exit press CTRL+C"

begin
  q.subscribe(block: true, manual_ack: true) do |delivery_info, properties, body|
    response = JSON.parse(body)
    solution = eval(response['formula'])

    send ={
      'uuid' => response['uuid'],
      'contestant_uuid'=> "86ac3491-8257-11e4-9f42-0242ac110016",
      "formula" => response['formula'],
      "solution" => solution
    }.to_json
    p send
    x.publish(send, routing_key:'formula_solution')
  end
rescue Interrupt => _
  ch.close
  conn.close
end
