# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 18 Part 1
# https://adventofcode.com/2017/day/18
# Answer is: 8600

input = File.readlines('../1_Input/day18.input').map(&:strip)
# input = File.readlines('../1_Input/day18test.input').map(&:strip)

registers = Hash.new { |h, v| h[v] = 0 }
pointer = 0
last_sound = 0
played_sound = 0

loop do
  command = input[pointer]
  sp = command.split(' ')
  opcode = sp[0]
  register = sp[1]
  value = sp[2] =~ /\d/ ? sp[2].to_i : registers[sp[2]] unless %w[snd rcv].include?(opcode)
  jumped = false

  case opcode
  when 'set'
    registers[register] = value
  when 'snd'
    played_sound = registers[register]
  when 'add'
    registers[register] += value
  when 'mul'
    registers[register] *= value
  when 'mod'
    registers[register] %= value
  when 'rcv'
    unless registers[register].zero?
      last_sound = played_sound
      break
    end
  when 'jgz'
    if registers[register].positive?
      pointer += value
      jumped = true
    end
  end

  pointer += 1 unless jumped
  break if pointer >= input.length || pointer.negative?
end

puts last_sound
