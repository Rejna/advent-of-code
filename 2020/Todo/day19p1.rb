# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 19 Part 1
# https://adventofcode.com/2020/day/19
# Answer is: ???

# input = ['0: 1 2', "1: 'a'", '2: 1 3 | 3 1', "3: 'b'"]
input = ['0: 4 1 5', '1: 2 3 | 3 2', '2: 4 4 | 5 5', '3: 4 5 | 5 4', "4: 'a'", "5: 'b'"]
messages = %w[ababbb bababa abbbab aaabbb aaaabbb]

rules = {}

input.each do |line|
  split_line = line.split(': ')
  rule_id = split_line[0]
  rules_arr = split_line[1]
  split_rules = rules_arr.split('|')
  rules[rule_id] = []

  split_rules.each do |rule|
    if split_rules.length == 1 && split_rules[0].include?('\'')
      rules[rule_id] = split_rules[0].gsub('\'', '')
    else
      rules[rule_id] << [*rule.split(' ')]
    end
  end
end

# a (23 | 32) b
# a ((44 | 55)(45 | 54) | (45 | 54)(44 | 55)) b
# a ((aa | bb)(ab | ba) | (ab | ba)(aa | bb)) b

puts rules
