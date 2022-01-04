# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 3 Part 1
# https://adventofcode.com/2017/day/3
# Answer is: 430

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

# inputs = [1, 12, 23, 1024]
inputs = [312_051]

inputs.each do |input|
  size  = 575
  board = []
  size.times.each do
    board << Array.new(size, 0)
  end

  mid_x = size / 2
  mid_y = size / 2
  x = size / 2
  y = size / 2
  board[y][x] = 1
  step = 0
  moves = 1

  loop do
    done = false
    moves.times.each do
      dir = direction(step)
      prev = board[y][x]
      if prev == input
        puts (y - mid_y).abs + (x - mid_x).abs
        done = true
        break
      end
      y += dir[0]
      x += dir[1]
      board[y][x] = prev + 1
    end

    break if done

    step += 1
    moves += 1 if (step % 2).zero?
  end
end
