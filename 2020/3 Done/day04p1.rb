# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 4 Part 1
# https://adventofcode.com/2020/day/4
# Answer is: 182

fields = %w[byr iyr eyr hgt hcl ecl pid]
# input = ['ecl:gry pid:860033327 eyr:2020 hcl:#fffffd', 'byr:1937 iyr:2017 cid:147 hgt:183cm',
#          'iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884', 'hcl:#cfa07d byr:1929', 'hcl:#ae17e1 iyr:2013',
#          'eyr:2024', 'ecl:brn pid:760753108 byr:1931', 'hgt:179cm', 'hcl:#cfa07d eyr:2025 pid:166559648',
#          'iyr:2011 ecl:brn hgt:59in']
input = File.readlines('../1 Input/day04.input').map(&:strip)

passport = ''
passports = []
input.each do |line|
  if line == ''
    passports << passport.strip
    passport = ''
  else
    passport += " #{line}"
  end
end
passports << passport

valid_count = 0
passports.each do |p|
  valid = true
  fields.each do |f|
    next if p.include?(f)

    # puts "#{p} invalid, missing #{f}"
    valid = false
    break
  end
  valid_count += 1 if valid
end
puts valid_count
