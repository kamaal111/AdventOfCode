import inspect
from functools import wraps
from time import time


def timeit(function):
    @wraps(function)
    def wrap(*args, **kwargs):
        start = time()
        result = function(*args, **kwargs)
        end = time()
        function_signature = inspect.signature(function)
        params = ", ".join(function_signature.parameters.keys())
        print(f"def {function.__name__}({params}): took: {(end - start):2.4f} sec")

        return result

    return wrap
