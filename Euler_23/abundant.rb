
max = 28123

# def sum_factors(n)
# 	s = 0; d = 1;
# 	while d <= n/2
# 		s += d if n % d == 0
# 		d+=1
# 	end
# 	return (if s > n then n else nil end)
# end

# abundants = []
# for i in 1..max
# 	a = sum_factors i
# 	abundants << a unless a.nil?
# end


# puts "abundants finded"
# test = File.new("test", "w");
# test.puts abundants.inspect
# test.close

abundants = File.new("test", "r").readlines[0].delete("[]").split(",").map{|a| a.to_i}

written = []

abundants.count.times do
	head = abundants.pop
	([head] + abundants).each do |a|
		written << a+head if a+head <= max
	end
end
written.uniq!

non_sum_of_abundant = (1..28123).to_a - written
puts non_sum_of_abundant.reduce(:+)
