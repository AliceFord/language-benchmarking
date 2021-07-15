package main

import (
	"fmt"
	"log"
)

func primeSieve(n int) []int {
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

func run() {
	fmt.Println("s")

	if len(primeSieve(100000000)) != 5761455 {
		log.Fatal("Prime sieve failed!")
	}

	fmt.Println("f")
}

func main() {
	run()
}
