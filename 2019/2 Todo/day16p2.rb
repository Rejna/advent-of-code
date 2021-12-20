# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 16 Part 2
# https://adventofcode.com/2019/day/16
# Answer is: ???

def generate_pattern(digit, input_length)
  i = 1
  pattern = []
  while i <= (input_length.to_f / (4 * digit)).ceil
    pattern << Array.new(digit, 0)
    pattern << Array.new(digit, 1)
    pattern << Array.new(digit, 0)
    pattern << Array.new(digit, -1)
    i += 1
  end
  pattern.flatten.rotate(1).take(input_length)
end

input = '03036732577212944063491565474664'
# input = '19617804207202209144916044189917'
# input = '69317163492948606335995924319873'
# input = '597509395456041704904488069040539960193347671996345499088347757214057395968619526462549794831844711620362923' \
#         '904207940270643639548851475608679136058824896224870484790553962727241593014640583993468113282333223265274165' \
#         '130417692568812201464869635755981098036565659656298666200424971763357929722125529856666205661673421402281231' \
#         '081314195657386622031883420872020648944100356967404181747102128516547222745333325254895270101528758227306599' \
#         '469624035680744082532188805477159214918031332724030275338869039822680407038083204014769230374655004234106376' \
#         '88454817997420944672193747192363987753459196311580461975618629750912028908140713295213305315022251918307904937'

offset = input[0, 7].to_i

new_input = ''
10_000.times do
  new_input += input
end
input = new_input
puts 'done'

phase = 1
while phase <= 100
  digit = 1
  new_number = ''
  input = input.split('').map(&:to_i)
  while digit <= input.length
    pattern = generate_pattern(digit, input.length)
    sum = 0
    i = 0
    while i < input.length
      sum += input[i] * pattern[i]
      i += 1
    end

    new_number += (sum.abs % 10).to_s
    digit += 1
  end
  input = new_number
  puts "After phase #{phase}: #{new_number[0, 8]}"
  phase += 1
end

puts input[offset, 8]
# puts input
