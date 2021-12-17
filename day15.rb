#!/usr/bin/env ruby

class Position
  attr_accessor :x, :y
  attr_accessor :g, :h
  attr_accessor :cost
  attr_accessor :parent

  def initialize x, y, cost
    @x = x
    @y = y
    @cost = cost
    @g = 99999999
    @h = 0
  end

  def f
    @g + @h
  end
end

def get_path_from(position)
  path = []

  loop do
    path.push position

    break if position.parent.nil?

    position = position.parent
  end

  path.reverse
end

def get_path(board, origin, destination)
  current = nil
  open = [origin]
  open_board = {}
  open_board[origin.y] = { origin.x => origin}

  origin.g = 0

  loop do
    break if open.empty?

    current = open.min_by { |p| p.f }

    break if current.x == destination.x && current.y == destination.y

    open.delete(current)

    open_board[current.y].delete(current.x)

    neighbors = []

    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |ix, iy|
      if (board[current.y + iy] && board[current.y + iy][current.x + ix])
        neighbors.push board[current.y + iy][current.x + ix]
      end
    end

    neighbors.each do |neighbor|
      g = current.g + neighbor.cost

      if g < neighbor.g
        neighbor.g = g
        neighbor.h = (neighbor.x - destination.x).abs + (neighbor.y - destination.y).abs
        neighbor.parent = current

        unless open_board[neighbor.y] && open_board[neighbor.y][neighbor.x]
          open.push(neighbor)

          open_board[neighbor.y] = {} unless open_board[neighbor.y]
          open_board[neighbor.y][neighbor.x] = neighbor
        end
      end
    end
  end

  get_path_from(current)
end

input = File.readlines(ARGV[0]).map(&:strip).map(&:chars)

def get_input_a input
  locations = []
  board = {}
  
  input.each_with_index do |line, y|
    board[y] = {}
  
    line.map(&:to_i).each_with_index do |c, x|
      board[y][x] = Position.new(x, y, c)
    end
  end

  board
end

def get_input_b input
  locations = []
  board = {}
  cost_range = (1..9).to_a
  
  input.each_with_index do |line, y|
    (0..4).each do |i|
      py = y + i * input.length
      board[py] = {}
  
      line.map(&:to_i).each_with_index do |c, x|
        (0..4).each do |ii|
          px = x + ii * line.length
          cost = cost_range[(c + i + ii) % 9 - 1]
          board[py][px] = Position.new(px, py, cost)
        end
      end
    end
  end

  board
end

[get_input_a(input), get_input_b(input)]
  .map { |board| get_path(board, board[0][0], board[board.keys.max][board[0].keys.max]) }
  .map { |x| p x[1..].map { |y| y.cost }.sum }
