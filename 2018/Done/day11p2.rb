# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 11 Part 2
# https://adventofcode.com/2018/day/11#part2
# Answer is: 235,288,13 in 1m18s

def calculate_cell_power(x, y, serial_no)
  x += 1
  y += 1

  rack_id = x + 10
  power_level = ((((y * rack_id) + serial_no) * rack_id) % 1000) / 100
  power_level - 5
end

def calculate_nxn_power(x, y, box_size)
  total_power = @previous_box_size[y][x]
  # puts "WOLOLO #{x},#{y} #{box_size}"
  # gets

  i = 0
  while i < box_size
    total_power += @box_size_one[y + box_size - 1][x + i]
    # puts "#{x + i},#{y + box_size - 1}"
    # gets
    if i < box_size - 1
      total_power += @box_size_one[y + i][x + box_size - 1]
      # puts "WOW #{x + box_size - 1},#{y + i}"
      # gets
    end
    i += 1
  end
  # puts 'XXXXXXXXXXXXXXXXXXXXX'
  @previous_box_size[y][x] = total_power
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

@box_size_one = []
@previous_box_size = []
size.times do
  @box_size_one << Array.new(size, 0)
  @previous_box_size << Array.new(size, 0)
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
    @box_size_one[y][x] = power
    @previous_box_size[y][x] = power
    y += 1
  end
  x += 1
end

box_size = 2

while box_size <= size
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
  puts "Box size #{box_size} #{max_power} #{max_x + 1},#{max_y + 1},#{max_box_size}"
  box_size += 1
end
puts "#{max_x + 1},#{max_y + 1},#{max_box_size}"
