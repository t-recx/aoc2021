#!/usr/bin/env ruby

def increase(board, x, y, flashed)
  if board[y] && board[y][x]
    board[y][x] += 1

    return flash(board, x, y, flashed) if board[y][x] > 9
  end

  return 0
end

def flash(board, x, y, flashed)
  flashed[y] = {} unless flashed[y]

  return 0 if flashed[y][x]

  flashed[y][x] = true

  flashes = 1

  [[-1, -1], [-1, 0], [1, 0], [0, -1], [0, 1], [1, 1], [-1, 1], [1, -1]].each do |ix, iy|
    flashes += increase(board, x+ix, y+iy, flashed) 
  end

  return flashes
end

def step board
  flashed = {}
  flashes = 0

  10.times do |y|
    10.times do |x|
      flashes += increase(board, x, y, flashed)
    end
  end

  flashed.flat_map { |k, v| v.keys.map { |kk, _| [k, kk] } }.each do |y, x|
    board[y][x] = 0
  end

  return flashes
end

def get_board input
  board = {}
  
  10.times do |y|
    board[y] = {}
  
    10.times do |x|
      board[y][x] = input[y][x]
    end
  end

  return board
end

input = File.readlines(ARGV[0]).map(&:strip).map(&:chars).map { |c| c.map(&:to_i) }

flashes = 0

board = get_board input

100.times do 
  flashes += step(board)
end

p flashes

board = get_board input
i = 0

loop do
  i += 1

  break if step(board) == 100
end

p i
