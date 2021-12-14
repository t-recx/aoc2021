#!/usr/bin/env ruby

class Node
    attr_accessor :value
    attr_accessor :prev
    attr_accessor :nxt

    def initialize prev = nil, nxt = nil
      @prev = prev
      @nxt = nxt
    end

    def link value
      new_node = Node.new 
      new_node.value = value

      if @nxt
        new_node.nxt = @nxt
        @prev = new_node
      end

      @nxt = new_node
    end
end

def create_list template
  start = Node.new

  node = start
  
  template.each do |c|
    node.value = c
    nxt = Node.new node
    node.nxt = nxt
    node = nxt
  end

  node.nxt = nil

  start
end

def print_list node
  loop do 
    print node.value
    node = node.nxt  
    break if node.nil?
  end

  puts
end

def get_counts_by_value node
  counts = Hash.new(0)

  loop do 
    counts[node.value] += 1 
    node = node.nxt  
    break if node.nil? || node.value.nil?
  end

  counts
end

input = File.readlines(ARGV[0]).map(&:strip)

template = input.first.chars

rules = input.drop(2).map { |line| line.split(' -> ').map(&:chars).flatten}

start_a = create_list(template)

node = start_a

10.times do |step|
  loop do 
    rules.each do |a, b, r|
      if node.value == a && node.nxt && node.nxt.value == b
        node.link(r)
        node = node.nxt
        break
      end
    end

    node = node.nxt
    break if node == nil || node.nxt == nil
  end

  node = start_a
end

counts = get_counts_by_value(node).values

p counts.max - counts.min
