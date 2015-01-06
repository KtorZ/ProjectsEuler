data = "5616185650518293 ;2 correct 
3847439647293047 ;1 correct
5855462940810587 ;3 correct
9742855507068353 ;3 correct
4296849643607543 ;3 correct
3174248439465858 ;1 correct
4513559094146117 ;2 correct
7890971548908067 ;3 correct
8157356344118483 ;1 correct
2615250744386899 ;2 correct
8690095851526254 ;3 correct
6375711915077050 ;1 correct
6913859173121360 ;1 correct
6442889055042768 ;2 correct
2321386104303845 ;0 correct
2326509471271448 ;2 correct
5251583379644322 ;2 correct
1748270476758276 ;3 correct
4895722652190306 ;1 correct
3041631117224635 ;3 correct
1841236454324589 ;3 correct
2659862637316867 ;2 correct"

# data = "90342 ;2 correct
# 70794 ;0 correct
# 39458 ;2 correct
# 34109 ;1 correct
# 51545 ;2 correct
# 12531 ;1 correct"


{:digits=>[7, 0, 7, 9, 4], :weight=>0}
{:digits=>[1, 2, 5, 3, 1], :weight=>1}
{:digits=>[3, 4, 1, 0, 9], :weight=>1}
{:digits=>[3, 9, 4, 5, 8], :weight=>2}
{:digits=>[5, 1, 5, 4, 5], :weight=>2}
{:digits=>[9, 0, 3, 4, 2], :weight=>2}



class Array
	def vdisplay(file = nil)
		unless file
			self.each{|p| puts p.join('/')}
		else
			self.each{|p| file.puts p.join('/')}
		end
	end

	def bdisplay(size)
		temp = [];
		size.times do |i|
			temp2 = []
			10.times do |p|
				temp2 << if self[10*i+p] then p else "_" end
			end
			temp << temp2
		end
		temp.each{|t| puts t.join("|")}
		puts "\n"
	end
end

#Parser les données
puts "Collecte des données"
numbers_list = data.split("\n").collect do |line| 
	lambda {|s| {digits: s.first.strip.each_char.to_a.map{|a| a.to_i}, weight: s.last.chomp(" correct").to_i}}.call(line.split(";"))
end.sort{|a,b| a[:weight] <=> b[:weight]}

$size = numbers_list.first[:digits].count

def verify_number(numbers_list, number)
	numbers_list.each do |rule|
		similarity = 0
		for i in 0..rule[:digits].count-1 do
			similarity += 1 if rule[:digits][i] == number.each_char.to_a[i].to_i
		end
		puts "Rule #{rule[:digits]} : #{similarity == rule[:weight]}"
	end
end

def permutations(vector, size)
	if size == 1
		return vector.map{|a| [a]}
	else
		perm = []
		while vector.count > size-1
			head = vector.shift
			perm += permutations(vector.clone, size-1).map{|a| a.unshift(head)}
		end
		return perm
	end
end

$step = 0
$max_floor = 0
$last_floor = numbers_list.select{|a| a[:weight] != 0}.count
$permutations = {}
indices = (0..$size-1).to_a;
3.times{|i| $permutations.store(i+1, permutations(indices, i+1))}

def cross_tree(numbers_list, forbidden, selected, floor = 0)
	$step += 1
	puts $step if $step % 250000 == 0

	#Gestion du cas terminal
	return selected.join("") if floor == $last_floor

	#Calculer l'ensemble des mooves possibles à cet étage
	weight = numbers_list[floor][:weight]
	digits = numbers_list[floor][:digits]

	permutations = $permutations[weight].clone
	permutations.select! do |p|
		wrong = false;inserted = 0;
		(0..weight-1).each do |i|
			wrong || = (selected[p[i]] != digits[p[i]] && forbidden[p[i]*10+digits[p[i]]]
				inserted += 1 unless (seleted[p[i]]) == digits[p[i]]
		end
	end

	#Rechercher un move correct, et le jouer
	while !permutations.empty?
		move = permutations.shift

		#Le move est-il correct ?
		wrong = false; inserted = 0;
		(0..weight-1).each do |i| 
			wrong ||= (forbidden[move[i]*10+digits[move[i]]] && (selected[move[i]] != digits[move[i]]))
		end
	# private boolean isForbidden(int position, int value){
	# 	return choosen[position] != value && forbidden[position*10+value];
	# }

	# public Stack<Permutation> purge(Stack<Permutation> permutations, Number number){
	# 	Stack<Permutation> purged = new Stack<Permutation>();
	# 	boolean wrong; int[] indices; int inserted; int similarity;
	# 	for(Permutation permutation : permutations){
	# 		indices = permutation.getIndices();
	# 		wrong = false; inserted = 0;
	# 		for(int i = 0; i < indices.length; i++){
	# 			wrong = wrong || isForbidden(indices[i], number.digitAt(indices[i]));
	# 			if(choosen[indices[i]] != number.digitAt(indices[i])){inserted++;} 
	# 		}
	# 		similarity = 0;
	# 		for(int i = 0; i < number.getSize(); i++){
	# 			if(number.digitAt(i) == choosen[i]){similarity++;}
	# 		}
	# 		wrong = wrong || similarity+inserted != indices.length;
	# 		if(!wrong){purged.push(permutation);}
	# 	}
	# 	return purged;
	# }


		unless wrong
			forbidden_child = forbidden.clone
			selected_child = selected.clone

			(0..$size-1).each{|i| forbidden_child[i*10+digits[i]] = true}
			(0..weight-1).each do |i| 
				selected_child[move[i]] = digits[move[i]]
				(0..9).each {|n| forbidden_child[move[i]*10 + n] = true}
			end

			#Récupération du nombre construit par les étages inférieurs
			number = cross_tree(numbers_list, forbidden_child, selected_child, floor+1)
			return number unless number.nil?
		end
	end
	#Si l'on sort de cette boucle sans avoir fait de return, c'est qu'on a passé toutes les permutations
	#et qu'elle n'ont rien donné. On le fait savoir aux étages supérieurs
	return nil
end





time = Time.now.to_f
  	forbidden = Array.new($size*10){false}
	#Prise en compte des poids 0
	numbers_list.select{|n| n[:weight] == 0}.each do |n|
		for i in 0..($size-1) do
			forbidden[i*10+n[:digits][i]] = true 
		end
	end

# puts numbers_list

# number = cross_tree(numbers_list.select{|n| n[:weight] > 0}, forbidden, Array.new($size))
# puts ((Time.now.to_f - time)*1000).to_s+"ms"
# puts number;
# puts $step

verify_number(numbers_list, "4640261571849533");464026157184_533