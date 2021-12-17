# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 25 Part 1
# https://adventofcode.com/2020/day/25
# Answer is: 11707042

def find_loop_size(key, subject)
  loop_size = 1
  value = 1

  loop do
    value *= subject
    value = value % 20_201_227

    break if value == key

    loop_size += 1
  end
  loop_size
end

def run_loop(subject, loop_size)
  i = 0
  value = 1
  while i < loop_size
    value *= subject
    value = value % 20_201_227
    i += 1
  end
  value
end

# card_key = 5_764_801
# door_key = 17_807_724
raw_input = File.readlines('../1 Input/day25.input').map(&:strip).map(&:to_i)
card_key = raw_input[0]
door_key = raw_input[1]

# card_loop_size = find_loop_size(card_key, 7)
# puts "Card loop_size #{card_loop_size}"

door_loop_size = find_loop_size(door_key, 7)
# puts "Door loop_size #{door_loop_size}"

puts run_loop(card_key, door_loop_size)
# puts run_loop(door_key, card_loop_size)
