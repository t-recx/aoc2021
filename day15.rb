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

def get_path(board, positions, origin, destination)
  current = nil
  open = [origin]

  origin.g = 0

  loop do
    break if open.empty?

    current = open.min_by { |p| p.f }

    break if current.x == destination.x && current.y == destination.y

    open.delete(current)

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

        open.push(neighbor) unless open.include? neighbor
      end
    end
  end

  return get_path_from(current)
end

input = File.readlines(ARGV[0]).map(&:strip).map(&:chars)

def part_a input
  locations = []
  board = {}
  
  input.each_with_index do |line, y|
    board[y] = {}
  
    line.map(&:to_i).each_with_index do |c, x|
      board[y][x] = Position.new(x, y, c)
  
      locations.push board[y][x]
    end
  end

  p get_path(board, locations, locations.first, locations.last).map { |x| x.cost }.sum - locations.first.cost
end

def part_b input
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

          locations.push board[py][px]
        end
      end
    end
  end

  p get_path(board, locations, locations.first, locations.last).map { |x| x.cost }.sum - locations.first.cost
end

part_a(input)
part_b(input)
