# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 10 Part 1
# https://adventofcode.com/2021/day/10
# Answer is: 265527

# input = ['[({(<(())[]>[[{[]{<()<>>', '[(()[<>])]({[<{<<[]>>(', '{([(<{}[<>[]}>{[]{[(<()>', '(((({<>}<{<{<>}{[]{[]{}',
#          '[[<[([]))<([[{}[[()]]]', '[{[{({}]{}}([{[{{{}}([]', '{<[[]]>}<{[{[{[]{()[[[]', '[<(<(<(<{}))><([]([]()',
#          '<{([([[(<>()){}]>(<<{{', '<{([{{}}[<[[[<>{}]]]>[]]']

input = File.readlines('../1 Input/day10.input').map(&:strip)

errors = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}

error_sum = 0
input.each do |row|
  stack = []
  rs = row.split('')
  rs.each do |c|
    if ['[', '{', '(', '<'].include?(c)
      stack << c
    elsif (c == ']' && stack.last == '[') || (c == '}' && stack.last == '{') ||
          (c == ')' && stack.last == '(') || (c == '>' && stack.last == '<')
      stack.pop
    else
      error_sum += errors[c]
      break
    end
  end
end

puts error_sum
