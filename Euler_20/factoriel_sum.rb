fact_100 = 1
(1..100).each{ |n| fact_100 *= n}

sum = 0
fact_100.to_s.each_char{|n| sum += n.to_i}

puts sum