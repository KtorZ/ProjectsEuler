require 'date'

start_date = Date.new(1901,1,1)
end_date = Date.new(2000,12,31)
nb_sundays = 0;
while start_date != end_date do
	nb_sundays += 1 if start_date.mday == 1 && start_date.sunday?
	start_date = start_date.next
end
puts nb_sundays

test_date = Date.new(1900,05,8)
puts test_date.mday