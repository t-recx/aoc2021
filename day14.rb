#!/usr/bin/env ruby

def process template, rules, steps
  h = Hash.new(0)

  template.each_cons(2) do |a, b|
    h[a + b] += 1
  end

  steps.times do |step|

    nh = Hash.new(0)

    h.each do |key, value|
      if rules[key] 
        nh[key[0] + rules[key]] += h[key]
        nh[rules[key] + key[1]] += h[key]

      end
    end
    
    h = nh
  end

  counts = Hash.new(0)

  h.map { |k, v| [k[0], v] }.each { |k, v| counts[k] += v }

  counts[template.last] += 1

  return counts.values.max - counts.values.min
end

input = File.readlines(ARGV[0]).map(&:strip)

template = input.first.chars

rules = input.drop(2).map { |line| line.split(' -> ') }.each_with_object({}) { |rule, hash| hash[rule[0]] = rule[1] }

p process(template, rules, 10)
p process(template, rules, 40)
