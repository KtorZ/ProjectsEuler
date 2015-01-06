def eratosthene(grid)
	current = grid[0];
	while current < grid.max
		grid.select!{|n| current == n || n % current != 0}
		current = grid[grid.index(current)+1]
	end
	return grid
end

grid = eratosthene((2..120000).to_a)
puts grid[10000]
