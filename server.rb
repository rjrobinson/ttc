# require 'bunny'
# require 'json'
# require 'sinatra'
#
# host = 'rabbitmq-1.45c4208d-bmoyles0117.node.tutum.io'
# pass = '1Le6VZsVsSpY'
# port = 5672
# user = 'admin'
#
# conn = Bunny.new(
# host:     host,
# password: pass,
# port:     port,
# user:     user
# )
#
# conn.start
#
# ch  = conn.create_channel
# x   = ch.direct('amq.topic', durable: false, auto_delete: true)
# q   = ch.queue('rjrobinson')
# q.bind(x, routing_key: 'formula', auto_delete: true)
#
# puts ' [x] Waiting for data. To exit press CTRL+C'
#
# def get_answer(string)
#   elements = string.split(' ')
#   answer = elements.shift.to_i
#   while elements.length > 0
#     elements.shift == '+' ? answer += elements.shift.to_i : answer -= elements.shift.to_i
#   end
#   answer
# end
#
# #############
# # ROUTES
# #############
# get '/' do
#   'Hello World. RJ Robinson'
# end
#
#
# begin
#   q.subscribe(block: true, manual_ack: true) do |delivery_info, properties, body|
#     response = JSON.parse(body)
#
#     send ={
#       'uuid' => response['uuid'],
#       'contestant_uuid'=> '86ac3491-8257-11e4-9f42-0242ac110016',
#       'formula' => response['formula'],
#       'solution' => get_answer(response['formula'])
#     }
#
#     x.publish(
#     JSON.generate(send),
#     routing_key: 'formula_solution'
#     )
#     ch.ack(delivery_info.delivery_tag)
#   end
# rescue Interrupt => _
#   ch.close
#   conn.close
# end
