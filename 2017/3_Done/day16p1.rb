# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 16 Part 1
# https://adventofcode.com/2017/day/16
# Answer is: bkgcdefiholnpmja

def update_positions(programs, positions)
  i = 0
  while i < programs.length
    positions[programs[i]] = i
    i += 1
  end
  positions
end

input = File.readlines('../1_Input/day16.input').map(&:strip)[0].split(',')
programs = %w[a b c d e f g h i j k l m n o p]
# input = File.readlines('../1_Input/day16test.input').map(&:strip)[0].split(',')
# programs = %w[a b c d e]

programs_positions = {}
programs.each do |p|
  programs_positions[p] = programs.index(p)
end

input.each do |move|
  case move[0]
  when 's'
    take = move[1..].to_i
    lhs = programs.last(take)
    rhs = programs.first(programs.length - take)
    programs = lhs + rhs
  when 'x'
    hs = move[1..].split('/').map(&:to_i)
    lhs = hs[0]
    rhs = hs[1]

    a = programs[lhs]
    b = programs[rhs]
    programs[lhs] = b
    programs[rhs] = a
  when 'p'
    hs = move[1..].split('/')
    lhs = programs_positions[hs[0]]
    rhs = programs_positions[hs[1]]

    a = programs[lhs]
    b = programs[rhs]
    programs[lhs] = b
    programs[rhs] = a
  end
  programs_positions = update_positions(programs, programs_positions)
end

puts programs.join('')
