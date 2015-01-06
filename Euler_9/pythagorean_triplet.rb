def find_triplet(max)
	sum_squared = []
	(1..max/2).to_a.each do |i|
		(i..max/2).to_a.each do |j|
			c = Math.sqrt(i**2 + j**2)
			sum_squared << [i,j,c.to_i] if c - c.floor == 0
		end
	end
	return sum_squared.select{|a| a[0]+a[1]+a[2] == 1000}.first
end

puts find_triplet(1000).join(",")