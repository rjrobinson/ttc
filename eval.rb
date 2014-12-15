beginning_time = Time.now


mathstring = '123 + 76 - 8 - 180 + 34'

1_000_000.times {eval(mathstring)}

end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
