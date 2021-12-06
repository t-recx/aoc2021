#!/usr/bin/env ruby

input = File.read(ARGV[0]).split(',').each_with_object(Hash.new(0)) { |f, h| h[f.to_i] += 1 }

[80, 256].each do |n|
  fishes = input.clone

  n.times do
    fishes.transform_keys! { |k| k - 1 }

    fishes[8] = (fishes[8] || 0) + (fishes[-1] || 0)
    fishes[6] = (fishes[6] || 0) + (fishes.delete(-1) || 0)
  end

  p fishes.values.sum
end
