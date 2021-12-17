# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 11 Part 2
# https://adventofcode.com/2020/day/11#part2
# Answer is: 2064

# @input = %w[L.LL.LL.LL LLLLLLL.LL L.L.L..L.. LLLL.LL.LL L.LL.LL.LL L.LLLLL.LL ..L.L..... LLLLLLLLLL L.LLLLLL.L
#             L.LLLLL.LL']
# @input = %w[.......#. ...#..... .#....... ......... ..#L....# ....#.... ......... #........ ...#.....]
# @input = %w[............. .L.L.#.#.#.#. .............]
# @input = %w[.##.##. #.#.#.# ##...## ...L... ##...## #.#.#.# .##.##.]
@input = File.readlines('../1 Input/day11.input').map(&:strip)
@input = @input.map { |ar| ar.split('') }
@width = @input[0].length
@height = @input.length

def count(i, j)
  neighbours = []

  up = i - 1
  while up >= 0
    unless @input[up][j] == '.'
      neighbours << @input[up][j]
      break
    end
    up -= 1
  end

  down = i + 1
  while down < @height
    unless @input[down][j] == '.'
      neighbours << @input[down][j]
      break
    end
    down += 1
  end

  left = j - 1
  while left >= 0
    unless @input[i][left] == '.'
      neighbours << @input[i][left]
      break
    end
    left -= 1
  end

  right = j + 1
  while right < @width
    unless @input[i][right] == '.'
      neighbours << @input[i][right]
      break
    end
    right += 1
  end

  top = i - 1
  left = j - 1
  while top >= 0 && left >= 0
    unless @input[top][left] == '.'
      neighbours << @input[top][left]
      break
    end
    top -= 1
    left -= 1
  end

  top = i - 1
  right = j + 1
  while top >= 0 && right < @width
    unless @input[top][right] == '.'
      neighbours << @input[top][right]
      break
    end
    top -= 1
    right += 1
  end

  bottom = i + 1
  left = j - 1
  while bottom < @height && left >= 0
    unless @input[bottom][left] == '.'
      neighbours << @input[bottom][left]
      break
    end
    bottom += 1
    left -= 1
  end

  bottom = i + 1
  right = j + 1
  while bottom < @height && right < @width
    unless @input[bottom][right] == '.'
      neighbours << @input[bottom][right]
      break
    end
    bottom += 1
    right += 1
  end

  neighbours.tally['#']
end

def compare_boards(a, b)
  ident = true
  i = 0
  while i < a.length
    unless a[i] == b[i]
      ident = false
      break
    end
    i += 1
  end
  ident
end

k = 0
while true
  output = []
  i = 0
  while i < @height
    new_row = []
    j = 0
    while j < @width
      new_row << if @input[i][j] == 'L' && count(i, j).nil?
                   '#'
                 elsif @input[i][j] == '#' && !count(i, j).nil? && count(i, j) >= 5
                   'L'
                 else
                   @input[i][j]
                 end
      j += 1
    end
    i += 1
    output << new_row.join
  end

  result = compare_boards(@input, output)
  break if result

  @input = output
  k += 1
end

occupied_count = 0
output.each do |row|
  c = row.split('').tally['#']
  occupied_count += c unless c.nil?
end
puts occupied_count
