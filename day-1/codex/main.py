from __future__ import annotations

import pathlib
import sys
from typing import Iterable


def parse_rotations(lines: Iterable[str]) -> Iterable[tuple[str, int]]:
    for raw_line in lines:
        line = raw_line.strip()
        if not line:
            continue
        direction = line[0]
        distance = int(line[1:])
        yield direction, distance


def count_zero_stops(rotations: Iterable[tuple[str, int]], *, start: int = 50) -> int:
    """Count how many rotations end with the dial at 0 (part 1)."""
    position = start
    zeros = 0

    for direction, distance in rotations:
        if direction == "L":
            position = (position - distance) % 100
        else:
            position = (position + distance) % 100

        if position == 0:
            zeros += 1

    return zeros


def _hits_during_move(position: int, direction: str, distance: int) -> int:
    """Count how many intermediate clicks (inclusive of the final one) land on 0."""
    if distance <= 0:
        return 0

    # Find the first step that hits 0 in this direction.
    if direction == "R":
        first_hit = (100 - position) % 100
    else:  # direction == "L"
        first_hit = position % 100

    # If the starting position is already 0, the first time we click back to 0 is 100 steps away.
    if first_hit == 0:
        first_hit = 100

    if distance < first_hit:
        return 0

    return 1 + (distance - first_hit) // 100


def count_zero_clicks(rotations: Iterable[tuple[str, int]], *, start: int = 50) -> int:
    """Count how many clicks (during and at end of rotations) land on 0 (part 2)."""
    position = start
    zeros = 0

    for direction, distance in rotations:
        zeros += _hits_during_move(position, direction, distance)

        if direction == "L":
            position = (position - distance) % 100
        else:
            position = (position + distance) % 100

        # The last click of the rotation was already counted above, so no extra handling needed.

    return zeros


def main() -> None:
    input_path = pathlib.Path(__file__).parent.parent / "input-puzzle-1.txt"
    if len(sys.argv) > 1:
        input_path = pathlib.Path(sys.argv[1])

    with input_path.open() as f:
        rotations = list(parse_rotations(f))

    part1 = count_zero_stops(rotations)
    part2 = count_zero_clicks(rotations)

    print(part1)
    print(part2)


if __name__ == "__main__":
    main()
