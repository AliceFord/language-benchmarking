#include <algorithm>
#include <array>
#include <iostream>
#include <string>
#include <vector>

bool prime[100000001] = {true};

void primeSieve(int n, std::vector<int> *rval) {
    std::fill_n(prime, n, true);
    int p = 2;
    while (p * p <= n) {
        if (prime[p]) {
            for (int i = p * 2; i < n+1; i += p) {
                prime[i] = 0;
            }
        }
        p++;
    }
    prime[0] = 0;
    prime[1] = 0;

    for (int i = 0; i < n+1; i++) {
        if (prime[i]) {
            rval->push_back(i);
        }
    }
}

void run() {
    std::cout << "s" << std::endl;

    std::vector<int> sieve;
    primeSieve(100000000, &sieve);
    if (sieve.size() != 5761455) throw "Prime sieve failed!";

    std::cout << "f" << std::endl;
}

int main() {
    run();
}
