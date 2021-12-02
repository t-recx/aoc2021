#!/usr/bin/env ruby

x, y, aim = 0, 0, 0

File.readlines(ARGV[0])
  .map(&:split)
  .map { |i, n| [i[0], n.to_i] }
  .each do |i, n|
  if i == 'f'
    x += n
    y += n * aim
  else
    aim += i == 'u' ? -n : n
  end
end

p(x * y)
