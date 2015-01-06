sum_square = 0
square_sum = 0
(1..100).each do |i|
	sum_square += i*i
	square_sum += i
end
puts square_sum**2-sum_square