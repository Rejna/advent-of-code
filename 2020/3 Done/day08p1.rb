# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 8 Part 1
# https://adventofcode.com/2020/day/8
# Answer is: 1709

# input = ['nop +0', 'acc +1', 'jmp +4', 'acc +3', 'jmp -3', 'acc -99', 'acc +1', 'jmp -4', 'acc +6']
input = File.readlines('../1 Input/day08.input').map(&:strip)
acc = 0
before_acc = 0
index = 0
visited_lines = []
stop = false

loop do
  split_line = input[index].split(' ')
  command = split_line[0]
  param = split_line[1]

  case command
  when 'nop'
    stop = visited_lines.include?(index)
    visited_lines << index
    before_acc = acc

    index += 1
  when 'acc'
    stop = visited_lines.include?(index)
    visited_lines << index
    before_acc = acc

    add = param.include?('+')
    acc += param.gsub!('+', '').to_i if add
    acc -= param.gsub!('-', '').to_i unless add
    index += 1
  when 'jmp'
    stop = visited_lines.include?(index)
    visited_lines << index
    before_acc = acc

    add = param.include?('+')
    index += param.gsub!('+', '').to_i if add
    index -= param.gsub!('-', '').to_i unless add
  end

  break if stop
end

puts before_acc
