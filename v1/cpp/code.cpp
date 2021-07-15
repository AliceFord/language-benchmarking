#include <algorithm>
#include <array>
#include <iostream>
#include <string>
#include <vector>

int a005132_internal(int n) {
    if (n == 0) return 0;
    bool includes = false;
    int itemtotest = a005132_internal(n-1)-n;
    for (int k = 0; k < n; k++) {
        if (itemtotest == a005132_internal(k)) {
            includes = true;
            break;
        }
    }
    if ((itemtotest < 0) || includes) {
        return a005132_internal(n-1) + n;
    } else {
        return itemtotest;
    }
}

void a005132(int ntop, int* rval) {
    for (int i = 1; i <= ntop; i++) {
        rval[i-1] = a005132_internal(i);
    }
}

bool ispalindrome(std::string s) {
    int l = 0;
    int h = s.length()-1;
    while(h > l){
        if(s[l++] != s[h--]){
            return false;
        }
    }
    return true;
}

void a002113(int n, std::vector<int> *rval) {
    for (int i = 0; i < n+1; i++) {
        int reverse = 0;
        for (int j = i; j > 0; j /= 10)
            reverse = reverse*10 + j%10;
        if (reverse == i) rval->push_back(i);
    }
}

bool prime[10000001] = {true};

void a000040(int n, std::vector<int> *rval) {
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

std::string a005150_internal(int n, std::string seq) {
    if (n > 1) {
        std::string output = "";
        char prev = '-';
        char len = 49;
        for (char c : seq) {
            if (c == prev) {
                len++;
            } else {
                if (prev != '-') {
                    output += len;
                    output += prev;
                    len = 49;
                    prev = c;
                } else {
                    prev = c;
                }
            }
        }
        output += len;
        output += prev;
        return a005150_internal(n-1, output);
    }
    return seq;
}

void a005150(int ntop, std::string* rval) {
    for (int i = 1; i <= ntop; i++) {
        rval[i-1] = a005150_internal(i, "1");
    }
}

int a000045_internal(int n) {
    if (n > 1) return a000045_internal(n-1) + a000045_internal(n-2);
    return 1;
}

void a000045(int ntop, int* rval) {
    for (int i = 1; i <= ntop; i++) {
        rval[i-1] = a000045_internal(i);
    }
}


bool equalArrays(int *a, int *b) {
    if (sizeof(a) != sizeof(b)) return false;
    for (int i = 0; i < sizeof(a) / sizeof(a[0]); i++) {
        if (a[i] != b[i]) return false;
    }
    return true;
}

void run() {
    int ip;
    std::cin >> ip;

    if ((ip & ( 1 << 0 )) >> 0) {
        int a1[13]; int a1a[] = {1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23};
        a005132(13, a1);
        if (!equalArrays(a1, a1a)) throw "a005132 failed!";
    }

    if ((ip & ( 1 << 1 )) >> 1) {
        std::vector<int> a2;
        a002113(10000000, &a2);
        std::cout << a2.size();
        if (a2.size() != 10999) throw "a002113 failed!";
    }

    if ((ip & ( 1 << 2 )) >> 2) {
        std::vector<int> a3;
        a000040(10000000, &a3);
        if (a3.size() != 664579) throw "a000040 failed!";
    }

    if ((ip & ( 1 << 3 )) >> 3) {
        std::string a4[40]; int a4a[] = {1, 2, 2, 4, 6, 6, 8, 10, 14, 20, 26, 34, 46, 62, 78, 102, 134, 176, 226, 302, 408, 528, 678, 904, 1182, 1540, 2012, 2606, 3410, 4462, 5808, 7586, 9898, 12884, 16774, 21890, 28528, 37158, 48410, 63138, 82350, 107312, 139984, 182376, 237746};
        a005150(40, a4);
        for (int i = 0; i < 40; i++) if (a4[i].length() != a4a[i]) throw "a005150 failed!";
    }

    if ((ip & ( 1 << 4 )) >> 4) {
        int a5[35]; int a5a[] = {1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352};
        a000045(35, a5);
        if (!equalArrays(a5, a5a)) throw "a000045 failed!";
    }
}

int main() {
    run();
}
