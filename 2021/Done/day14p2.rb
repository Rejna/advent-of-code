# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 14 Part 2
# https://adventofcode.com/2021/day/14#part2
# Answer is: 3542388214529

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

pairs_tally = {}

i = 0
while i < input.length - 1
  pair = "#{input[i]}#{input[i + 1]}"
  pairs_tally[pair] += 1 if pairs_tally.key?(pair)
  pairs_tally[pair] = 1 unless pairs_tally.key?(pair)
  i += 1
end

40.times do # |k|
  new_pairs_tally = {}

  pairs_tally.each do |key, val|
    new_pair_one = "#{key[0]}#{pairs[key]}"
    new_pair_two = "#{pairs[key]}#{key[1]}"

    new_pairs_tally[new_pair_one] += val if new_pairs_tally.key?(new_pair_one)
    new_pairs_tally[new_pair_one] = val unless new_pairs_tally.key?(new_pair_one)

    new_pairs_tally[new_pair_two] += val if new_pairs_tally.key?(new_pair_two)
    new_pairs_tally[new_pair_two] = val unless new_pairs_tally.key?(new_pair_two)
  end

  pairs_tally = new_pairs_tally.clone

  # puts "After step #{k + 1}: #{letter_tally.max - letter_tally.min}"
end

letter_tally = {}
pairs_tally.each do |key, val|
  letter_tally[key[0]] += val if letter_tally.key?(key[0])
  letter_tally[key[0]] = val unless letter_tally.key?(key[0])

  letter_tally[key[1]] += val if letter_tally.key?(key[1])
  letter_tally[key[1]] = val unless letter_tally.key?(key[1])
end

letter_tally = letter_tally.values.map { |v| (v.to_f / 2).ceil }
puts letter_tally.max - letter_tally.min
