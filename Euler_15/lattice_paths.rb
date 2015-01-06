def lattice_path(deep)
	path = [1,1]

	(1+2*(deep-1)).times do
		new_path = []
		size = path.count
		(1..size-1).each do |i|
			new_path << (path[i-1]+path[i])
		end
		new_path.unshift(1)
		new_path.push(1)
		path = new_path
	end
	return path
end

puts lattice_path(20).max


