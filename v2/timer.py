import subprocess
import numpy as np
import timeit
import math
import time
import sys
import matplotlib.pyplot as plt

def sortWithKeyValue(dict):
    vals = list(dict.items())
    vals2 = []
    for val in vals:
        name = val[0]
        val = val[1]
        sums = [0] * len(val[0])
        for e in val:
            for i, elem in enumerate(e):
                sums[i] += elem
        
        for i, currentSum in enumerate(sums):
            sums[i] = currentSum / len(val[0])
        vals2.append((name, sums))

    vals2 = sorted(vals2, key=lambda x: sum(x[1]))

    return vals2

RUNFILES = {
    #"CPython": "python -u python/code.py",
    #"Ruby": "ruby ruby/code.rb",
    #"PyPy": "C:/pypy/pypy3.exe python/code.py",
    "C++": "\"cpp/noopt\"",
    "C++ (with optimizations)": "\"cpp/opt\"",
    "Java": "java -cp java Main",
    "Golang": "\"golang/code\"",
    "Rust": "\"rust/code/target/release/code\"",
    "Fortran": "\"fortran/code\"",
    "D": "\"D/noopt\"",
    "D (with optimizations)": "\"D/opt\"",
    "Julia": "julia julia/code.jl"
}

# BROKEN:     "BASIC (80k primes)": "C:/Users/olive/Downloads/bbcbasic_console_win64/bbcbasic basic/code.bbc"

timeData = {}

for key, item in RUNFILES.items():
    print(f"---------- {key} ----------")
    times = []
    if len(sys.argv) > 1:
        numTimes = int(sys.argv[1])
    else:
        numTimes = 2
    for i in range(numTimes):
        print("Iteration: " + str(i+1))
        process = subprocess.Popen(item, stdout=subprocess.PIPE, shell=True)
        t1 = time.time()
        while True:
            output = process.stdout.readline().strip()
            if output == b's' or output == b'\x17s':
                t2 = time.time()
            elif output == b'f' or output == b'\x17f':
                t3 = time.time()
                break
            else:
                print(output)
        process.wait()
        t4 = time.time()
        times.append([t2-t1 if t2-t1 > 0 else 0, t3-t2 if t3-t2 > 0 else 0, t4-t3 if t4-t3 > 0 else 0])
    timeData[key] = times

vals = sortWithKeyValue(timeData)
keys = []
values = []
for val in vals:
    keys.append(val[0])
    values.append(val[1])

fig, ax = plt.subplots()
ax.set_xlabel("Language")
ax.set_ylabel("Time (s)")
ax.set_title("Benchmark time per language")

startup = [e[0] for e in values]
runtime = [e[1] for e in values]
shutdown = [e[2] for e in values]

ax.bar(keys, runtime, label="Run Time")
ax.bar(keys, startup, label="Startup Time", bottom=runtime)
ax.bar(keys, shutdown, label="Shutdown Time", bottom=np.array(runtime)+np.array(startup))

ax.legend()

plt.show()
