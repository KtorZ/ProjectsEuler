def products(left, right)
	products = [];
	for i in right..999 do
		products << i*left
	end
	products += products(left+1, right+1) if left < 999
	return products
end

class Integer
	def isPalindrome?
		a_self = self.to_s.each_char.to_a.map{|i| i.to_i}
		max_coeff = a_self.count-1
		min_coeff = 0
		wrong = false;
		while min_coeff < max_coeff
			wrong ||= a_self[max_coeff] != a_self[min_coeff]
			min_coeff += 1
			max_coeff -= 1
		end
		return !wrong
	end

	def isPrime?
		return false if self < 2
		return true if self == 2
		divisor = 3
		while divisor < Math.sqrt(self)
			return false if self % divisor == 0
			divisor += 2
		end
		return true
	end
end

palindromes = products(100,100).select{|p| p.isPalindrome?}
puts palindromes.count
palindromes.select!{|p| !p.isPrime?}
puts palindromes.count
puts palindromes.max
