def solve_input(to_solve: [], with_logging: true, with_part_2: false)
  value = 50
  solution = 0
  to_solve.each do |i|
    number = Integer(i[1..-1])
    if with_part_2
      rotations = number / 100
      solution += rotations.abs
    end

    prev_value = value
    if i[0] == "L"
      value = (value - number) % 100
      if prev_value < value && (value != 0 && prev_value != 0) && with_part_2
        solution += 1
      end
    elsif i[0] == "R"
      value = (value + number) % 100
      if prev_value > value && (value != 0 && prev_value != 0) && with_part_2
        solution += 1
      end
    end
    solution += 1 if value == 0
  end
  solution
end

# Sample input solver

input = [
  "L68",
  "L30",
  "R48",
  "L5",
  "R60",
  "L55",
  "L1",
  "L99",
  "R14",
  "L82"
]

solution = solve_input(to_solve: input, with_part_2: true)
puts "EASY: #{solution}"

# Day 1 input - part 1

input = File.read("../input-puzzle-1.txt")
input = input.split("\n")

solution = solve_input(to_solve: input, with_logging: false)
puts "MEDIUM: #{solution}"

# Day 1 input - part 2

input = File.read("../input-puzzle-1.txt")
input = input.split("\n")

solution = solve_input(to_solve: input, with_logging: false, with_part_2: true)
puts "HARD: #{solution}"
