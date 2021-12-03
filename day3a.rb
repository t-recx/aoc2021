#!/usr/bin/env ruby

def get_value(a, descending)
  (0..a.first.length).map { |i|
    a.map { |x| x.chars[i] }
     .each_with_object(Hash.new(0)) { |val, hash| hash[val] += 1 }
     .min_by { |x| x[1] * (descending ? -1 : 1) }[0]
  }
  .join
  .to_i(2)
end

input = File.readlines(ARGV[0]).map(&:strip)

p [true, false].map { |descending| get_value(input, descending) }.reduce(:*)
