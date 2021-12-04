def find_loop_size(key, subject)
    loop_size = 1
    value = 1

    while true
        value *= subject
        value = value % 20201227

        if value == key
            break
        else
            loop_size += 1
        end
    end
    loop_size
end

def run_loop(subject, loop_size)
    i = 0
    value = 1
    while i < loop_size
        value *= subject
        value = value % 20201227
        i += 1
    end
    value
end

# card_key = 5764801
# door_key = 17807724
card_key = 15086442
door_key = 15335876
card_loop_size = find_loop_size(card_key, 7)
puts "Card loop_size #{card_loop_size}"

door_loop_size = find_loop_size(door_key, 7)
puts "Door loop_size #{door_loop_size}"

puts run_loop(card_key, door_loop_size)
puts run_loop(door_key, card_loop_size)
