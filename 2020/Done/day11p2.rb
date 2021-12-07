# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 11 Part 2
# https://adventofcode.com/2020/day/11#part2
# Answer is: 2064

# @input = %w[L.LL.LL.LL LLLLLLL.LL L.L.L..L.. LLLL.LL.LL L.LL.LL.LL L.LLLLL.LL ..L.L..... LLLLLLLLLL L.LLLLLL.L
#             L.LLLLL.LL']
@input = %w[LL.LL.LLLLLL.LLLLLLLLLLLLLLLLLL.LLLLL..LLLLLLL.LLLLLLLLLLLL.LLLL.LLLLL.LL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL
            .LL...LL.L.L....LL..LL..L.L.L..L.....L...LL.....LLL..L..L..L.....L.L..LLLL...LL.LL.L.......
            LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL..LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLL.LLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLLLLLLLLLL.LL.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LL.L......L...LL....L...L.LL.L.....L.LL.L....L...LLL....LL.....LL.L.LLL...LL.L...LLL.L.L...
            LLLLLLLLLLLL.LLLLLLLL.L.LL.L.LLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLLLLLL.LL.LLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLL.LLLLLL.L.LLLLL.LLLLLLLLLLLL.LLLL.LLLLLLL..LLLLLL.LLLL.LLLLL
            LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLL.L.LL.LLLLL
            .LLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            ...L..L......L..L.L.......LL...L.LL.L...LL...L..LL....L....L.L..L...L...L.L.....LL.....L..L
            LLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLLLLL.LL
            LLLLL.LLLLLLLL.LL.LLLLLLLL.LLLL.LLLLLL.LLLLLLLLLLL.L.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLL.LLL.LLLLL.LLLLLL.LLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLLLLLLLLLL.L.LLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLL.LLLLLLLLLLL.LLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLL
            .......LL.L.L...LL..L....LL....L.L.L....L......L..LL...LL.LLL..L....L......L.LLL.L.....LLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLL.LLLLLLLLLL.LLLLLLLLL.LLLL.L.LLLL.LLLLLLLL.LLLLLL.L.LLLLLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLLLLLLL.
            LLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLL.LLLLLLLL.LLLL.LLLLLLLL.LLLLLL.LLL..LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLL.LLLLL.LLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLLLL.LLLLLLL
            LLLLL.LLLLLL.LL.LLLLLLLLLL.LLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLLLLLLLLLL.LLLLL.LLLLLLLLLLL.LLL.LLLL.LLLLLLLLLLLLLLLLL
            .L........L..L.L.LLLLL.......LL.......L..L.L..LL.L......L.......LLL..LLL.LL...L.L...L.LL.L.
            LLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLL..LLLLL.LLLLLLLL.LLLL.LLL..LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLL.LLLLL..LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            ..L..LL.......L.LLLL.L.....L...L.LL...LLLLL.L.....L..L...LL.LL..L..LLLLLL..........LL.....L
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLL..LLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLL..LLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL.LL.LLLLLLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLL.LLLL..LLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            L...LL....L..L..LL.........L.L...LL..LL.L....L...........LL.L.......L.L.L.......L..L..LL..L
            LLLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LL.LLL.LLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLL.LLLLLL.L.LLLLLLLLLLL.LL.LLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLL.L.LLLL.LLLLLLLLLLLL..L.LLLL.L.LL.LLLLLLLL.LLLLLLLLLLLLLLLL.
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLLL.LLL.LLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL
            .....L.LLL...LL..LL.....L....LL.......L...LL..L..L...L...L.LL.LL.LL...LL..LLL.L..LLL..LLLL.
            LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLLLLLLLL.L.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLLLLLLL.LLLLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL..LLL.LLLLLLLLLLLLLL.LLLL..LLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLLLLLL.LL.LLLLLLLLLLLLL.LL.LLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            ..L..LL.........L....L.L.L.L...L....L...........LL....L..L...L.LL..L..LL.L..LL..L..L.L..L.L
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLLLLLLLLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLL.LLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            ....L............L....LL......L.LLL.LLL....LL.....L..L.LL.L........L..L......L.LLL..LL..LL.
            LL.LLLLLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLL.LLLLLL.LLLLLLLL.L.LLLLLLL.LLLLLLLLLLLLLL.LLLLLLLLLLLLLLLLL.LLLLLLLL..LLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLLLLLLL.LLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL..LLLLLLLLLLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLLLLLLLLLLL.LL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLL
            LLLLL.L.LLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLLLLLLLL
            LLLLL.LLLLLLLLLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLL.LLLLLL.LLLLLLLLLL
            .L......LLL...L.L.LL.L.....LL.L..L.L.LLLLL....LL..L...L..L.....L.L...L...L.L.LL.LL.L.......
            LLLLLLLLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLLLLLLLLL.LLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLL.LLLL.LLLLLL.LLLLLLL.LLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLLLLLLL.LLLLL
            LLLLL.LLLLLL.LLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLL.LLLLLLLLLLLL.LLLL.LLLLLLLL.LLLLLLLLLLL.LLLLL
            LLLLLLLLLLLLLLLLLLLLL.LLLLLLLLL.LLLLLL.LLLLLLLLLLLLL.LLLLLLLLLLL.LLLLLLLLLLLLLLL.LLLLLLLLLL
            LLLLL.LLLLLLLLLLLLLL..LLLLLLLLL.LLLLLL.LLLLLLL.LLLLL.LLLLL..LLLL.LLLLLLLLLLLLLLLLLLLLLLLLLL
            LLLLLLLLLLLLLLLLLLLLL.LLLL.LLLLLLLLLLLLLLLLLLL.LLLLL.LLLLLL.LLLL.LLLLLLLL.LLLLLL.LLLL.LLLLL]
# @input = %w[.......#. ...#..... .#....... ......... ..#L....# ....#.... ......... #........ ...#.....]
# @input = %w[............. .L.L.#.#.#.#. .............]
# @input = %w[.##.##. #.#.#.# ##...## ...L... ##...## #.#.#.# .##.##.]
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
