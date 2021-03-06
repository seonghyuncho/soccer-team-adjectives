# Sort teams by total adjective count.
# Unnecessary, but makes the output more readable: most popular teams are on top.

require 'json'

data = JSON.parse(ARGF.read)

data = data.sort_by do |_, adjectives|
  -adjectives
    .map { |a| a['count'] }
    .inject(0) { |sum, c| sum + c }
end

data = data.to_h

puts JSON.pretty_generate(data)
