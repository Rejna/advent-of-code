# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 8 Part 2
# https://adventofcode.com/2021/day/8#part2
# Answer is: 1020159

# input = ['acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf']

# input = ['be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
#          'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
#          'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
#          'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
#          'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
#          'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
#          'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
#          'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
#          'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
#          'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce']
input = File.readlines('day08.input').map(&:strip)

def pattern_to_segments(letters_map, pattern)
  n = []
  pattern.each do |p|
    n << letters_map[p]
  end
  n
end

def print_pattern(pattern)
  p = ''

  p += pattern.include?('top') ? ' XXXX ' : ' .... '
  p += 10.chr

  p += pattern.include?('top-left') ? 'X' : '.'
  p += pattern.include?('top-right') ? '    X' : '    .'
  p += 10.chr
  p += pattern.include?('top-left') ? 'X' : '.'
  p += pattern.include?('top-right') ? '    X' : '    .'
  p += 10.chr

  p += pattern.include?('mid') ? ' XXXX ' : ' .... '
  p += 10.chr

  p += pattern.include?('bot-left') ? 'X' : '.'
  p += pattern.include?('bot-right') ? '    X' : '    .'
  p += 10.chr
  p += pattern.include?('bot-left') ? 'X' : '.'
  p += pattern.include?('bot-right') ? '    X' : '    .'
  p += 10.chr

  p += pattern.include?('bot') ? ' XXXX ' : ' .... '
  p += 10.chr

  p
end

sum = 0
input.each do |row|
  numbers = {}
  segments_map = {}
  rev_segments_map = {}
  rs = row.split(' | ')
  digits_to_identify = rs[1].split(' ').map { |t| t.split('') }.map(&:sort)
  digits_patterns = rs[0].split(' ').map { |t| t.split('') }.map(&:sort)

  numbers[1] = digits_patterns.select { |t| t.length == 2 }.first
  digits_patterns.delete(numbers[1])
  numbers[7] = digits_patterns.select { |t| t.length == 3 }.first
  digits_patterns.delete(numbers[7])
  numbers[4] = digits_patterns.select { |t| t.length == 4 }.first
  digits_patterns.delete(numbers[4])
  numbers[8] = digits_patterns.select { |t| t.length == 7 }.first
  digits_patterns.delete(numbers[8])

  segments_map[numbers[7].difference(numbers[1])[0]] = 'top'
  rev_segments_map['top'] = numbers[7].difference(numbers[1])[0]

  corner = numbers[8].difference(numbers[7], numbers[4], numbers[1])
  digits_patterns.select { |p| p.length == 6 }.each do |pat|
    single = pat.difference(corner, numbers[7])
    next unless single.length == 1

    numbers[0] = pat
    segments_map[single[0]] = 'top-left'
    rev_segments_map['top-left'] = single[0]
    break
  end
  digits_patterns.delete(numbers[0])

  mid = numbers[4].difference([rev_segments_map['top-left']], numbers[1])[0]
  segments_map[mid] = 'mid'
  rev_segments_map['mid'] = mid

  digits_patterns.select { |p| p.length == 6 }.each do |pat|
    single = pat.difference(rev_segments_map.values, numbers[1])
    next unless single.length == 1

    numbers[9] = pat
    segments_map[single[0]] = 'bot'
    rev_segments_map['bot'] = single[0]
    break
  end
  digits_patterns.delete(numbers[9])
  numbers[6] = digits_patterns.select { |p| p.length == 6 }.first
  digits_patterns.delete(numbers[6])

  # only 5-segments left - 2, 3, 5
  digits_patterns.each do |pat|
    single = pat.difference(rev_segments_map.values)
    next unless single.length == 1

    numbers[5] = pat
    segments_map[single[0]] = 'bot-right'
    rev_segments_map['bot-right'] = single[0]
    break
  end
  digits_patterns.delete(numbers[5])

  # only 5-segments left - 2, 3
  digits_patterns.each do |pat|
    single = pat.difference([rev_segments_map['top'], rev_segments_map['mid'], rev_segments_map['bot']], numbers[1])
    next unless single.length == 1

    numbers[2] = pat
    segments_map[single[0]] = 'top-right'
    rev_segments_map['top-right'] = single[0]
    break
  end
  digits_patterns.delete(numbers[2])
  numbers[3] = digits_patterns[0]

  last_letter = %w[a b c d e f g].difference(segments_map.keys)[0]
  last_segment = 'bot-left'
  segments_map[last_letter] = last_segment
  rev_segments_map[last_segment] = last_letter

  # puts print_pattern(pattern_to_segments(segments_map, numbers[0]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[1]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[2]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[3]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[4]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[5]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[6]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[7]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[8]))
  # puts print_pattern(pattern_to_segments(segments_map, numbers[9]))

  number = ''
  digits_to_identify.each do |d|
    i = 0
    while i < 10
      if numbers[i] == d
        number += i.to_s
        break
      end
      i += 1
    end
  end
  sum += number.to_i
end

puts sum
