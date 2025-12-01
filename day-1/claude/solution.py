#!/usr/bin/env python3
"""
Advent of Code 2025 - Day 1: Secret Entrance

The dial starts at 50 and rotates L (left/lower) or R (right/higher).
The dial wraps around (0-99), so L from 0 goes to 99, R from 99 goes to 0.

Part 1: Count how many times the dial points at 0 after any rotation.
Part 2: Count every time the dial passes through or lands on 0 during rotations.
"""

import sys
from pathlib import Path


def count_zeros_crossed(start: int, distance: int, direction: str) -> int:
    """
    Count how many times we pass through or land on 0 during a rotation.

    Key insight: we count arrivals at 0, not departures. If we start at 0,
    that doesn't count - only stepping onto 0 counts.
    """
    if direction == 'R':
        # Moving right: we hit 0 each time we wrap from 99->0
        # This happens floor((start + distance) / 100) times
        return (start + distance) // 100
    else:  # direction == 'L'
        # Moving left from P by D steps: we visit P-1, P-2, ..., (P-D) mod 100
        # We hit 0 at step k when P - k = 0 (mod 100), i.e., k = P, P+100, ...
        # But if P = 0, we START at 0 and leave it; first return is at step 100
        first_hit = start if start > 0 else 100
        if distance < first_hit:
            return 0
        return (distance - first_hit) // 100 + 1


def solve_part1(input_path: str) -> int:
    """Count times dial ends on 0 after a rotation."""
    dial = 50
    zero_count = 0

    with open(input_path) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            direction = line[0]
            distance = int(line[1:])

            if direction == 'L':
                dial = (dial - distance) % 100
            elif direction == 'R':
                dial = (dial + distance) % 100

            if dial == 0:
                zero_count += 1

    return zero_count


def solve_part2(input_path: str) -> int:
    """Count every time dial passes through or lands on 0 during any rotation."""
    dial = 50
    zero_count = 0

    with open(input_path) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            direction = line[0]
            distance = int(line[1:])

            # Count zeros crossed during this rotation
            zero_count += count_zeros_crossed(dial, distance, direction)

            # Update dial position
            if direction == 'L':
                dial = (dial - distance) % 100
            elif direction == 'R':
                dial = (dial + distance) % 100

    return zero_count


def main():
    if len(sys.argv) > 1:
        input_path = sys.argv[1]
    else:
        script_dir = Path(__file__).parent
        input_path = script_dir.parent / "input-puzzle-1.txt"

    result1 = solve_part1(input_path)
    print(f"Part 1 - Password (times dial ended at 0): {result1}")

    result2 = solve_part2(input_path)
    print(f"Part 2 - Password (times dial crossed/landed on 0): {result2}")


if __name__ == "__main__":
    main()
