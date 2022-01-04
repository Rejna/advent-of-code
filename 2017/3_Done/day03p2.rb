# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 3 Part 2
# https://adventofcode.com/2017/day/3#part2
# Answer is: 312453

def direction(step)
  case step % 4
  when 0
    [0, 1]
  when 1
    [-1, 0]
  when 2
    [0, -1]
  else
    [1, 0]
  end
end

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
  neighbours.sum
end

input = 312_051
size  = 10
board = []
size.times.each do
  board << Array.new(size, 0)
end

x = size / 2
y = size / 2
board[y][x] = 1
step = 0
moves = 1

loop do
  done = false
  moves.times.each do
    dir = direction(step)
    y += dir[0]
    x += dir[1]
    board[y][x] = neighbours(y, x, board)
    next unless board[y][x] > input

    puts board[y][x]
    done = true
    break
  end

  break if done

  step += 1
  moves += 1 if (step % 2).zero?
end
