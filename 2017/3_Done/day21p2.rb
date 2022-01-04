# frozen_string_literal: true

# Solution to Advent of Code 2017 Day 21 Part 2
# https://adventofcode.com/2017/day/21#part2
# Answer is: 3389823 in 1m9s

def rotate(box, deg)
  new_box = ''
  if box.length == 11
    case deg
    when 90
      new_box = "#{box[8]}#{box[4]}#{box[0]}/#{box[9]}#{box[5]}#{box[1]}/#{box[10]}#{box[6]}#{box[2]}"
    when 180
      new_box = "#{box[10]}#{box[9]}#{box[8]}/#{box[6]}#{box[5]}#{box[4]}/#{box[2]}#{box[1]}#{box[0]}"
    when 270
      new_box = "#{box[2]}#{box[6]}#{box[10]}/#{box[1]}#{box[5]}#{box[9]}/#{box[0]}#{box[4]}#{box[8]}"
    end
  else
    case deg
    when 90
      new_box = "#{box[3]}#{box[0]}/#{box[4]}#{box[1]}"
    when 180
      new_box = "#{box[4]}#{box[3]}/#{box[1]}#{box[0]}"
    when 270
      new_box = "#{box[1]}#{box[4]}/#{box[0]}#{box[3]}"
    end
  end
  new_box
end

def flip(box, type)
  new_box = ''
  if box.length == 11
    case type
    when 'h'
      new_box = "#{box[8]}#{box[9]}#{box[10]}/#{box[4]}#{box[5]}#{box[6]}/#{box[0]}#{box[1]}#{box[2]}"
    when 'v'
      new_box = "#{box[2]}#{box[1]}#{box[0]}/#{box[6]}#{box[5]}#{box[4]}/#{box[10]}#{box[9]}#{box[8]}"
    when 'd1'
      new_box = "#{box[10]}#{box[6]}#{box[2]}/#{box[9]}#{box[5]}#{box[1]}/#{box[8]}#{box[4]}#{box[0]}"
    when 'd2'
      new_box = "#{box[0]}#{box[4]}#{box[8]}/#{box[1]}#{box[5]}#{box[9]}/#{box[2]}#{box[6]}#{box[10]}"
    end
  else
    case type
    when 'h'
      new_box = "#{box[3]}#{box[4]}/#{box[0]}#{box[1]}"
    when 'v'
      new_box = "#{box[1]}#{box[0]}/#{box[4]}#{box[3]}"
    when 'd1'
      new_box = "#{box[4]}#{box[1]}/#{box[3]}#{box[0]}"
    when 'd2'
      new_box = "#{box[0]}#{box[3]}/#{box[1]}#{box[4]}"
    end
  end
  new_box
end

def string_to_2d_array(str)
  result = []
  sp = str.split('/')
  sp.each do |row|
    result << row.chars
  end
  result
end

def merge_boxes(boxes)
  if boxes.length == 1
    boxes[0]
  else
    rows_to_take = if (boxes[0].length % 4).zero? # 4x4 boxes
                     4
                   else # 3x3 boxes
                     3
                   end
    result = []
    boxes_in_row = Math.sqrt(boxes.length).to_i
    start = 0

    while start < boxes.length
      boxes_to_merge = boxes.drop(start).take(boxes_in_row)

      i = 0
      while i < rows_to_take
        row = []
        boxes_to_merge.each do |b|
          row += b[i]
        end
        result << row
        i += 1
      end

      start += boxes_in_row
    end
    result
  end
end

input = File.readlines('../1_Input/day21.input').map(&:strip)
steps = 18

rules = {}

input.each do |inp|
  sp = inp.split(' => ')
  rules[sp[0]] = sp[1]
end

image = [
  ['.', '#', '.'],
  ['.', '.', '#'],
  ['#', '#', '#']
]

steps.times.each do |k|
  boxes = []
  i = 0
  if (image.length % 2).zero?
    while i < image.length
      j = 0
      while j < image.length
        box = ''
        box += image[i][j, 2].join('')
        box += '/'
        box += image[i + 1][j, 2].join('')
        boxes << box
        j += 2
      end
      i += 2
    end
  else
    while i < image.length
      j = 0
      while j < image.length
        box = ''
        box += image[i][j, 3].join('')
        box += '/'
        box += image[i + 1][j, 3].join('')
        box += '/'
        box += image[i + 2][j, 3].join('')
        boxes << box
        j += 3
      end
      i += 3
    end
  end

  puts "#{k + 1} new boxes #{boxes.length} START"
  new_boxes = []
  boxes.each do |b|
    new_box = [rules[b], rules[rotate(b.chars, 90)], rules[rotate(b.chars, 180)],
               rules[rotate(b.chars, 270)], rules[flip(b.chars, 'h')], rules[flip(b.chars, 'v')],
               rules[flip(b.chars, 'd1')], rules[flip(b.chars, 'd2')]].reject(&:nil?)[0]
    new_boxes << string_to_2d_array(new_box)
  end

  puts "#{k + 1} merging START #{new_boxes.length}"
  image = merge_boxes(new_boxes)
  puts "#{k + 1} #{image.flatten.tally['#']}"
end
