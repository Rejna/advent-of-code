# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 8 Part 1
# https://adventofcode.com/2021/day/8
# Answer is: 362

# input = ['be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
#          'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
#          'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
#          'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
#          'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
#          'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
#          'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
#          'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
#          'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
#          'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce']
input = File.readlines('day08.input').map(&:strip)

sum = 0
input.each do |row|
  rs = row.split(' | ')[1].split(' ')
  tal = rs.map(&:length).tally
  sum += tal[2] || 0
  sum += tal[3] || 0
  sum += tal[4] || 0
  sum += tal[7] || 0
end

puts sum
# 1 - 2 seg

# 7 - 3 seg

# 4 - 4 seg

# 2 - 5 seg
# 3 - 5 seg
# 5 - 5 seg

# 0 - 6 seg
# 6 - 6 seg
# 9 - 6 seg

# 8 - 7 seg
