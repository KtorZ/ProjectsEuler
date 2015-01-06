unites = ["one","two", "three", "four", "five", "six", "seven", "eight", "nine"]
dizaines = ["twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
chiants = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]

numbers = unites.clone #1..9
numbers += chiants #10..19
dizaines.each do |dizaine|
	numbers << dizaine #20,30,40,50,60,70,80,90
	unites.each do |unite|
		numbers << dizaine+unite #21..99
	end
end 
puts numbers.count

unites.each do |centaine|
	numbers << centaine+"hundred" #100, 200, 300 ... 900
	unites.each do |unite|
		numbers << centaine+"hundredand"+unite #101..109 ... 901..909
	end
	chiants.each do |chiant|
		numbers << centaine+"hundredand"+chiant #110..119, 210...219 ... 910..919
	end
	dizaines.each do |dizaine|
		numbers << centaine+"hundredand"+dizaine #120,130..190 ... 920,930..990
		unites.each do |unite|
			numbers << centaine+"hundredand"+dizaine+unite
		end
	end 
end
numbers << "onethousand"

somme = 0
numbers.each do |n|
	somme += n.length
end
puts somme