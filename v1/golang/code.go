package main

import (
	"bytes"
	"fmt"
	"log"
)

func contains(s []int, item int) bool {
	for _, v := range s {
		if v == item {
			return true
		}
	}

	return false
}

func equal(a, b []int) bool {
	if len(a) != len(b) {
		return false
	}
	for i, v := range a {
		if v != b[i] {
			return false
		}
	}
	return true
}

func a005132_internal(n int) int {
	if n == 0 {
		return 0
	}

	var includes bool = false

	var itemtotest int = a005132_internal(n-1) - n
	for k := 0; k < n; k++ {
		if itemtotest == a005132_internal(k) {
			includes = true
			break
		}
	}

	if (itemtotest < 0) || includes {
		return a005132_internal(n-1) + n
	}
	return itemtotest

}

func a005132(n int) []int {
	var rval = make([]int, n)

	for i := 1; i <= n; i++ {
		rval[i-1] = a005132_internal(i)
	}

	return rval
}

func a002113(n int) []int {
	var output = make([]int, 0)
	for i := 0; i < n+1; i++ {
		var reverse int = 0
		for j := i; j > 0; j /= 10 {
			reverse = reverse*10 + j%10
		}
		if reverse == i {
			output = append(output, i)
		}
	}
	return output
}

func a000040(n int) []int {
	var prime = make([]bool, n+1)
	for i := 0; i < n+1; i++ {
		prime[i] = true
	}

	for p := 2; p*p <= n; p++ {
		if prime[p] {
			for i := p * 2; i < n+1; i += p {
				prime[i] = false
			}
		}
	}
	prime[0] = false
	prime[1] = false

	var output = make([]int, 0)
	for i := range prime {
		if prime[i] {
			output = append(output, i)
		}
	}
	return output
}

func a005150_internal(n int, seq string) string {
	if n > 1 {
		var output bytes.Buffer
		var prev rune = '-'
		var len rune = 49
		for _, c := range seq {
			if c == prev {
				len++
			} else {
				if prev != '-' {
					output.WriteString(string(len))
					output.WriteString(string(prev))
					len = 49
					prev = c
				} else {
					prev = c
				}
			}
		}
		output.WriteString(string(len))
		output.WriteString(string(prev))
		return a005150_internal(n-1, output.String())
	}
	return seq
}

func a005150(n int) []string {
	var output = make([]string, n)
	for i := 1; i <= n; i++ {
		output[i-1] = a005150_internal(i, "1")
	}
	return output
}

func a000045_internal(n int) int {
	if n > 1 {
		return a000045_internal(n-1) + a000045_internal(n-2)
	}
	return 1
}

func a000045(n int) []int {
	var output = make([]int, n)
	for i := 1; i <= n; i++ {
		output[i-1] = a000045_internal(i)
	}
	return output
}

func run() {
	var ip int
	fmt.Scan(&ip)

	if (ip&(1<<0))>>0 == 1 {
		if !equal(a005132(13), []int{1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23}) {
			log.Fatal("a005132 failed!")
		}
	}

	if (ip&(1<<1))>>1 == 1 {
		if len(a002113(10000000)) != 10999 {
			log.Fatal("a002113 failed!")
		}
	}

	if (ip&(1<<2))>>2 == 1 {
		if len(a000040(10000000)) != 664579 {
			log.Fatal("a000040 failed!")
		}
	}

	if (ip&(1<<3))>>3 == 1 {
		var a4a []int = []int{1, 2, 2, 4, 6, 6, 8, 10, 14, 20, 26, 34, 46, 62, 78, 102, 134, 176, 226, 302, 408, 528, 678, 904, 1182, 1540, 2012, 2606, 3410, 4462, 5808, 7586, 9898, 12884, 16774, 21890, 28528, 37158, 48410, 63138, 82350, 107312, 139984, 182376, 237746}
		var response []string = a005150(45)
		for i, val := range response {
			if len(val) != a4a[i] {
				log.Fatal("a005150 failed!")
			}
		}
	}

	if (ip&(1<<4))>>4 == 1 {
		if !equal(a000045(35), []int{1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352}) {
			log.Fatal("a000045 failed!")
		}
	}
}

func main() {
	run()
}
