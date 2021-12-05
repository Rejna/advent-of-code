# frozen_string_literal: true

# Solution to Advent of Code 2019 Day 12 Part 2
# https://adventofcode.com/2019/day/12
# Answer is: 326365108375488

class Moon
  attr_accessor :x, :y, :z, :vel_x, :vel_y, :vel_z

  # rubocop:disable Metrics/ParameterLists
  def initialize(x, y, z, vel_x = 0, vel_y = 0, vel_z = 0)
    @x = x
    @y = y
    @z = z
    @vel_x = vel_x
    @vel_y = vel_y
    @vel_z = vel_z
  end
  # rubocop:enable Metrics/ParameterLists

  def calculate_x_gravity_change(other_moon)
    delta_this = 0
    delta_other = 0

    return [0, 0] unless @x != other_moon.x

    if @x < other_moon.x
      delta_this += 1
      delta_other -= 1
    else
      delta_this -= 1
      delta_other += 1
    end

    [delta_this, delta_other]
  end

  def calculate_y_gravity_change(other_moon)
    delta_this = 0
    delta_other = 0

    return [0, 0] unless @y != other_moon.y

    if @y < other_moon.y
      delta_this += 1
      delta_other -= 1
    else
      delta_this -= 1
      delta_other += 1
    end

    [delta_this, delta_other]
  end

  def calculate_z_gravity_change(other_moon)
    delta_this = 0
    delta_other = 0

    return [0, 0] unless @z != other_moon.z

    if @z < other_moon.z
      delta_this += 1
      delta_other -= 1
    else
      delta_this -= 1
      delta_other += 1
    end

    [delta_this, delta_other]
  end

  def apply_x_gravity_and_move(delta)
    @vel_x += delta
    move_x
  end

  def apply_y_gravity_and_move(delta)
    @vel_y += delta
    move_y
  end

  def apply_z_gravity_and_move(delta)
    @vel_z += delta
    move_z
  end

  def move_x
    @x += @vel_x
  end

  def move_y
    @y += @vel_y
  end

  def move_z
    @z += @vel_z
  end

  def to_s
    "pos=<x=#{@x}, y=#{@y}, z=#{@z}>, vel=<x=#{@vel_x}, y=#{@vel_y}, z=#{@vel_z}>"
  end

  def eq_x(other)
    @x == other.x && @vel_x == other.vel_x
  end

  def eq_y(other)
    @y == other.y && @vel_y == other.vel_y
  end

  def eq_z(other)
    @z == other.z && @vel_z == other.vel_z
  end

  def clone
    Moon.new(@x, @y, @z, @vel_x, @vel_y, @vel_z)
  end
end

# io = Moon.new(-1, 0, 2)
# europa = Moon.new(2, -10, -7)
# callisto = Moon.new(4, -8, 8)
# ganymede = Moon.new(3, 5, -1)

# io = Moon.new(-8, -10, 0)
# europa = Moon.new(5, 5, 10)
# callisto = Moon.new(2, -7, 3)
# ganymede = Moon.new(9, -8, -3)

io = Moon.new(4, 1, 1)
europa = Moon.new(11, -18, -1)
callisto = Moon.new(-2, -10, -4)
ganymede = Moon.new(-7, -2, 14)

prev_io = io.clone
prev_europa = europa.clone
prev_callisto = callisto.clone
prev_ganymede = ganymede.clone

# puts 'After 0 steps:'
# puts io
# puts europa
# puts callisto
# puts ganymede
# puts

steps = 0
loop do
  delta_io = 0
  delta_europa = 0
  delta_ganymede = 0
  delta_callisto = 0

  d1, d2 = io.calculate_x_gravity_change(europa)
  delta_io += d1
  delta_europa += d2

  d1, d2 = europa.calculate_x_gravity_change(callisto)
  delta_europa += d1
  delta_callisto += d2

  d1, d2 = io.calculate_x_gravity_change(callisto)
  delta_io += d1
  delta_callisto += d2

  d1, d2 = io.calculate_x_gravity_change(ganymede)
  delta_io += d1
  delta_ganymede += d2

  d1, d2 = callisto.calculate_x_gravity_change(ganymede)
  delta_callisto += d1
  delta_ganymede += d2

  d1, d2 = europa.calculate_x_gravity_change(ganymede)
  delta_europa += d1
  delta_ganymede += d2

  io.apply_x_gravity_and_move(delta_io)
  europa.apply_x_gravity_and_move(delta_europa)
  ganymede.apply_x_gravity_and_move(delta_ganymede)
  callisto.apply_x_gravity_and_move(delta_callisto)

  steps += 1

  # next unless (steps % 100).zero?

  # puts "After #{steps} steps:"
  # puts io
  # puts europa
  # puts callisto
  # puts ganymede
  # puts

  break if prev_callisto.eq_x(callisto) && prev_europa.eq_x(europa) && prev_io.eq_x(io) && prev_ganymede.eq_x(ganymede)
end
steps_x = steps

steps = 0
loop do
  delta_io = 0
  delta_europa = 0
  delta_ganymede = 0
  delta_callisto = 0

  d1, d2 = io.calculate_y_gravity_change(europa)
  delta_io += d1
  delta_europa += d2

  d1, d2 = europa.calculate_y_gravity_change(callisto)
  delta_europa += d1
  delta_callisto += d2

  d1, d2 = io.calculate_y_gravity_change(callisto)
  delta_io += d1
  delta_callisto += d2

  d1, d2 = io.calculate_y_gravity_change(ganymede)
  delta_io += d1
  delta_ganymede += d2

  d1, d2 = callisto.calculate_y_gravity_change(ganymede)
  delta_callisto += d1
  delta_ganymede += d2

  d1, d2 = europa.calculate_y_gravity_change(ganymede)
  delta_europa += d1
  delta_ganymede += d2

  io.apply_y_gravity_and_move(delta_io)
  europa.apply_y_gravity_and_move(delta_europa)
  ganymede.apply_y_gravity_and_move(delta_ganymede)
  callisto.apply_y_gravity_and_move(delta_callisto)

  steps += 1

  # neyt unless (steps % 100).zero?

  # puts "After #{steps} steps:"
  # puts io
  # puts europa
  # puts callisto
  # puts ganymede
  # puts

  break if prev_callisto.eq_y(callisto) && prev_europa.eq_y(europa) && prev_io.eq_y(io) && prev_ganymede.eq_y(ganymede)
end
steps_y = steps

steps = 0
loop do
  delta_io = 0
  delta_europa = 0
  delta_ganymede = 0
  delta_callisto = 0

  d1, d2 = io.calculate_z_gravity_change(europa)
  delta_io += d1
  delta_europa += d2

  d1, d2 = europa.calculate_z_gravity_change(callisto)
  delta_europa += d1
  delta_callisto += d2

  d1, d2 = io.calculate_z_gravity_change(callisto)
  delta_io += d1
  delta_callisto += d2

  d1, d2 = io.calculate_z_gravity_change(ganymede)
  delta_io += d1
  delta_ganymede += d2

  d1, d2 = callisto.calculate_z_gravity_change(ganymede)
  delta_callisto += d1
  delta_ganymede += d2

  d1, d2 = europa.calculate_z_gravity_change(ganymede)
  delta_europa += d1
  delta_ganymede += d2

  io.apply_z_gravity_and_move(delta_io)
  europa.apply_z_gravity_and_move(delta_europa)
  ganymede.apply_z_gravity_and_move(delta_ganymede)
  callisto.apply_z_gravity_and_move(delta_callisto)

  steps += 1

  # nezt unless (steps % 100).zero?

  # puts "After #{steps} steps:"
  # puts io
  # puts europa
  # puts callisto
  # puts ganymede
  # puts

  break if prev_callisto.eq_z(callisto) && prev_europa.eq_z(europa) && prev_io.eq_z(io) && prev_ganymede.eq_z(ganymede)
end
steps_z = steps

puts "#{steps_x} #{steps_y} #{steps_z} #{steps_x * steps_y * steps_z} #{steps_x.lcm(steps_y).lcm(steps_z)}"
