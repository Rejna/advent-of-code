# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 11 Part 1
# https://adventofcode.com/2020/day/11
# Answer is: 2273

# @input = %w[L.LL.LL.LL LLLLLLL.LL L.L.L..L.. LLLL.LL.LL L.LL.LL.LL L.LLLLL.LL ..L.L..... LLLLLLLLLL L.LLLLLL.L
#             L.LLLLL.LL']
@input = File.readlines('../1 Input/day11.input').map(&:strip)
@input = @input.map { |ar| ar.split('') }

def count_free(i, j)
  count(i, j, 'L')
end

def count_occupied(i, j)
  count(i, j, '#')
end

def count(i, j, c)
  neighbours = []
  if i.zero?
    if j.zero?
      neighbours << @input[i][j + 1]
      neighbours << @input[i + 1][j + 1]
      neighbours << @input[i + 1][j]
    elsif j == @input[i].length - 1
      neighbours << @input[i][j - 1]
      neighbours << @input[i + 1][j - 1]
      neighbours << @input[i + 1][j]
    else
      neighbours << @input[i][j + 1]
      neighbours << @input[i][j - 1]
      neighbours << @input[i + 1][j]
      neighbours << @input[i + 1][j - 1]
      neighbours << @input[i + 1][j + 1]
    end
  elsif i == @input.length - 1
    if j.zero?
      neighbours << @input[i][j + 1]
      neighbours << @input[i - 1][j + 1]
      neighbours << @input[i - 1][j]
    elsif j == @input[i].length - 1
      neighbours << @input[i][j - 1]
      neighbours << @input[i - 1][j - 1]
      neighbours << @input[i - 1][j]
    else
      neighbours << @input[i][j + 1]
      neighbours << @input[i][j - 1]
      neighbours << @input[i - 1][j]
      neighbours << @input[i - 1][j + 1]
      neighbours << @input[i - 1][j - 1]
    end
  elsif j.zero?
    neighbours << @input[i + 1][j + 1]
    neighbours << @input[i + 1][j]
    neighbours << @input[i][j + 1]
    neighbours << @input[i - 1][j + 1]
    neighbours << @input[i - 1][j]
  elsif j == @input[i].length - 1
    neighbours << @input[i][j - 1]
    neighbours << @input[i - 1][j - 1]
    neighbours << @input[i - 1][j]
    neighbours << @input[i + 1][j - 1]
    neighbours << @input[i + 1][j]
  else
    neighbours << @input[i][j + 1]
    neighbours << @input[i][j - 1]
    neighbours << @input[i - 1][j]
    neighbours << @input[i - 1][j - 1]
    neighbours << @input[i - 1][j + 1]
    neighbours << @input[i + 1][j]
    neighbours << @input[i + 1][j + 1]
    neighbours << @input[i + 1][j - 1]
  end
  neighbours.tally[c]
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

width = @input[0].length
height = @input.length
k = 0

while true
  output = []
  i = 0
  while i < height
    new_row = []
    j = 0
    while j < width
      new_row << if @input[i][j] == 'L' && count_occupied(i, j).nil?
                   '#'
                 elsif @input[i][j] == '#' && !count_occupied(i, j).nil? && count_occupied(i, j) >= 4
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
