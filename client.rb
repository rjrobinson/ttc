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
x   = ch.direct("amq.topic", durable: false, auto_delete: true)
q   = ch.queue("rjrobinson")
q.bind(x, routing_key: "formula")

puts " [x] Waiting for data. To exit press CTRL+C"

def get_answer(string)
  elements = string.split(' ')
  answer = 0
  last_op = '+'
  elements.each do |e|
    if e == '+'
      last_op = e
    elsif e == '-'
      last_op = e
    else
      if last_op == '+'
        answer += e.to_i
      else
        answer -= e.to_i
      end
    end
  end
  return answer
end

begin
  q.subscribe(block: true, manual_ack: true) do |delivery_info, properties, body|
    #convert to JSON
    response = JSON.parse(body)
    # get the answer
    solution = get_answer(response['formula'])

    send ={
      'uuid' => response['uuid'],
      'contestant_uuid'=> "86ac3491-8257-11e4-9f42-0242ac110016",
      "formula" => response['formula'],
      "solution" => solution
    }

    p send
    x.publish(
      JSON.generate(send),
      routing_key:'formula_solution'
    )
    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  ch.close
  conn.close
end
