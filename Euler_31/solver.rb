start = Time.now

$coins = [1,2,5,10,20,100,200]

max = 8

def decomp(number)
	result = []
	$coins.select{|n| n <= number[0]}.each do |coin|
		result << [number[0]-coin, (number[1]+[coin]).sort]
	end
	return result
end


computed = []
remaining = [[max, []]]
while !remaining.empty?
	temp = []
	remaining.each do |n|
		temp += decomp(n)
	end

	computed.uniq!

	computed += temp.select{|n| n[0] == 0}
	remaining = temp - computed
end
p computed 
puts computed.count

puts "====="
puts ((Time.now-start)*1000).to_s+"ms"