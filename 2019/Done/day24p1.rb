# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 24 Part 1
# https://adventofcode.com/2019/day/24
# Answer is: 30446641

def calculate_biodiversity
  bio = 0
  @bugs.each do |bug|
    bio += 2**(bug[1] * 5 + bug[0])
  end
  bio
end

def scan_neighbours(i, j)
  left = (j >= 1 ? @input[i][j - 1] : '.') == '#'
  right = (j <= 3 ? @input[i][j + 1] : '.') == '#'
  up = (i >= 1 ? @input[i - 1][j] : '.') == '#'
  down = (i <= 3 ? @input[i + 1][j] : '.') == '#'

  neighs = [left, right, up, down].tally
  bugs_around = neighs[true] || 0

  if bugs_around != 1 && @input[i][j] == '#'
    '.'
  elsif bugs_around.positive? && bugs_around < 3 && @input[i][j] == '.'
    '#'
  else
    @input[i][j]
  end
end

def print_life(i = @input)
  i.each do |row|
    puts row.join('')
  end
end

@input = ['#..##'.split(''),
          '#.#..'.split(''),
          '#...#'.split(''),
          '##..#'.split(''),
          '#..##'.split('')]

# @input = ['....#'.split(''),
#           '#..#.'.split(''),
#           '#..##'.split(''),
#           '..#..'.split(''),
#           '#....'.split('')]

# @input = ['.....',
#           '.....',
#           '.....',
#           '#....',
#           '.#...']
@bugs = []
i = 0
while i < 5
  j = 0
  while j < 5
    @bugs << [i, j] if @input[i][j] == '#'
    j += 1
  end
  i += 1
end

layouts = [@input.flatten.join]
k = 0

loop do
  new_input = @input.map(&:clone)
  new_bugs = @bugs.map(&:clone)

  puts "After #{k} minutes"
  print_life
  puts

  i = 0
  while i < 5
    j = 0
    while j < 5
      l = scan_neighbours(j, i)
      case l
      when '.'
        new_bugs.delete([i, j]) if @bugs.include?([i, j])
      when '#'
        new_bugs << [i, j] unless @bugs.include?([i, j])
      end
      new_input[j][i] = l
      j += 1
    end
    i += 1
  end

  @input = new_input
  @bugs = new_bugs

  if layouts.include?(@input.flatten.join)
    puts calculate_biodiversity
    break
  else
    layouts << @input.flatten.join
  end
  k += 1
end
