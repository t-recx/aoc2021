#!/usr/bin/env ruby

lines = File.readlines(ARGV[0]).map(&:strip)
  .map { |line| line.split(' -> ').map { |point| point.split(',').map(&:to_i) } }

board = {}

points_touching = 0

lines.each do |a, b|
  x, y = a
  xb, yb = b

  xi = x == xb ? 0 : (x > xb ? - 1 : 1)
  yi = y == yb ? 0 : (y > yb ? - 1 : 1)

  break_next = false

  loop do
    board[y] = {} unless board[y]
    board[y][x] = (board[y][x] || 0) + 1

    points_touching += 1 if board[y][x] == 2

    x += xi
    y += yi

    break if break_next

    break_next = true if x == xb && y == yb
  end
end

p points_touching
