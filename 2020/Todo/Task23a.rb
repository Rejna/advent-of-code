input = [3,8,9,1,2,5,4,6,7]

i = 1
min = input.min
max = input.max
len = input.length
current = 0
destination = 0

while i <= 1
    puts "-- move #{i} --"
    puts "cups: #{input.take(current).join('  ')}  (#{input[current]})  #{input[current+1..].join('  ')}"

    current_val = input[current]
    pickup1 = input[(current+1) % len]
    pickup2 = input[(current+2) % len]
    pickup3 = input[(current+3) % len]
    input -= [pickup1]
    input -= [pickup2]
    input -= [pickup3]

    puts "pickup: #{pickup1}, #{pickup2}, #{pickup3}"

    new_destination = current_val - 1
    while destination == 0
        if input.index(new_destination).nil?
            if new_destination - 1 < min
                new_destination = max
            else
                new_destination -= 1
            end
        else
            destination = new_destination
        end
    end

    puts "destination: #{destination}"

    new_input = [*input.take(current)] + [current_val] +
    i += 1
end

