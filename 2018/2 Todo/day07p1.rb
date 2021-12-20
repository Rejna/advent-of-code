# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 7 Part 1
# https://adventofcode.com/2018/day/7
# Answer is: ???

input = ['Step C must be finished before step A can begin.', 'Step C must be finished before step F can begin.',
         'Step A must be finished before step B can begin.', 'Step A must be finished before step D can begin.',
         'Step B must be finished before step E can begin.', 'Step D must be finished before step E can begin.',
         'Step F must be finished before step E can begin.']
# input = File.readlines('../1 Input/day07.input').map(&:strip)

def rec(cur, finish, stack)
  stack << cur
  stack << [*rules[cur]]
  rules[cur].each do |rule|
    rec(rule, finish, stack) unless rule == finish
  end
  stack
end

rules = {}
lefts = []
rights = []

input.each do |rule|
  rs = rule.split(' ')
  left = rs[1]
  right = rs[7]
  rules[left] = [right] unless rules.keys.include?(left)
  rules[left] << right if rules.keys.include?(left) && !rules[left].include?(right)
  lefts << left unless lefts.include?(left)
  rights << right unless rights.include?(right)
end
rules.values.map(&:sort)

pp rules
pp lefts
pp rights
start = rules.keys.difference(rights)
finish = rights.difference(rules.keys)

stack = []
rec(start, finish, stack)

pp stack
