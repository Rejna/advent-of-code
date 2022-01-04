# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 18 Part 2
# https://adventofcode.com/2017/day/18#part2
# Answer is: 7239

input = File.readlines('../1_Input/day18.input').map(&:strip)
# input = File.readlines('../1_Input/day18test2.input').map(&:strip)

registers = [Hash.new { |h, v| h[v] = 0 }, Hash.new { |h, v| h[v] = 0 }]
registers[0]['p'] = 0
registers[1]['p'] = 1
message_queues = [[], []]
pointers = [0, 0]
current_player = 0
counter = 0
jumped = [false, false]
halted = [false, false]
finished = [false, false]

loop do
  unless finished[current_player]
    command = input[pointers[current_player]]
    sp = command.split(' ')
    opcode = sp[0]
    lhs = sp[1] =~ /^[a-z]$/ ? registers[current_player][sp[1]] : sp[1].to_i
    lhs_register = sp[1]
    rhs = sp[2] =~ /^[a-z]$/ ? registers[current_player][sp[2]] : sp[2].to_i unless %w[snd rcv].include?(opcode)
    jumped[current_player] = false

    case opcode
    when 'set'
      registers[current_player][lhs_register] = rhs
    when 'snd'
      counter += 1 if current_player == 1
      receiver = current_player.zero? ? 1 : 0
      message_queues[receiver] << registers[current_player][lhs_register]
    when 'add'
      registers[current_player][lhs_register] += rhs
    when 'mul'
      registers[current_player][lhs_register] *= rhs
    when 'mod'
      registers[current_player][lhs_register] %= rhs
    when 'rcv'
      if message_queues[current_player].empty?
        halted[current_player] = true
      else
        halted[current_player] = false
        registers[current_player][lhs_register] = message_queues[current_player].shift
      end
    when 'jgz'
      if lhs.positive?
        pointers[current_player] += rhs
        jumped[current_player] = true
      end
    end

    pointers[current_player] += 1 if !jumped[current_player] && !halted[current_player]
    finished[current_player] = true if pointers[current_player] >= input.length || pointers[current_player].negative?
    if halted.all? { |k| k == true }
      puts 'DEADLOCK!'
      break
    end
  end

  if finished.all? { |k| k == true }
    puts 'All done'
    break
  end

  current_player = current_player.zero? ? 1 : 0
end

puts counter
