beginning_time = Time.now


mathstring = '123 + 76 - 8 - 180 + 34'

# def get_answer(string)
#   elements = string.split(' ')
#   answer = elements.shift.to_i
#
#   while elements.length > 0
#     if elements.shift == '+'
#       answer += elements.shift.to_i
#     else
#       answer -= elements.shift.to_i
#     end
#   end
#   answer
# end

def get_answer(string)
  elements = string.split(' ')
  answer = elements.shift.to_i

  while elements.length > 0
    elements.shift == '+' ? answer += elements.shift.to_i : answer -= elements.shift.to_i
  end
  answer
end



1_000_000.times { get_answer(mathstring) }


end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"






















#
# def get_answer(string)
#   elements = string.split(' ')
#   answer = 0
#   last_op = '+'
#   elements.each do |e|
#     if e == '+'
#       last_op = e
#     elsif e == '-'
#       last_op = e
#     else
#       if last_op == '+'
#         answer += e.to_i
#       else
#         answer -= e.to_i
#       end
#     end
#   end
#   return answer
# end
