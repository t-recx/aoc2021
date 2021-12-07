#!/usr/bin/env ruby

positions = File.read(ARGV[0]).split(',').each_with_object(Hash.new(0)) { |x, h| h[x.to_i] += 1 }

positions_range = (positions.keys.min..positions.keys.max)

p positions_range.flat_map { |ix| positions.map { |x, t| (x - ix).abs * t }.sum }.min

p positions_range.flat_map { |ix| positions.map { |x, t| (0..(x - ix).abs).sum * t }.sum }.min
