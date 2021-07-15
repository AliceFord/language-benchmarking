def primeSieve(n):
    prime = [True for i in range(n+1)]
    p = 2
    while p * p <= n:
        if prime[p]:
            for i in range(p * 2, n+1, p):
                prime[i] = False
        p += 1

    prime[0] = False
    prime[1] = False

    rval = []
    for p in range(n+1):
        if prime[p]:
            rval.append(p)

    return rval

if __name__ == "__main__":
    print("s")
    if len(primeSieve(100000000)) != 5761455: raise Exception("Prime sieve failed!")
    print("f")
