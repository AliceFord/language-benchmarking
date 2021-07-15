import subprocess
import numpy as np
import timeit
import math
import time
import sys
import matplotlib.pyplot as plt

def sortWithKeyValue(dict):
    vals = dict.values()

    vals = sorted(vals, key=lambda x: x[1])
    keys = []
    for e in vals:
        for key, item in dict.items():
            if item == e:
                keys.append(key)
                break

    return keys, vals

RUNFILES = {
    #"CPython": "python python/out.py",
    "PyPy": "C:/pypy/pypy3.exe python/out.py",
    "C++": "\"cpp/noopt\"",
    "C++ (with optimizations)": "\"cpp/opt\"",
    "Java": "java -cp java Main",
    "Golang": "\"golang/code\"",
    "Rust": "\"rust/code/target/release/code\""
}

timeData = {}

for key, item in RUNFILES.items():
    times = []
    if len(sys.argv) > 1:
        numTimes = int(sys.argv[1])
    else:
        numTimes = 2
    for i in range(numTimes):
        print("Iteration: " + str(i+1))
        t1 = time.time()
        proc = subprocess.Popen(item, stdout=subprocess.PIPE, stdin=subprocess.PIPE, shell=True)
        proc.communicate(str(int(bin(0b11100).replace("0b", "").zfill(5)[::-1], base=2)).encode("UTF-8"))
        proc.wait()
        t2 = time.time()
        times.append(t2-t1)
    print("-------- " + key + " --------")
    print("Max time: \t\t" + str(max(times)))
    print("Min time: \t\t" + str(min(times)))
    print("Mean average time: \t" + str(sum(times) / numTimes))
    print("Median average time: \t" + str(times[numTimes // 2] if numTimes % 2 == 0 else (times[math.floor(numTimes / 2)] + times[math.ceil(numTimes / 2)]) / 2))
    print("Range: \t\t\t" + str(max(times) - min(times)))
    q3, q1 = np.percentile(np.array(times), [75, 25])
    print("Interquartile Range: \t" + str(q3 - q1))
    print("-------------------------------------------------")
    timeData[key] = [times, sum(times) / numTimes]

keys, values = sortWithKeyValue(timeData)

fig, ax = plt.subplots()
ax.set_xlabel("Language")
ax.set_ylabel("Time (s)")
ax.set_title("Benchmark time per language")

# for i, value in enumerate(timeData.values()):
#     data = [value[0]]
#     ax.boxplot(data, positions=[i])

ax.bar(keys, [e[1] for e in values])

plt.show()
