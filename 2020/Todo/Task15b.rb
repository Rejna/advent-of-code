input = [0,0,3,6]
last_heard = { 0 => 1, 3 => 2 }
# input = [0,1,3,2]
# last_heard = { 1 => 1, 3 => 2 }
# input = [0,2,1,3]
# last_heard = { 2 => 1, 1 => 2 }
# input = [0,3,1,2]
# last_heard = { 3 => 1, 1 => 2 }
# input = [0,6,3,15,13,1,0]
# last_heard = { 6 => 1, 3 => 2, 15 => 3, 13 => 4, 1 => 5 }
i = 3

while i < 30_000_000
    if last_heard.keys.include?(input[i])
        input << i - last_heard[input[i]]
        last_heard[input[i]] = i
    else
        input << 0
        last_heard[input[i]] = i
    end

    i += 1
end

puts input.length
puts input[30000000]