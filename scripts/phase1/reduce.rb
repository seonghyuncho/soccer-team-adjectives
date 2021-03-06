# Aggregate team/adjective counts across all comments.

require 'json'

total_counts = {}

File.open('./output/phase1/mapped.dat').each_line do |line|
  line_counts = JSON.parse(line)['team_adjectives']
  line_counts.keys.each do |team|
    total_counts[team] = {} unless total_counts.key?(team)
    line_counts[team].keys.each do |adjective|
      total_counts[team][adjective] = 0 unless total_counts[team].key?(adjective)
      total_counts[team][adjective] += 1
    end
  end
end

result = {}

# Sorting adjectives by count.
# Unnecessary but makes intermediate results more readable.
total_counts.keys.each do |team|
  result[team] = []
  total_counts[team].sort { |a, b| b[1] <=> a[1] }.each do |key, value|
    result[team] << { adjective: key, count: value }
  end
end

File.open('./output/phase1/reduced.json', 'w').puts JSON.pretty_generate(result)
