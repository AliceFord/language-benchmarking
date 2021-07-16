fn prime_sieve(n: usize) -> Vec<i32> {
    let mut prime = vec![true; n+1];
    
    let mut p: usize = 2;
    while p * p <= n {
        if prime[p] {
            let mut i: usize = p * 2;
            while i < n+1 {
                prime[i] = false;
                i += p;
            }
        }

        p += 1;
    }
    prime[0] = false;
    prime[1] = false;

    let mut output = Vec::new();
    for (i, &item) in prime.iter().enumerate() {
        if item {
            output.push(i as i32);
        }
    }
    return output;
}

fn run() {
    println!("s");

    let sieve = prime_sieve(100000000);
    if sieve.len() != 5761455 {
        panic!("a002113 failed!");
    }

    println!("f")
}

fn main() {
    run();
}