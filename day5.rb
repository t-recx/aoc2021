#!/usr/bin/env ruby

def get_points_touching(lines, ignore_diagonals)
  board = {}

  points_touching = 0

  lines.each do |a, b|
    x, y = a
    xb, yb = b

    next if ignore_diagonals && !(x == xb || y == yb)

    xi = x == xb ? 0 : (x > xb ? - 1 : 1)
    yi = y == yb ? 0 : (y > yb ? - 1 : 1)

    loop do
      board[y] = {} unless board[y]
      board[y][x] = (board[y][x] || 0) + 1

      points_touching += 1 if board[y][x] == 2

      x += xi
      y += yi

      break if x == xb + xi && y == yb + yi
    end
  end

  points_touching
end

lines = File.readlines(ARGV[0])
  .map { |line| line.split(' -> ').map { |point| point.split(',').map(&:to_i) } }

# part1
p get_points_touching(lines, true)

# part2
p get_points_touching(lines, false)
