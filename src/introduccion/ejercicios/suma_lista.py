import random
import time

def compute_sum(n):
    print(f"Generating list of {n} numbers...")
    data = [random.random() for _ in range(n)]
    print("Computing sum...")
    s = sum(data)
    return s

if __name__ == "__main__":
    start = time.time()
    result = compute_sum(5_000_000)
    end = time.time()

    print(f"Result: {result}")
    print(f"Time elapsed: {end - start:.2f} seconds")
