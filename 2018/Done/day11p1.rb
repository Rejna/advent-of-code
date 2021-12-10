# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 11 Part 1
# https://adventofcode.com/2018/day/11
# Answer is: 21,22

def calculate_cell_power(x, y, serial_no)
  x += 1
  y += 1

  rack_id = x + 10
  power_level = ((((y * rack_id) + serial_no) * rack_id) % 1000) / 100
  power_level - 5
end

def calculate_3x3_power(x, y, serial_no)
  total_power = 0

  i = 0
  while i < 3
    j = 0
    while j < 3
      total_power += calculate_cell_power(x + i, y + j, serial_no)
      j += 1
    end
    i += 1
  end
  total_power
end

# puts calculate_power(3, 5, 8)
# puts calculate_power(122, 79, 57)
# puts calculate_power(217, 196, 39)
# puts calculate_power(101, 153, 71)

# input = 18
# input = 42
input = 7511

size = 300
max_power = 0
max_x = 0
max_y = 0

x = 0
while x < size - 2
  y = 0
  while y < size - 2
    power = calculate_3x3_power(x, y, input)
    if power > max_power
      max_power = power
      max_x = x
      max_y = y
    end
    y += 1
  end
  x += 1
end

puts "#{max_x + 1},#{max_y + 1}"
