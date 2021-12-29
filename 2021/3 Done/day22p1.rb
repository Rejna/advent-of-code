# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 22 Part 1
# https://adventofcode.com/2021/day/22
# Answer is: 655005

# input = File.readlines('../1 Input/day22smalltest.input').map(&:strip)
# input = File.readlines('../1 Input/day22test.input').map(&:strip)
input = File.readlines('../1 Input/day22.input').map(&:strip)

size = 50
board = []
i = 0
while i < 2 * size + 1
  board << []
  j = 0
  while j < 2 * size + 1
    board[i] << []
    k = 0
    while k < 2 * size + 1
      board[i][j][k] = false
      k += 1
    end
    j += 1
  end
  i += 1
end

active_count = 0

input.each do |command|
  input_s = command.split(' ')
  switch = input_s[0] # on/off
  coords = input_s[1].split(',')

  x_range = coords[0].gsub('x=', '').split('..').map(&:to_i).map { |a| a + size }
  y_range = coords[1].gsub('y=', '').split('..').map(&:to_i).map { |a| a + size }
  z_range = coords[2].gsub('z=', '').split('..').map(&:to_i).map { |a| a + size }

  unless x_range.all? { |a| a.abs <= 2 * size } && y_range.all? { |a| a.abs <= 2 * size } && z_range.all? { |a| a.abs <= 2 * size }
    # puts "#{command} skip"
    next
  end

  x = x_range[0]
  while x <= x_range[1]
    y = y_range[0]
    while y <= y_range[1]
      z = z_range[0]
      while z <= z_range[1]
        active_count += 1 if switch == 'on' && board[x][y][z] == false
        active_count -= 1 if switch == 'off' && board[x][y][z] == true
        board[x][y][z] = switch == 'on'
        z += 1
      end
      y += 1
    end
    x += 1
  end

  # puts "Active count: #{active_count}"
end

puts active_count
