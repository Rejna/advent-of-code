# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 22
# https://adventofcode.com/2019/day/22
# Answer is: 2322

def cut(n)
  left = if n.positive?
           @deck[0, n]
         else
           @deck[0, deck_size + n]
         end

  right = @deck[n..]
  @deck = right + left
end

def deal_into_new_stack
  @deck = @deck.reverse
end

def deal_with_increment(n)
  new_deck = Array.new(@deck_size, 0)
  i = 0
  j = 0
  @deck_size.times do
    new_deck[i] = @deck[j]
    i = (i + n) % @deck_size
    j += 1
  end
  @deck = new_deck
end

# input = ['deal with increment 7', 'deal into new stack', 'deal into new stack']
# input = ['cut 6', 'deal with increment 7', 'deal into new stack']
# input = ['deal with increment 7', 'deal with increment 9', 'cut -2']
# input = ['deal into new stack', 'cut -2', 'deal with increment 7', 'cut 8', 'cut -4', 'deal with increment 7',
#          'cut 3', 'deal with increment 9', 'deal with increment 3', 'cut -1']
# @deck_size = 10
input = ['cut 7167', 'deal with increment 59', 'cut 4836', 'deal into new stack', 'deal with increment 9', 'cut -4087',
         'deal with increment 68', 'cut 227', 'deal with increment 71', 'cut -8524', 'deal into new stack',
         'deal with increment 17', 'cut 441', 'deal with increment 30', 'cut -6438', 'deal with increment 24',
         'deal into new stack', 'deal with increment 72', 'deal into new stack', 'deal with increment 51', 'cut 2636',
         'deal with increment 59', 'deal into new stack', 'cut 5477', 'deal into new stack', 'cut -7129',
         'deal with increment 54', 'cut -9355', 'deal with increment 64', 'cut 6771', 'deal with increment 71',
         'cut 1585', 'deal with increment 61', 'cut 7973', 'deal with increment 62', 'cut 5741',
         'deal with increment 42', 'cut 6630', 'deal with increment 12', 'cut 2023', 'deal with increment 68',
         'cut -3696', 'deal with increment 5', 'cut 312', 'deal with increment 40', 'deal into new stack',
         'deal with increment 4', 'deal into new stack', 'deal with increment 50', 'cut -1789',
         'deal with increment 58', 'cut -902', 'deal with increment 71', 'cut -6724', 'deal with increment 43',
         'deal into new stack', 'deal with increment 30', 'cut -5158', 'deal with increment 3', 'deal into new stack',
         'cut -1662', 'deal into new stack', 'cut -8906', 'deal into new stack', 'deal with increment 35', 'cut -562',
         'deal into new stack', 'cut 5473', 'deal with increment 53', 'cut 618', 'deal with increment 21',
         'cut -9703', 'deal into new stack', 'deal with increment 62', 'cut 3906', 'deal with increment 8', 'cut -978',
         'deal with increment 4', 'cut 139', 'deal with increment 2', 'cut 4352', 'deal with increment 66', 'cut 255',
         'deal into new stack', 'deal with increment 18', 'deal into new stack', 'deal with increment 33', 'cut 9829',
         'deal into new stack', 'deal with increment 7', 'cut -512', 'deal with increment 33', 'cut 3188',
         'deal with increment 46', 'cut -6352', 'deal into new stack', 'cut -1271', 'deal with increment 9',
         'cut -4747', 'deal with increment 6']
@deck_size = 10_007
@deck = []
i = 0
while i < @deck_size
  @deck << i
  i += 1
end

input.each do |shuffle|
  if shuffle == 'deal into new stack'
    deal_into_new_stack
  else
    a = shuffle.split(' ')
    if a[0] == 'cut'
      cut(a[1].to_i)
    else
      deal_with_increment(a[3].to_i)
    end
  end
end

puts @deck.index(2019)
