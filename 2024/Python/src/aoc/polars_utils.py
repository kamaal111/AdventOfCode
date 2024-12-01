from typing import Callable

import polars as pl
from polars.dataframe.group_by import GroupBy


def pl_group_all(
    data_frame: pl.LazyFrame, aggregations: Callable[[GroupBy], pl.LazyFrame]
) -> pl.LazyFrame:
    return aggregations(
        data_frame.with_columns(pl.lit("🐸").alias("🐸")).group_by("🐸")
    ).drop("🐸")
