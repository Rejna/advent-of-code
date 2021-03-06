# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 10 Part 2
# https://adventofcode.com/2021/day/10#part2
# Answer is: 3969823589

# input = ['[({(<(())[]>[[{[]{<()<>>', '[(()[<>])]({[<{<<[]>>(', '{([(<{}[<>[]}>{[]{[(<()>', '(((({<>}<{<{<>}{[]{[]{}',
#          '[[<[([]))<([[{}[[()]]]', '[{[{({}]{}}([{[{{{}}([]', '{<[[]]>}<{[{[{[]{()[[[]', '[<(<(<(<{}))><([]([]()',
#          '<{([([[(<>()){}]>(<<{{', '<{([{{}}[<[[[<>{}]]]>[]]']

input = File.readlines('../1_Input/day10.input').map(&:strip)

scores = {
  '(' => 1,
  '[' => 2,
  '{' => 3,
  '<' => 4
}

incomplete = []
input.each do |row|
  stack = []
  corrupted = false
  rs = row.split('')
  rs.each do |c|
    if ['[', '{', '(', '<'].include?(c)
      stack << c
    elsif (c == ']' && stack.last == '[') || (c == '}' && stack.last == '{') ||
          (c == ')' && stack.last == '(') || (c == '>' && stack.last == '<')
      stack.pop
    else
      corrupted = true
    end
    break if corrupted
  end
  incomplete << stack unless corrupted
end

contest_scores = []
incomplete.each do |row|
  score = 0
  row.reverse.each do |bracket|
    score = score * 5 + scores[bracket]
  end
  contest_scores << score
end

puts contest_scores.sort[(contest_scores.length - 1) / 2]
