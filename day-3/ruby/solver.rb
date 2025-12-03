def solve_input_part_1(to_solve: [])
  values = []
  to_solve.each do |value|
    max = 0
    min = 0
    (0..(value.length-1)).each do |v|
      number = Integer(value[v])
      if (number > max) && v != (value.length-1)
        max = number
        min = 0
      elsif number > min
        min = number
      end
    end
    values << max.to_s + min.to_s
  end
  values
end

def solve_input_part_2(to_solve: [])
  values = []
  k = 12

  to_solve.each do |value|
    n = value.length
    result = ""
    start = 0

    (0...k).each do |i|
      end_idx = n - k + i
      max_digit = '0'
      max_pos = start

      (start..end_idx).each do |j|
        if value[j] > max_digit
          max_digit = value[j]
          max_pos = j
        end
      end

      result += max_digit
      start = max_pos + 1
    end

    values << result
  end

  values
end

# Sample input solver

sample_input = [
  "987654321111111",
  "811111111111119",
  "234234234234278",
  "818181911112111"
]

# Part 1 sample (expected: 357)
solution = solve_input_part_1(to_solve: sample_input)
puts "Part 1 Sample: #{solution.map(&:to_i).sum} (expected: 357)"

# Part 2 sample (expected: 3121910778619)
solution = solve_input_part_2(to_solve: sample_input)
puts "Part 2 Sample: #{solution.map(&:to_i).sum} (expected: 3121910778619)"

# Day 3 input - part 1
input = File.read("../input-puzzle.txt")
solution = solve_input_part_1(to_solve: input.split("\n"))
puts "Part 1 Answer: #{solution.map(&:to_i).sum}"

# Day 3 input - part 2
input = File.read("../input-puzzle.txt")
solution = solve_input_part_2(to_solve: input.split("\n"))
puts "Part 2 Answer: #{solution.map(&:to_i).sum}"
