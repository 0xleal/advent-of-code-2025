def check_adjacent(matrix, max_row, max_column, row, column)
  hits = 0
  
  if row + 1 < max_row && matrix[row + 1][column] == "@"
    hits += 1
  end
  if row - 1 >= 0 && matrix[row - 1][column] == "@"
    hits += 1
  end
  if column + 1 < max_column && matrix[row][column + 1] == "@"
    hits += 1
  end
  if column - 1 >= 0 && matrix[row][column - 1] == "@"
    hits += 1
  end
  if row + 1 < max_row && column + 1 < max_column && matrix[row + 1][column + 1] == "@"
    hits += 1
  end
  if row + 1 < max_row && column - 1 >= 0 && matrix[row + 1][column - 1] == "@"
    hits += 1
  end
  if row - 1 >= 0 && column + 1 < max_column && matrix[row - 1][column + 1] == "@"
    hits += 1
  end
  if row - 1 >= 0 && column - 1 >= 0 && matrix[row - 1][column - 1] == "@"
    hits += 1 
  end
  
  return (hits >= 4)
end

def solve_input_part_1(to_solve: "")
  matrix = to_solve.split("\n").map { |row| row.chars }
  rows = matrix.length
  cols = matrix[0].length
  number_of_fork_enabled_rolls = 0

  rows.times do |row|
    cols.times do |col|
      next unless matrix[row][col] == "@"

      unless check_adjacent(matrix, rows, cols, row, col)
        number_of_fork_enabled_rolls += 1
      end
    end
  end

  number_of_fork_enabled_rolls
end

def solve_input_part_2(to_solve: "")
  matrix = to_solve.split("\n").map { |row| row.chars }
  rows = matrix.length
  cols = matrix[0].length
  total_removed = 0

  loop do
    to_remove = []

    rows.times do |row|
      cols.times do |col|
        next unless matrix[row][col] == "@"

        unless check_adjacent(matrix, rows, cols, row, col)
          to_remove << [row, col]
        end
      end
    end

    break if to_remove.empty?

    to_remove.each { |r, c| matrix[r][c] = "." }
    total_removed += to_remove.length
  end

  total_removed
end

# Sample input solver

sample_input = "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@."

# Part 1 sample (expected: 357)
solution = solve_input_part_1(to_solve: sample_input)
puts "Part 1 Sample: #{solution} (expected: 13)"

# Part 2 sample (expected: 3121910778619)
solution = solve_input_part_2(to_solve: sample_input)
puts "Part 2 Sample: #{solution} (expected: __)"

# Day 4 input - part 1
input = File.read("../input-puzzle.txt")
solution = solve_input_part_1(to_solve: input)
puts "Part 1 Answer: #{solution}"

# Day 4 input - part 2
input = File.read("../input-puzzle.txt")
solution = solve_input_part_2(to_solve: input)
puts "Part 2 Answer: #{solution}"
