from functools import cmp_to_key
from typing import Callable, Iterable, TypeVar

ElementToSort = TypeVar("ElementToSort")


def sorted_with_comparator(
    items: Iterable[ElementToSort],
    comparator: Callable[[ElementToSort, ElementToSort], int],
) -> list[ElementToSort]:
    return sorted(items, key=cmp_to_key(comparator))


CompactedElement = TypeVar("CompactedElement")
ElementToCompact = TypeVar("ElementToCompact")


def compact_map(
    items: Iterable[ElementToCompact | None],
    predicate: Callable[[ElementToCompact | None], CompactedElement | None],
) -> list[CompactedElement]:
    compacted_items: list[CompactedElement] = []
    for item in items:
        result = predicate(item)
        if result is not None:
            compacted_items.append(result)

    return compacted_items
