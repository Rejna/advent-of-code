# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 8 Part 2
# https://adventofcode.com/2020/day/8#part2
# Answer is: 1976

# input = ['nop +0', 'acc +1', 'jmp +4', 'acc +3', 'jmp -3', 'acc -99', 'acc +1', 'jmp -4', 'acc +6']
input = File.readlines('../1 Input/day08.input').map(&:strip)
i = 0
input.each do |line|
  c = line.split(' ')
  unless c[0] == 'acc'
    rep = c[0] == 'jmp' ? 'nop' : 'jmp'
    input2 = input[0, i] + ["#{rep} #{c[1]}"] + input[i + 1..]

    acc = 0
    index = 0
    visited_lines = []
    stop = false

    loop do
      split_line = input2[index].split(' ')
      command = split_line[0]
      param = split_line[1]

      case command
      when 'nop'
        stop = visited_lines.include?(index)
        visited_lines << index

        index += 1
      when 'acc'
        stop = visited_lines.include?(index)
        visited_lines << index

        add = param.include?('+')
        acc += param.gsub!('+', '').to_i if add
        acc -= param.gsub!('-', '').to_i unless add
        index += 1
      when 'jmp'
        stop = visited_lines.include?(index)
        visited_lines << index

        add = param.include?('+')
        index += param.gsub!('+', '').to_i if add
        index -= param.gsub!('-', '').to_i unless add
      end

      break if stop
      break if index == input2.length
    end

    puts acc unless stop
  end
  i += 1
end
