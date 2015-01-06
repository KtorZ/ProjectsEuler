def eratosthene(grid)
	current = 0;
	while grid[current] < grid.count
		grid.select!{|n| grid[current] == n || n % grid[current] != 0}
		current = grid.index(grid[current])+1
	end
	return grid
end

grid = eratosthene((2..2000000).to_a)
sum = 0
grid.each{|n| sum += n}
puts sum