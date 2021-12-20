# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 18 Part 1
# https://adventofcode.com/2021/day/18
# Answer is: ???

class Node
  attr_accessor :left, :right, :parent, :value

  def initialize(v, l, r, p)
    @left = l
    @right = r
    @parent = p
    @value = v
  end

  def print(level)
    if @value.nil?
      @left.print(level + 1) unless @left.nil?
      # puts "level #{level} | left: nil" if @left.nil?
      @right.print(level + 1) unless @right.nil?
      # puts "level #{level} | right: nil" unless @right.nil?
    else
      # puts "level: #{level} | value: #{@value}"
    end
    puts
  end
end

@explosion_processed = []
@boom = false
@split = false

def process_array(arr, root)
  node = Node.new(nil, nil, nil, root)

  if arr[0].is_a?(Array)
    puts "left is an array #{arr[0]}" if @process_debug
    node.left = process_array(arr[0], node)
  else
    puts "left is a leaf with value #{arr[0]}" if @process_debug
    node.left = Node.new(arr[0].to_i, nil, nil, node)
  end

  if arr[1].is_a?(Array)
    puts "right is an array #{arr[1]}" if @process_debug
    node.right = process_array(arr[1], node)
  else
    puts "right is a leaf with value #{arr[1]}" if @process_debug
    node.right = Node.new(arr[1].to_i, nil, nil, node)
  end

  node
end

def explode(root, depth = 0)
  puts "depth #{depth}" if @explode_debug
  if depth >= 4
    if !root.left.nil? && !root.left.value.nil? && !root.right.nil? && !root.right.value.nil?
      puts 'boom' if @explode_debug
      @boom = true
      left_val = root.left.value
      right_val = root.right.value
      right_val_found = false
      left_val_found = false
      going_down = true
      going_left = false
      going_right = false
      puts "left val #{left_val} | right val #{right_val}" if @explode_debug

      # moving right value to the leftest node on the right
      node = root
      prev_node = root
      loop do
        if node.nil? || (going_right && node.right.nil?) || (going_left && node.left.nil?) || (going_down && node.parent.nil?)
          break
        end

        if going_down
          puts 'parent' if @explode_debug
          node = node.parent
        elsif going_right
          puts 'right' if @explode_debug
          node = node.right
        elsif going_left
          puts 'left' if @explode_debug
          node = node.left
        end

        if going_down && !node.right.nil?
          if node.right == prev_node
            puts 'no coming back 1' if @explode_debug
            prev_node = node
            next
          elsif !node.right.value.nil?
            puts "adding right value of #{right_val} to right value of #{node.right.value}" if @explode_debug
            node.right.value += right_val

            if node.right.value > 9
              node.right.left = Node.new((node.right.value.to_f / 2).floor, nil, nil, node.right)
              node.right.right = Node.new((node.right.value.to_f / 2).ceil, nil, nil, node.right)
              node.right.value = nil
              @split = true
              puts 'split' if @split_debug
            end

            right_val_found = true
            break
          else
            going_down = false
            going_right = true
            going_left = false
          end
        elsif going_right && !node.left.nil?
          if node.left == prev_node
            puts 'no coming back 2' if @explode_debug
            prev_node = node
            next
          elsif !node.left.value.nil?
            puts "adding right value of #{right_val} to left value of #{node.left.value}" if @explode_debug
            node.left.value += right_val

            if node.left.value > 9
              node.left.left = Node.new((node.left.value.to_f / 2).floor, nil, nil, node.left)
              node.left.right = Node.new((node.left.value.to_f / 2).ceil, nil, nil, node.left)
              node.left.value = nil
              @split = true
              puts 'split' if @split_debug
            end

            right_val_found = true
            break
          else
            going_down = false
            going_right = false
            going_left = true
          end
        elsif going_left && !node.left.nil?
          if node.left == prev_node
            puts 'no coming back 3' if @explode_debug
            prev_node = node
            next
          elsif !node.left.value.nil?
            puts "adding right value of #{right_val} to left value of #{node.left.value}" if @explode_debug
            node.left.value += right_val

            if node.left.value > 9
              node.left.left = Node.new((node.left.value.to_f / 2).floor, nil, nil, node.left)
              node.left.right = Node.new((node.left.value.to_f / 2).ceil, nil, nil, node.left)
              node.left.value = nil
              @split = true
              puts 'split' if @split_debug
            end

            right_val_found = true
            break
          else
            going_down = false
            going_right = false
            going_left = true
          end
        else
          next
        end
      end
      unless right_val_found
        puts 'no right val found' if @explode_debug
      end

      node = root
      going_down = true
      going_left = false
      going_right = false
      prev_node = root
      loop do
        if node.nil? || (going_right && node.right.nil?) || (going_left && node.left.nil?) || (going_down && node.parent.nil?)
          break
        end

        if going_down
          puts 'parent' if @explode_debug
          node = node.parent
        elsif going_right
          puts 'right' if @explode_debug
          node = node.right
        elsif going_left
          puts 'left' if @explode_debug
          node = node.left
        end

        if going_down && !node.left.nil?
          if node.left == prev_node
            prev_node = node
            puts 'no coming back 1' if @explode_debug
            next
          elsif !node.left.value.nil?
            puts "adding left value of #{left_val} to left value of #{node.left.value}" if @explode_debug
            node.left.value += left_val

            if node.left.value > 9
              node.left.left = Node.new((node.left.value.to_f / 2).floor, nil, nil, node.left)
              node.left.right = Node.new((node.left.value.to_f / 2).ceil, nil, nil, node.left)
              node.left.value = nil
              @split = true
              puts 'split' if @split_debug
            end

            left_val_found = true
            break
          else
            puts 'switch to move left' if @explode_debug
            going_down = false
            going_right = false
            going_left = true
          end
        elsif going_left && !node.right.nil?
          if node.right == prev_node
            prev_node = node
            puts 'no coming back 2' if @explode_debug
            next
          elsif !node.right.value.nil?
            puts "adding left value of #{left_val} to right value of #{node.right.value}" if @explode_debug
            node.right.value += left_val

            if node.right.value > 9
              node.right.left = Node.new((node.right.value.to_f / 2).floor, nil, nil, node.right)
              node.right.right = Node.new((node.right.value.to_f / 2).ceil, nil, nil, node.right)
              node.right.value = nil
              @split = true
              puts 'split' if @split_debug
            end

            left_val_found = true
            break
          else
            puts 'switch to move right' if @explode_debug
            going_down = false
            going_right = true
            going_left = false
          end
        elsif going_right && !node.right.nil?
          if node.right == prev_node
            prev_node = node
            puts 'no coming back 3' if @explode_debug
            next
          elsif !node.right.value.nil?
            puts "adding right value of #{left_val} to right value of #{node.right.value}" if @explode_debug
            node.right.value += left_val

            if node.right.value > 9
              node.right.left = Node.new((node.right.value.to_f / 2).floor, nil, nil, node.right)
              node.right.right = Node.new((node.right.value.to_f / 2).ceil, nil, nil, node.right)
              node.right.value = nil
              puts 'split' if @split_debug
              @split = true
            end

            left_val_found = true
            break
          else
            puts 'keep going right' if @explode_debug
            going_down = false
            going_right = true
            going_left = false
          end
        else
          puts 'next' if @explode_debug
          next
        end
      end
      unless left_val_found
        puts 'no left val found' if @explode_debug
      end
    end
    if !@explosion_processed.include?(root) && (left_val_found || right_val_found)
      @explosion_processed << root
      puts 'reset root values' if @explode_debug
      root.left = nil
      root.right = nil
      root.value = 0
    end
    return
  end

  unless root.left.nil?
    puts "going left to depth #{depth + 1}" if @explode_debug
    explode(root.left, depth + 1)
  end
  unless root.right.nil?
    puts "going right to depth #{depth + 1}" if @explode_debug
    explode(root.right, depth + 1)
  end
  # return if root.left.nil? && root.right.nil?
  puts 'no boom' if @explode_debug
end

# def split(root)
#   cur = root
#   if !cur.left.nil?
#     if !cur.left.value.nil? && cur.left.value > 9
#       cur.left.left = Node.new((cur.left.value.to_f / 2).floor, nil, nil, cur.left)
#       cur.left.right = Node.new((cur.left.value.to_f / 2).ceil, nil, nil, cur.left)
#       cur.left.value = nil
#       @split = true
#       puts 'split' if @split_debug
#     else
#       split(cur.left)
#     end
#   end

#   if !cur.right.nil?
#     if !cur.right.value.nil? && cur.right.value > 9
#       cur.right.left = Node.new((cur.right.value.to_f / 2).floor, nil, nil, cur.right)
#       cur.right.right = Node.new((cur.right.value.to_f / 2).ceil, nil, nil, cur.right)
#       cur.right.value = nil
#       @split = true
#       puts 'split' if @split_debug
#     else
#       split(cur.right)
#     end
#   end
# end

def magnitude(root)
  return root.value if root.left.nil? && root.right.nil?

  return 3 * magnitude(root.left) + 2 *  magnitude(root.right) if !root.left.nil? && !root.right.nil?
end

# input = File.readlines('../1 Input/day18.input').map(&:strip)
input = File.readlines('1 Input/day18test.input').map(&:strip)

# explode tests
# input = [[[[[[9, 8], 1], 2], 3], 4],
#          [7, [6, [5, [4, [3, 2]]]]],
#          [[6, [5, [4, [3, 2]]]], 1],
#          [[3, [2, [1, [7, 3]]]], [6, [5, [4, [3, 2]]]]],
#          [[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]]]

# split test
# input = [[[[[0, 7], 4], [15, [0, 13]]], [1, 1]]]

# explode/split test
# input = [[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]]

# magnitude tests
# input = [[[1, 2], [[3, 4], 5]], [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]], [[[[1, 1], [2, 2]], [3, 3]], [4, 4]],
#          [[[[3, 0], [5, 3]], [4, 4]], [5, 5]],  [[[[5, 0], [7, 4]], [5, 5]], [6, 6]],
#          [[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]]]
# input.each do |inp|
#   tree = process_array(inp, nil)
#   puts magnitude(tree)
# end

@split_debug = true
@explode_debug = true
@process_debug = true

i = 1
left = process_array(eval(input[0]), nil)
while i < 2
  right = process_array(eval(input[i]), nil)
  tree = Node.new(nil, nil, nil, nil)
  left.parent = tree
  right.parent = tree
  tree.left = left
  tree.right = right

  loop do
    explode(tree)
    # split(tree)

    break if !@boom && !@split

    @boom = false
    @split = false
  end

  puts 'reduction done'
  pp tree
  left = tree
  i += 1
end

# pp tree
