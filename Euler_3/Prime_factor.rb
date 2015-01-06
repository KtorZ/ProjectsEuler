def eratosthene(grid)
	current = grid[0];
	while current < grid.max
		grid.select!{|n| current == n || n % current != 0}
		current = grid[grid.index(current)+1]
	end
	return grid
end

def factors(number, primes)
	divisors = []
	while !primes.empty?
		divisor = primes.shift
		while number % divisor == 0
			number = number / divisor
			divisors << divisor
		end
	end
	return divisors
end
primes = eratosthene((2..775147).to_a)
puts "Primes computed..."
puts factors(600851475143, primes).max