require 'pry'

mathstring = "100 + 100 - 100 + 100 + 100"


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
