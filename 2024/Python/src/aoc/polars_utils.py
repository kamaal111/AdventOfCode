from typing import Callable

import polars as pl
from polars.lazyframe.group_by import LazyGroupBy


def pl_group_all(
    data_frame: pl.LazyFrame, aggregations: Callable[[LazyGroupBy], pl.LazyFrame]
) -> pl.LazyFrame:
    return aggregations(
        data_frame.with_columns(pl.lit("🐸").alias("🐸")).group_by("🐸")
    ).drop("🐸")
