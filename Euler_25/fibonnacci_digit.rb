$fib = []
def fibonacci(prevprev, prev, n)
	$fib << prevprev
	return (if prevprev >= n then 0 else (if prevprev.even? then prevprev else 0 end) + fibonacci(prev, prevprev+prev, n) end)
end

fibonacci(1,1,10**999)
puts $fib.last.to_s.length
puts $fib.count
