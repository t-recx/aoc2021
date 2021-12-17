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

  def to_s
    "#{x}, #{y}, #{cost}, #{g}, #{h}, #{f}"
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

def get_path(positions, origin, destination)
  current = nil
  open = [origin]

  origin.g = 0

  loop do
    break if open.empty?

    current = open.min_by { |p| p.f }

    break if current.x == destination.x && current.y == destination.y

    open.delete(current)

    neighbors = positions.select { |p| (p.x - current.x).abs + (p.y - current.y).abs == 1 }

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

locations = []
board = {}

input.each_with_index do |line, y|
  board[y] = {}

  line.map(&:to_i).each_with_index do |c, x|
    board[y][x] = c

    locations.push Position.new(x, y, c)
  end
end

#get_path(locations, locations.first, locations.last).map { |x| puts x }
p get_path(locations, locations.first, locations.last).map { |x| x.cost }.sum - locations.first.cost
