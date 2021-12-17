# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 4 Part 2
# https://adventofcode.com/2020/day/4#part2
# Answer is: 109

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
    if p.include?(f)
      passport_fields = p.split(' ')
      passport_fields.each do |pf|
        pf = pf.split(':')

        case pf[0]
        when 'byr'
          unless pf[1].to_i >= 1920 && pf[1].to_i <= 2002
            # puts "#{p} invalid, byr #{pf[1]} out of range"
            valid = false
            break
          end
        when 'iyr'
          unless pf[1].to_i >= 2010 && pf[1].to_i <= 2020
            # puts "#{p} invalid, iyr #{pf[1]} out of range"
            valid = false
            break
          end
        when 'eyr'
          unless pf[1].to_i >= 2020 && pf[1].to_i <= 2030
            # puts "#{p} invalid, eyr #{pf[1]} out of range"
            valid = false
            break
          end
        when 'hgt'
          if pf[1].include?('cm')
            pf[1] = pf[1].gsub!('cm', '').to_i
            unless pf[1] >= 150 && pf[1] <= 193
              # puts "#{p} invalid, hgt #{pf[1]}cm out of range"
              valid = false
              break
            end
          elsif pf[1].include?('in')
            pf[1] = pf[1].gsub!('in', '').to_i
            unless pf[1] >= 59 && pf[1] <= 76
              # puts "#{p} invalid, hgt #{pf[1]}in out of range"
              valid = false
              break
            end
          else
            # puts "#{p} invalid, hgt #{pf[1]} without unit"
            valid = false
            break
          end
        when 'hcl'
          unless pf[1] =~ /^#[0-9a-f]{6}$/
            # puts "#{p} invalid, hcl #{pf[1]} invalid"
            valid = false
            break
          end
        when 'ecl'
          colors = %w[amb blu brn gry grn hzl oth]
          unless colors.include?(pf[1])
            # puts "#{p} invalid, ecl #{pf[1]} invalid"
            valid = false
            break
          end
        when 'pid'
          unless pf[1] =~ /^[0-9]{9}$/
            # puts "#{p} invalid, pid #{pf[1]} invalid"
            valid = false
            break
          end
        end
        break unless valid
      end
      break unless valid
    else
      # puts "#{p} invalid, missing #{f}"
      valid = false
      break
    end
  end
  valid_count += 1 if valid
end
puts valid_count
