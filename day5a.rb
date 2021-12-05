#!/usr/bin/env ruby

board = {}

lines = File.readlines(ARGV[0])
  .map(&:strip)
  .map { |line| line.split(' -> ').map { |point| point.split(',').map(&:to_i) } }

points_touching = 0

lines.each do |a, b|
  xa = a[0]
  ya = a[1]
  xb = b[0]
  yb = b[1]

  next unless xa == xb || ya == yb

  if xa > xb
    xs = xb
    xe = xa
  else
    xs = xa
    xe = xb
  end

  if ya > yb
    ys = yb
    ye = ya
  else
    ys = ya
    ye = yb
  end

  (ys..ye).each do |y|
    (xs..xe).each do |x|
      board[y] = {} unless board[y]
      board[y][x] = (board[y][x] || 0) + 1

      points_touching += 1 if board[y][x] == 2
    end
  end
end

p points_touching
