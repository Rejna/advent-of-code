# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 13 Part 1
# https://adventofcode.com/2017/day/13
# Answer is: 788

input = File.readlines('../1_Input/day13.input').map(&:strip)
# input = File.readlines('../1_Input/day13test.input').map(&:strip)

firewalls = {}
scanners = {}
going_down = {}

input.each do |firewall|
  sp = firewall.split(': ').map(&:to_i)
  firewalls[sp[0]] = sp[1]
  scanners[sp[0]] = 0
  going_down[sp[0]] = true
end

packet = 0
severity = 0

while packet <= firewalls.keys.max
  severity += packet * firewalls[packet] if scanners.key?(packet) && scanners[packet].zero?

  scanners.each do |k, v|
    if v == firewalls[k] - 1
      going_down[k] = false
    elsif v.zero?
      going_down[k] = true
    end

    if going_down[k]
      scanners[k] += 1
    else
      scanners[k] -= 1
    end
  end

  packet += 1
end

puts severity
