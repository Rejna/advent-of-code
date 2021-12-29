# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 11 Part 1
# https://adventofcode.com/2021/day/11
# Answer is: 1625

def neighbours(i, j, input)
  neighs = []
  if i.zero?
    if j.zero?
      neighs << [i, j + 1] unless input[i][j + 1].zero?
      neighs << [i + 1, j + 1] unless input[i + 1][j + 1].zero?
      neighs << [i + 1, j] unless input[i + 1][j].zero?
    elsif j == input[i].length - 1
      neighs <<  [i, j - 1] unless input[i][j - 1].zero?
      neighs <<  [i + 1, j - 1] unless input[i + 1][j - 1].zero?
      neighs <<  [i + 1, j] unless input[i + 1][j].zero?
    else
      neighs <<  [i, j + 1] unless input[i][j + 1].zero?
      neighs <<  [i, j - 1] unless input[i][j - 1].zero?
      neighs <<  [i + 1, j] unless input[i + 1][j].zero?
      neighs <<  [i + 1, j - 1] unless input[i + 1][j - 1].zero?
      neighs <<  [i + 1, j + 1] unless input[i + 1][j + 1].zero?
    end
  elsif i == input.length - 1
    if j.zero?
      neighs <<  [i, j + 1] unless input[i][j + 1].zero?
      neighs <<  [i - 1, j + 1] unless input[i - 1][j + 1].zero?
      neighs <<  [i - 1, j] unless input[i - 1][j].zero?
    elsif j == input[i].length - 1
      neighs <<  [i, j - 1] unless input[i][j - 1].zero?
      neighs <<  [i - 1, j - 1] unless input[i - 1][j - 1].zero?
      neighs <<  [i - 1, j] unless input[i - 1][j].zero?
    else
      neighs <<  [i, j + 1] unless input[i][j + 1].zero?
      neighs <<  [i, j - 1] unless input[i][j - 1].zero?
      neighs <<  [i - 1, j] unless input[i - 1][j].zero?
      neighs <<  [i - 1, j + 1] unless input[i - 1][j + 1].zero?
      neighs <<  [i - 1, j - 1] unless input[i - 1][j - 1].zero?
    end
  elsif j.zero?
    neighs <<  [i + 1, j + 1] unless input[i + 1][j + 1].zero?
    neighs <<  [i + 1, j] unless input[i + 1][j].zero?
    neighs <<  [i, j + 1] unless input[i][j + 1].zero?
    neighs <<  [i - 1, j + 1] unless input[i - 1][j + 1].zero?
    neighs <<  [i - 1, j] unless input[i - 1][j].zero?
  elsif j == input[i].length - 1
    neighs <<  [i, j - 1] unless input[i][j - 1].zero?
    neighs <<  [i - 1, j - 1] unless input[i - 1][j - 1].zero?
    neighs <<  [i - 1, j] unless input[i - 1][j].zero?
    neighs <<  [i + 1, j - 1] unless input[i + 1][j - 1].zero?
    neighs <<  [i + 1, j] unless input[i + 1][j].zero?
  else
    neighs <<  [i, j + 1] unless input[i][j + 1].zero?
    neighs <<  [i, j - 1] unless input[i][j - 1].zero?
    neighs <<  [i - 1, j] unless input[i - 1][j].zero?
    neighs <<  [i - 1, j - 1] unless input[i - 1][j - 1].zero?
    neighs <<  [i - 1, j + 1] unless input[i - 1][j + 1].zero?
    neighs <<  [i + 1, j] unless input[i + 1][j].zero?
    neighs <<  [i + 1, j + 1] unless input[i + 1][j + 1].zero?
    neighs <<  [i + 1, j - 1] unless input[i + 1][j - 1].zero?
  end
  neighs
end

# @input = %w[11111 19991 19191 19991 11111]
# @input = %w[5483143223 2745854711 5264556173 6141336146 6357385478
#             4167524645 2176841721 6882881134 4846848554 5283751526]
@input = File.readlines('../1_Input/day11.input').map(&:strip)
input2 = []

@input.each do |row|
  input2 << row.split('').map(&:to_i)
end

@input = input2.clone

# puts 'Initial state'
# pp @input
# puts

total_flashes = 0

100.times do # |k|
  @new_input = @input.clone

  i = 0
  to_flash = []
  while i < @input.length
    j = 0
    while j < @input[i].length
      @new_input[i][j] = (@input[i][j] + 1) % 10
      if @new_input[i][j].zero?
        to_flash << [i, j]
        total_flashes += 1
      end
      j += 1
    end
    i += 1
  end

  while to_flash.any?
    fl = to_flash.pop
    x = fl[0]
    y = fl[1]

    neighs = neighbours(x, y, @new_input)
    neighs.each do |n|
      xx = n[0]
      yy = n[1]
      @new_input[xx][yy] = (@new_input[xx][yy] + 1) % 10
      if @new_input[xx][yy].zero?
        to_flash << n
        total_flashes += 1
      end
    end
  end

  @input = @new_input
  # puts "After step #{k + 1}"
  # pp @input
  # puts
end

puts total_flashes
