timestamp = 1002578
input = '19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,751,x,29,x,x,x,x,x,x,x,x,x,x,13,x,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,431,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,17'
input = input.split(',').reject { |x| x == 'x' }.map { |i| i.to_i }

nearest = timestamp
nearest_id = 0

input.each do |id|
    m = id - (timestamp % id)
    nearest_id = id if m < nearest
    nearest = m if m < nearest
end

puts nearest * nearest_id


