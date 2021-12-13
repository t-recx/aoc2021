#!/usr/bin/env ruby

input = File.read(ARGV[0]).split('fold along ')

coordinates = input.first.split("\n").map { |x| x.split(',')}.map { |x| x.map(&:to_i) }

folds = input.drop(1).map(&:strip).map { |x| x.split('=') }.map { |a, b| [a, b.to_i] }

grid = Array.new(coordinates.map { |n| n[1] }.max + 1) { Array.new(coordinates.map { |n| n[0] }.max + 1, ' ') }

coordinates.each do |x, y|
  grid[y][x] = '#'
end

i = 0

folds.each do |axis, value|
  grid = grid.transpose if (axis == 'x')

  new_grid = grid[0..value-1]

  grid[value+1..].reverse.each_with_index { |line, y| line.each_with_index { |c, x| new_grid[y][x] = c if c == '#' } }

  grid = new_grid

  grid = grid.transpose if (axis == 'x')

  p grid.flatten.count { |x| x == '#' } if i == 0

  i += 1
end

grid.each do |line|
  line.map { |c| print(c) }

  puts
end
