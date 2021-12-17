# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 16 Part 2
# https://adventofcode.com/2020/day/16#part2
# Answer is: ??

# rules = ['class: 1-3 or 5-7', 'row: 6-11 or 33-44', 'seat: 13-40 or 45-50']
# tickets = %w[7,3,47 40,4,50 55,2,20 38,6,12]

# rules = ['class: 0-1 or 4-19', 'row: 0-5 or 8-19', 'seat: 0-13 or 16-19']
# tickets = %w[3,9,18 15,1,5 5,14,9]
# your_ticket = '11,12,13'

rules = []
tickets = []
rules_processed = []
raw_input = File.readlines('../1 Input/day16.input').map(&:strip)
raw_input.each do |row|
  break if row == ''

  rules << row
end

your_ticket = raw_input[rules.length + 2]

raw_input[(rules.length + 5)..].each do |row|
  tickets << row
end
rules_processed = {}
rules_processed_arr = []

rules.each do |rule|
  rule_name = rule.split(': ')[0]
  s = rule.split(': ')[1]
  ranges = s.split(' or ')

  rules_processed[rule_name] = []
  ranges.each do |range|
    range_arr = [*range.split('-').map(&:to_i)]
    rules_processed_arr << range_arr
    rules_processed[rule_name] << range_arr
  end
end

valid_tickets = []

tickets.each do |ticket|
  valid_total = true
  ticket_values = ticket.split(',').map(&:to_i)
  t = {}
  ticket_values.each do |value|
    valid = []
    rules_processed_arr.each do |rule|
      valid << (value >= rule[0] && value <= rule[1])
    end
    t[value] = valid
  end
  t.each do |_k, v|
    valid_total = false if v.all?(false)
  end

  valid_tickets << ticket if valid_total
end

valid_tickets_transposed = []
i = 0
while i < valid_tickets[0].split(',').length
  field = []
  valid_tickets.each do |ticket|
    field << ticket.split(',')[i].to_i
  end
  valid_tickets_transposed << field
  i += 1
end

assigned_rules = []
field_map = {}
i = 0
rules_processed.each do |k, v|
  valid_tickets_transposed.each do |ticket|
    rule1 = v[0]
    rule2 = v[1]
    if !assigned_rules.include?(k) &&
       ticket.all? { |t| (t >= rule1[0] && t <= rule1[1]) || (t >= rule2[0] && t <= rule2[1]) }
      assigned_rules << k
      field_map[i] = k
    end
  end
  i += 1
end

your_ticket = your_ticket.split(',').map(&:to_i)
i = 0
result = 1
puts 'my ticket is:'
while i < field_map.keys.length
  puts "#{field_map[i]} #{your_ticket[i]}"
  result *= your_ticket[i] if field_map[i].include?('departure')
  i += 1
end
puts result
