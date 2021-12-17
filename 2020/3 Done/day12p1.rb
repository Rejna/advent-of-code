# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 12 Part 1
# https://adventofcode.com/2020/day/12
# Answer is: 1496

# input = %w[F10 N3 F7 R90 F11]
input = File.readlines('../1 Input/day12.input').map(&:strip)
@direction = 'E'
@x = 0
@y = 0

def rotate(dir, deg)
  if deg == 90
    if dir == 'R'
      case @direction
      when 'E'
        @direction = 'S'
      when 'S'
        @direction = 'W'
      when 'W'
        @direction = 'N'
      when 'N'
        @direction = 'E'
      end
    else
      case @direction
      when 'E'
        @direction = 'N'
      when 'S'
        @direction = 'E'
      when 'W'
        @direction = 'S'
      when 'N'
        @direction = 'W'
      end
    end
  elsif deg == 180
    case @direction
    when 'E'
      @direction = 'W'
    when 'S'
      @direction = 'N'
    when 'W'
      @direction = 'E'
    when 'N'
      @direction = 'S'
    end
  elsif dir == 'R' # 270
    case @direction
    when 'E'
      @direction = 'N'
    when 'S'
      @direction = 'E'
    when 'W'
      @direction = 'S'
    when 'N'
      @direction = 'W'
    end
  else
    case @direction
    when 'E'
      @direction = 'S'
    when 'S'
      @direction = 'W'
    when 'W'
      @direction = 'N'
    when 'N'
      @direction = 'E'
    end
  end
end

def move(dir, dist)
  case dir
  when 'N'
    @x += dist
  when 'E'
    @y += dist
  when 'W'
    @y -= dist
  when 'S'
    @x -= dist
  end
end

input.each do |command|
  c = command[0]
  param = command[1..].to_i
  case c
  when 'N', 'E', 'W', 'S'
    # puts "move #{c} #{param} units"
    move(c, param)
  when 'R', 'L'
    # puts "rotate #{c} #{param} degrees"
    rotate(c, param)
  when 'F'
    # puts "move #{@direction} #{param} units"
    move(@direction, param)
  end
  # puts "#{command} #{@y}#{@y >= 0 ? 'E' : 'W'} #{@x}#{@x >= 0 ? 'N' : 'S'} #{@direction}"
end

puts @x.abs + @y.abs
