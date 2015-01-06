def fibonacci(prevprev, prev, limit)
	#sale
	return (if prevprev > limit then 0 else (if prevprev.even? then prevprev else 0 end) + fibonacci(prev, prevprev+prev, limit) end)
end
puts fibonacci(0, 1, 4000000)