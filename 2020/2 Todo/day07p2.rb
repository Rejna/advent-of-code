# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 7 Part 2
# https://adventofcode.com/2020/day/7#part2
# Answer is: ???

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
base_bags = []

input.each do |line|
  line = line.split(' bags contain ')
  bag_name = line[0]
  bag_rules = []
  line[1].split(', ').each do |l|
    if l == 'no other bags.'
      base_bags << [1, bag_name]
    else
      bag_rules << [l.split(' ')[0].to_i, l.split(' ').drop(1).take(2).join(' ')]
    end
  end

  rules[bag_name] = bag_rules
end

total_bags = 0
base_bags2 = []
base_bags_names = []

while rules['shiny gold'][0][0] == 1
  rules.each do |k, v|
    v.each do |r|
      base_bags.each do |bb|
        next unless bb[1] == r[1] && bb[1] != k

        r[0] *= bb[0]
        puts "#{k} #{bb} #{r}"
        base_bags2 << [k, r[0]] unless base_bags_names.include?(k)
        base_bags_names << k unless base_bags_names.include?(k)
      end
    end
  end
  puts base_bags2
  base_bags = base_bags2
  base_bags2 = []
end

puts rules
puts total_bags
