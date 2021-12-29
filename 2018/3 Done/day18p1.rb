# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 18 Part 1
# https://adventofcode.com/2018/day/18
# Answer is: 644640

def neighbours(i, j, input)
  neighbours = []
  if i.zero?
    if j.zero?
      neighbours << input[i][j + 1]
      neighbours << input[i + 1][j + 1]
      neighbours << input[i + 1][j]
    elsif j == input[i].length - 1
      neighbours << input[i][j - 1]
      neighbours << input[i + 1][j - 1]
      neighbours << input[i + 1][j]
    else
      neighbours << input[i][j + 1]
      neighbours << input[i][j - 1]
      neighbours << input[i + 1][j]
      neighbours << input[i + 1][j - 1]
      neighbours << input[i + 1][j + 1]
    end
  elsif i == input.length - 1
    if j.zero?
      neighbours << input[i][j + 1]
      neighbours << input[i - 1][j + 1]
      neighbours << input[i - 1][j]
    elsif j == input[i].length - 1
      neighbours << input[i][j - 1]
      neighbours << input[i - 1][j - 1]
      neighbours << input[i - 1][j]
    else
      neighbours << input[i][j + 1]
      neighbours << input[i][j - 1]
      neighbours << input[i - 1][j]
      neighbours << input[i - 1][j + 1]
      neighbours << input[i - 1][j - 1]
    end
  elsif j.zero?
    neighbours << input[i + 1][j + 1]
    neighbours << input[i + 1][j]
    neighbours << input[i][j + 1]
    neighbours << input[i - 1][j + 1]
    neighbours << input[i - 1][j]
  elsif j == input[i].length - 1
    neighbours << input[i][j - 1]
    neighbours << input[i - 1][j - 1]
    neighbours << input[i - 1][j]
    neighbours << input[i + 1][j - 1]
    neighbours << input[i + 1][j]
  else
    neighbours << input[i][j + 1]
    neighbours << input[i][j - 1]
    neighbours << input[i - 1][j]
    neighbours << input[i - 1][j - 1]
    neighbours << input[i - 1][j + 1]
    neighbours << input[i + 1][j]
    neighbours << input[i + 1][j + 1]
    neighbours << input[i + 1][j - 1]
  end
  neighbours.tally
end

# input = File.readlines('../1 Input/day18test.input').map(&:strip)
input = File.readlines('../1 Input/day18.input').map(&:strip)

forest = []
input.each do |row|
  forest << row.split('')
end

# puts 'Initial state:'
# forest.each do |row|
#   puts row.join('')
# end
# puts

10.times.each do # |minute|
  temp = forest.map(&:clone)

  i = 0
  while i < forest.length
    j = 0
    while j < forest[i].length
      neighs = neighbours(i, j, forest)

      case forest[i][j]
      when '.'
        temp[i][j] = '|' if (neighs['|'] || 0) >= 3
      when '#'
        temp[i][j] = '.' if (neighs['#'] || 0).zero? || (neighs['|'] || 0).zero?
      when '|'
        temp[i][j] = '#' if (neighs['#'] || 0) >= 3
      end

      j += 1
    end
    i += 1
  end

  forest = temp

  # puts "After #{minute + 1} minute#{minute.positive? ? 's' : ''}:"
  # forest.each do |row|
  #   puts row.join('')
  # end
  # puts
end

puts forest.flatten.tally['#'] * forest.flatten.tally['|']
