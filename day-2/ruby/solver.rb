def solve_input_part_1(to_solve: "")
  ranges = to_solve.split(",")
  numbers_to_add = []
  ranges.each do |r|
    # puts "=" * 10
    # puts "Range: #{r}"
    numbers = r.split("-")
    (numbers[0]..numbers[1]).each do |n|
      # puts "Analyzing: #{n}"
      n_as_string = n.to_s
      if n_as_string.length % 2 != 0
        # puts "Number is odd, skipping"
        next
      end

      first_part = n_as_string[0..(n_as_string.length/2-1)]
      second_part = n_as_string[n_as_string.length/2..n_as_string.length]

      if first_part == second_part
        # puts "Found match"
        numbers_to_add << n 
      end
    end
  end
  numbers_to_add
end

def solve_input_part_2(to_solve: "")
  ranges = to_solve.split(",")
  numbers_to_add = []
  ranges.each do |r|
    # puts "=" * 10
    # puts "Range: #{r}"
    numbers = r.split("-")
    (numbers[0]..numbers[1]).each do |n|
      # puts "Analyzing: #{n}"
      doubled = (n + n)[1..-2] # if its a repeating pattern, then it needs to appear inside itself removing the first and last char
      idx = doubled.index(n)

      if idx != nil
        # puts "Found match"
        numbers_to_add << n 
      end
    end
  end
  numbers_to_add
end

# Sample input solver

input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

solution = solve_input_part_2(to_solve: input)
puts "EASY: #{solution.map(&:to_i).sum}"

# Day 2 input - part 1

input = File.read("../input-puzzle.txt")

solution = solve_input_part_1(to_solve: input)
puts "MEDIUM: #{solution.map(&:to_i).sum}"

# Day 2 input - part 2

input = File.read("../input-puzzle.txt")

solution = solve_input_part_2(to_solve: input)
puts "HARD: #{solution.map(&:to_i).sum}"
