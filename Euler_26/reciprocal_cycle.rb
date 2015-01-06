
def cycle(n)
	str = n.to_s
	
	current = []
	str[0..str.length].each_char.reverse_each do |c|
		c = c.to_i
		current << c
		return current[0..(current.count/2 -1)] if current == current[0..(current.count/2-1)]*2
	end

	return current
end


cycles = []
(2..1000).each do |d|
	n = 10**1999/d
 	cycle = cycle(n)
 	cycles << [d, cycle] unless cycle.empty?
end

file = File.new("ouputs", "w")
cycles.each do |c|
	file.puts c[0].to_s+"~ "+c[1].join("")
end


max = 0
i_max = 0
cycles.each do |c|
	if c[1].count > max
		max = c[1].count
		i_max = c[0]
	end
end
puts max
puts i_max