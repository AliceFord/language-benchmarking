import std.stdio;
import std.algorithm;
import core.simd;

void primeSieve(int n, int[]* rval) { 
    bool[] prime;
    prime.length = n+1;
    fill(prime, true);
    int p = 2;
    while (p * p <= n) {
        if (prime[p]) {
            for (int i = p * 2; i < n+1; i += p) {
                prime[i] = false;
            }
        }
        p++;
    }
    prime[0] = false;
    prime[1] = false;

    (*rval).length = n;
    int* rvalPtr = (*rval).ptr;

    for (int i = 0; i < n+1; i++) {
        if (prime[i]) {
            *rvalPtr = i;
            rvalPtr++;
        }
    }
    const int len = rvalPtr - (*rval).ptr;
    (*rval).length = len;
}

void run() {
    writeln("s");

    int[] sieve;
    primeSieve(100000000, &sieve);
    if (sieve.length != 5761455) throw new Exception("Prime sieve failed!");
    else writeln("f");
}

int main() {
    run();

    return 0;
}