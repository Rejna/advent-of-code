# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 16 Part 1
# https://adventofcode.com/2020/day/16
# Answer is: 27870

# rules = ['class: 1-3 or 5-7', 'row: 6-11 or 33-44', 'seat: 13-40 or 45-50']
# tickets = %w[7,3,47 40,4,50 55,2,20 38,6,12]
rules = []
tickets = []
rules_processed = []
raw_input = File.readlines('../1 Input/day16.input').map(&:strip)
raw_input.each do |row|
  break if row == ''

  rules << row
end

raw_input[(rules.length + 5)..].each do |row|
  tickets << row
end

rules.each do |rule|
  s = rule.split(': ')[1]
  ranges = s.split(' or ')

  ranges.each do |range|
    range_arr = [*range.split('-').map(&:to_i)]
    rules_processed << range_arr
  end
end

sum = 0

tickets.each do |ticket|
  ticket_values = ticket.split(',').map(&:to_i)
  t = {}
  ticket_values.each do |value|
    valid = []
    rules_processed.each do |rule|
      valid << (value >= rule[0] && value <= rule[1])
    end
    t[value] = valid
  end
  t.each do |k, v|
    sum += k if v.all?(false)
  end
end

puts sum
