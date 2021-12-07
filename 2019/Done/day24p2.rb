# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 24 Part 2
# https://adventofcode.com/2019/day/24#part2
# Answer is: 1985

@special_fields = [[1, 2], [2, 1], [2, 3], [3, 2]]
@special_directions = %w[down right left up]

def extract_column(level, col_no)
  col = []
  level.each do |row|
    col << row[col_no]
  end
  col
end

def scan_neighbours(level, i, j)
  left = (j >= 1 ? @input[level][i][j - 1] : '.') == '#'
  right = (j <= 3 ? @input[level][i][j + 1] : '.') == '#'
  up = (i >= 1 ? @input[level][i - 1][j] : '.') == '#'
  down = (i <= 3 ? @input[level][i + 1][j] : '.') == '#'

  if @special_fields.include?([i, j]) && level < @input.keys.max
    idx = @special_fields.index([i, j])
    case @special_directions[idx]
    when 'up'
      up = @input[level + 1][4].map { |t| t == '#' }
    when 'down'
      down = @input[level + 1][0].map { |t| t == '#' }
    when 'left'
      left = extract_column(@input[level + 1], 4).map { |t| t == '#' }
    else
      right = extract_column(@input[level + 1], 0).map { |t| t == '#' }
    end
  elsif level > @input.keys.min
    if i.zero?
      up = @input[level - 1][1][2] == '#'
    elsif i == 4
      down = @input[level - 1][3][2] == '#'
    end
    if j.zero?
      left = @input[level - 1][2][1] == '#'
    elsif j == 4
      right = @input[level - 1][2][3] == '#'
    end
  end

  neighs = [left, right, up, down].flatten.tally
  bugs_around = neighs[true] || 0

  if bugs_around != 1 && @input[level][i][j] == '#'
    '.'
  elsif bugs_around.positive? && bugs_around < 3 && @input[level][i][j] == '.'
    '#'
  else
    @input[level][i][j]
  end
end

def print_life(i = @input)
  i.sort_by { |k, _v| k }.each do |k, v|
    puts k
    v.each do |row|
      puts row.join
    end
    puts
  end
  puts '-------------------------'
end

# @input = { 0 => ['....#'.split(''),
#                  '#..#.'.split(''),
#                  '#..##'.split(''),
#                  '..#..'.split(''),
#                  '#....'.split('')] }

@input = { 0 => ['#..##'.split(''),
                 '#.#..'.split(''),
                 '#...#'.split(''),
                 '##..#'.split(''),
                 '#..##'.split('')] }

# 10.times do |minute|
200.times do |minute|
  new_input = {}
  if (minute % 2).zero?
    @input[@input.keys.min - 1] = Array.new(5, Array.new(5, '.'))
    @input[@input.keys.max + 1] = Array.new(5, Array.new(5, '.'))
  end
  @input.each do |k, v|
    new_input[k] = v.map(&:clone)
  end

  @input.each_key do |level|
    i = 0
    while i < 5
      j = 0
      while j < 5
        if i != 2 || j != 2
          l = scan_neighbours(level, i, j)
          new_input[level][i][j] = l
        end
        j += 1
      end
      i += 1
    end
  end

  @input = new_input
end

sum = 0
@input.each do |_k, v|
  sum += v.flatten.tally['#'] || 0
end

puts sum
