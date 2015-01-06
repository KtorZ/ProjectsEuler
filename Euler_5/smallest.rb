class Array
	def inter(other)
		intersection = []
		(self & other).each{|n| ([self.count(n), other.count(n)].min).times{intersection << n}}
		return intersection
	end
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

def smallest(max_divisor)
	divisors = []
	primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,51,57,71]
	while max_divisor > 0
		factors = factors(max_divisor, primes.clone)
		factors_fac = []
		primes.each {|p| factors_fac << [p, factors.count(p)-divisors.count(p)]}
		factors_fac.each{|a| a[1].times{divisors << a[0]}}
		max_divisor -= 1
	end
	puts divisors.join("/")
	return lambda{|a| product = 1; a.each{|n| product *= n}; return product}.call(divisors)
end

puts smallest(20)
