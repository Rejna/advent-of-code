# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 3 Part 1
# https://adventofcode.com/2019/day/3
# Answer is: 731

def print_floor
  @floor.each do |row|
    puts row.join(' ')
  end
end

def cross_check(cur_x, cur_y)
  if @floor[cur_y][cur_x] == '.' || @floor[cur_y][cur_x] == 'a'
    @floor[cur_y][cur_x] = 'a'
  else
    @floor[cur_y][cur_x] = 'X'
    distance_to_cross = (cur_x - @start_x).abs + (cur_y - @start_y).abs
    @nearest_cross = distance_to_cross if distance_to_cross < @nearest_cross
  end
end

# cable1 = %w[R8 U5 L5 D3]
# cable2 = %w[U7 R6 D4 L4 U10]
# floor_size = 20
# start_x = 1
# start_y = 1

# cable1 = %w[R75 D30 R83 U83 L12 D49 R71 U7 L72]
# cable2 = %w[U62 R66 U55 R34 D71 R55 D58 R83]
# floor_size = 600
# start_x = 30
# start_y = 300

# cable1 = %w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51]
# cable2 = %w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7]
# floor_size = 600
# start_x = 30
# start_y = 300

raw_input = File.readlines('../1 Input/day03.input').map(&:strip)
cable1 = raw_input[0].split(',')
cable2 = raw_input[1].split(',')

floor_size = 12_000
@start_x = 300
@start_y = 3000

@floor = []
i = 0
while i < floor_size
  @floor << [*Array.new(floor_size, '.')]
  i += 1
end

x = @start_x
y = @start_y

@floor[y][x] = 'O'

cable1.each do |dir|
  sp = dir.split('')
  direction = sp[0]
  distance = sp[1..].join.to_i
  i = 0

  while i < distance
    case direction
    when 'R'
      x += 1
      @floor[y][x] = '-'
    when 'L'
      x -= 1
      @floor[y][x] = '-'
    when 'U'
      y += 1
      @floor[y][x] = '|'
    when 'D'
      y -= 1
      @floor[y][x] = '|'
    end
    i += 1
  end
  @floor[y][x] = '+'
end

case cable1.last.split('')[0]
when 'L', 'R'
  @floor[y][x] = '-'
when 'U', 'D'
  @floor[y][x] = '|'
end

x = @start_x
y = @start_y
@nearest_cross = floor_size * 2

cable2.each do |dir|
  sp = dir.split('')
  direction = sp[0]
  distance = sp[1..].join.to_i
  i = 0

  while i < distance
    case direction
    when 'R'
      x += 1
    when 'L'
      x -= 1
    when 'U'
      y += 1
    when 'D'
      y -= 1
    end
    cross_check(x, y)
    i += 1
  end
  @floor[y][x] = '+'
end

@floor[y][x] = 'a'

# print_floor
puts @nearest_cross
