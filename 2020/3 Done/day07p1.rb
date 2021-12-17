# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 7 Part 1
# https://adventofcode.com/2020/day/7
# Answer is: 248

# input = ['light red bags contain 1 bright white bag, 2 muted yellow bags.',
#          'dark orange bags contain 3 bright white bags, 4 muted yellow bags.',
#          'bright white bags contain 1 shiny gold bag.',
#          'muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.',
#          'shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.',
#          'dark olive bags contain 3 faded blue bags, 4 dotted black bags.',
#          'vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.',
#          'faded blue bags contain no other bags.', 'dotted black bags contain no other bags.']
input = File.readlines('../1 Input/day07.input').map(&:strip)
rules = {}

input.each do |line|
  line = line.split(' bags contain ')
  bag_name = line[0]
  bag_rules = []
  line[1].split(', ').each do |l|
    bag_rules << l.split(' ').drop(1).take(2).join(' ') unless l == 'no other bags.'
  end

  rules[bag_name] = bag_rules
end

valid_bags = []
bags_to_check = ['shiny gold']
bags_to_check2 = []

until bags_to_check.empty?
  rules.each do |k, v|
    bags_to_check.each do |bag|
      if v.include?(bag) && !valid_bags.include?(k)
        valid_bags << k
        bags_to_check2 << k
      end
    end
  end
  bags_to_check = bags_to_check2
  bags_to_check2 = []
end

puts valid_bags.length
