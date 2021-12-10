# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 11 Part 2
# https://adventofcode.com/2018/day/11#part2
# Answer is: 235,288,13 in ~6s

def calculate_cell_power(x, y, serial_no)
  x += 1
  y += 1

  rack_id = x + 10
  power_level = ((((y * rack_id) + serial_no) * rack_id) % 1000) / 100
  power_level - 5
end

def calculate_nxn_power(x, y, box_size)
  return calculate_nxn_power_even(x, y, box_size / 2) if (box_size % 2).zero?
  return calculate_nxn_power_odd(x, y, box_size) unless (box_size % 2).zero?
end

def calculate_nxn_power_even(x, y, half_box_size)
  # puts "WOLOLO #{x},#{y} #{half_box_size}" if half_box_size == 2
  # gets if half_box_size == 2
  total_power = @powers_per_box_size[half_box_size][y][x]

  total_power += @powers_per_box_size[half_box_size][y + half_box_size][x]
  # puts "#{x},#{y + half_box_size}" if half_box_size == 2
  # gets if half_box_size == 2
  total_power += @powers_per_box_size[half_box_size][y][x + half_box_size]
  # puts "#{x + half_box_size},#{y}" if half_box_size == 2
  # gets if half_box_size == 2
  total_power += @powers_per_box_size[half_box_size][y + half_box_size][x + half_box_size]
  # puts "#{x + half_box_size},#{y + half_box_size}" if half_box_size == 2
  # gets if half_box_size == 2

  # puts 'XXXXXXXXXXXXXXXXXXXXX' if half_box_size == 2
  # if half_box_size == 2
  #   puts "#{x},#{y} #{total_power}"
  #   gets
  # end
  @powers_per_box_size[half_box_size * 2][y][x] = total_power
  total_power
end

def calculate_nxn_power_odd(x, y, box_size)
  total_power = @powers_per_box_size[(box_size + 1) / 2][y][x]
  # puts "WOLOLO #{x},#{y} #{box_size}"
  # gets

  total_power += @powers_per_box_size[(box_size + 1) / 2][y + ((box_size - 1) / 2)][x + ((box_size - 1) / 2)]
  # puts "#{x + ((size - 1) / 2)},#{y + ((size - 1) / 2)}"
  # gets

  total_power -= @powers_per_box_size[1][y + ((box_size - 1) / 2)][x + ((box_size - 1) / 2)]
  # puts "#{x + ((size - 1) / 2)},#{y + ((size - 1) / 2)}"
  # gets

  total_power += @powers_per_box_size[(box_size - 1) / 2][y][x + ((box_size + 1) / 2)]
  # puts "#{x + ((size + 1) / 2)},#{y}"
  # gets

  total_power += @powers_per_box_size[(box_size - 1) / 2][y + ((box_size + 1) / 2)][x]
  # puts "#{x},#{y + ((size + 1) / 2)}"
  # gets

  # puts 'XXXXXXXXXXXXXXXXXXXXX'

  @powers_per_box_size[box_size][y][x] = total_power
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
max_box_size = 0

@powers_per_box_size = [[], []]
size.times do
  @powers_per_box_size[1] << Array.new(size, 0)
end

x = 0
while x <= size - 1
  y = 0
  while y <= size - 1
    power = calculate_cell_power(x, y, input)
    if power > max_power
      max_power = power
      max_x = x
      max_y = y
      max_box_size = 1
    end
    @powers_per_box_size[1][y][x] = power
    y += 1
  end
  x += 1
end

box_size = 2

while box_size <= size
  @powers_per_box_size << []
  size.times do
    @powers_per_box_size[box_size] << Array.new(size, 0)
  end

  x = 0
  while x <= size - box_size
    y = 0
    while y <= size - box_size
      power = calculate_nxn_power(x, y, box_size)
      if power > max_power
        max_power = power
        max_x = x
        max_y = y
        max_box_size = box_size
      end
      y += 1
    end
    x += 1
  end
  # puts "Box size #{box_size} #{max_power} #{max_x + 1},#{max_y + 1},#{max_box_size}"
  box_size += 1
end

puts "#{max_x + 1},#{max_y + 1},#{max_box_size}"
