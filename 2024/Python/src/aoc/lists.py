from functools import cmp_to_key
from typing import Callable, TypeVar

ElementToSort = TypeVar("ElementToSort")


def sorted_with_comparator(
    data: list[ElementToSort], comparator: Callable[[ElementToSort, ElementToSort], int]
):
    return sorted(data, key=cmp_to_key(comparator))
