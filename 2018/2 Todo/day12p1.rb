# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 12
# https://adventofcode.com/2018/day/12
# Answer is: ???

# init = '#..#.#..##......###...###'
# rules = ['...## => #', '..#.. => #', '.#... => #', '.#.#. => #', '.#.## => #', '.##.. => #', '.#### => #',
#          '#.#.# => #', '#.### => #', '##.#. => #', '##.## => #', '###.. => #', '###.# => #', '####. => #']

raw_input = File.readlines('../1 Input/day12.input').map(&:strip)
init = raw_input[0].gsub('initial state: ', '')
rules = raw_input[2..]

processed_rules = {}

rules.each do |rule|
  sr = rule.split(' => ')
  processed_rules[sr[0]] = sr[1]
end

init = Array.new(3, '.').join('') + init + Array.new(init.length / 4, '.').join('')
puts "0:  #{init}"

20.times do |k|
  new_init = Array.new(init.length, '.').join
  i = 3
  while i < init.length - 2
    section = init[i - 2, 5]

    new_init[i] = processed_rules[section]
    # new_init[i] = '#' if processed_rules.keys.include?(section)
    # new_init[i] = '.' unless processed_rules.keys.include?(section)
    i += 1
  end

  value = 0
  i = 0
  while i < new_init.length
    value += i - 3 if new_init[i] == '#'
    i += 1
  end
  init = new_init
  puts "#{k + 1}:#{k > 8 ? ' ' : '  '}#{init} #{value}"
end
