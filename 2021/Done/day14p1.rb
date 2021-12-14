# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 14 Part 1
# https://adventofcode.com/2021/day/14
# Answer is: 3230

# input = 'NNCB'
# p = ['CH -> B', 'HH -> N', 'CB -> H', 'NH -> C', 'HB -> C', 'HC -> B', 'HN -> C', 'NN -> C', 'BH -> H',
#      'NC -> B', 'NB -> B', 'BN -> B', 'BB -> N', 'BC -> B', 'CC -> N', 'CN -> C']
input = 'NCOPHKVONVPNSKSHBNPF'
p = ['ON -> C', 'CK -> H', 'HC -> B', 'NP -> S', 'NH -> H', 'CB -> C', 'BB -> H', 'BC -> H', 'NN -> C', 'OH -> B',
     'SF -> V', 'PB -> H', 'CP -> P', 'BN -> O', 'NB -> B', 'KB -> P', 'PV -> F', 'SH -> V', 'KP -> S', 'OF -> K',
     'BS -> V', 'PF -> O', 'BK -> S', 'FB -> B', 'SV -> B', 'BH -> V', 'VK -> N', 'CS -> V', 'FV -> F', 'HS -> C',
     'KK -> O', 'SP -> N', 'FK -> B', 'CF -> C', 'HP -> F', 'BF -> O', 'KC -> C', 'VP -> O', 'BP -> P', 'FF -> V',
     'NO -> C', 'HK -> C', 'HV -> B', 'PK -> P', 'OV -> F', 'VN -> H', 'PC -> K', 'SB -> H', 'VO -> V', 'BV -> K',
     'NC -> H', 'OB -> S', 'SN -> B', 'HF -> P', 'VF -> B', 'HN -> H', 'KS -> S', 'SC -> S', 'CV -> B', 'NS -> P',
     'KO -> V', 'FS -> O', 'PH -> K', 'BO -> C', 'FH -> B', 'CO -> O', 'FO -> F', 'VV -> N', 'CH -> V', 'NK -> N',
     'PO -> K', 'OK -> K', 'PP -> O', 'OC -> P', 'FC -> N', 'VH -> S', 'PN -> C', 'VB -> C', 'VS -> P', 'HO -> F',
     'OP -> S', 'HB -> N', 'CC -> K', 'KN -> S', 'SK -> C', 'OS -> N', 'KH -> B', 'FP -> S', 'NF -> S', 'CN -> S',
     'KF -> C', 'SS -> C', 'SO -> S', 'NV -> O', 'FN -> B', 'PS -> S', 'HH -> C', 'VC -> S', 'OO -> C', 'KV -> P']
pairs = {}

p.each do |pair|
  ps = pair.split(' -> ')
  pairs[ps[0]] = ps[1]
end

# puts "Initial state: #{input}"

10.times do # |k|
  new_input = ''
  i = 0
  while i < input.length - 1
    new_input += "#{input[i]}#{pairs["#{input[i]}#{input[i + 1]}"]}"
    new_input += input[i + 1] if i == input.length - 2
    i += 1
  end

  input = new_input
  # t = input.split('').tally
  # puts "After step #{k + 1}: #{t.values.max - t.values.min}"
end

t = input.split('').tally
puts t.values.max - t.values.min
