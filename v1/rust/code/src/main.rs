use std::io;
use std::char;

const A1_LEN: usize = 13;

fn a005132_internal(n: i32) -> i32 {
    if n == 0 {
        return 0;
    }

    let mut includes: bool = false;
    let itemtotest: i32 = a005132_internal(n-1) - n;
    for k in 0..n {
        if itemtotest == a005132_internal(k) {
            includes = true;
            break;
        }
    }

    if (itemtotest < 0) || includes {
        return a005132_internal(n-1) + n;
    }
    return itemtotest;
}

fn a005132(n: i32) -> [i32; A1_LEN] {
    let mut rval = [0; A1_LEN];

    for i in 1..n+1 {
        rval[(i as usize)-1] = a005132_internal(i);
    }

    return rval;
}

fn a002113(n: i32) -> Vec<i32> {
    let mut output = Vec::new();
    for i in 0..n+1 {
        let mut reverse: i32 = 0;
        let mut j: i32 = i;
        while j > 0 {
            reverse = reverse * 10 + j % 10;
            j /= 10;
        }
        if reverse == i {
            output.push(i);
        }
    }
    return output;
}

fn a000040(n: usize) -> Vec<i32> {
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

fn a005150_internal(n: i32, seq: &str) -> String {
    if n > 1 {
        let mut output = String::new();
        let mut prev = '-';
        let mut len: u8 = 49;
        for c in seq.chars() {
            if c == prev {
                len += 1;
            } else {
                if prev != '-' {
                    output.push(char::from_digit(len as u32, 10).unwrap());
                    output.push(prev);
                    len = 49;
                    prev = c;
                } else {
                    prev = c;
                }
            }
        }
        output.push(char::from_digit(len as u32, 10).unwrap());
        output.push(prev);
        return a005150_internal(n-1, &*output);
    }
    return seq.to_owned();
}

fn a005150(n: usize) -> Vec<String> {
    let mut output = Vec::new();
    for i in 1..n+1 {
        output.push(a005150_internal(i as i32, "1"));
    }
    return output;
}

fn run() {
    let mut ips = String::new();
    io::stdin().read_line(&mut ips).expect("Readline failed.");
    let ip = ips.trim().parse::<i32>().unwrap();
    
    if (ip & ( 1 << 0)) >> 0 == 1 {
        let a1 = a005132(A1_LEN as i32);
        let a1a: [i32; A1_LEN] = [1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23];
        for (i, &item) in a1.iter().enumerate() {
            if item != a1a[i] {
                panic!("a005132 failed!");
            }
        }
    }

    if (ip & ( 1 << 1)) >> 1 == 1 {
        let a2 = a002113(10000000);
        if a2.len() != 10999 {
            panic!("a002113 failed!");
        }
    }

    if (ip & ( 1 << 2)) >> 2 == 1 {
        let a3 = a000040(10000000);
        if a3.len() != 664579 {
            panic!("a002113 failed!");
        }
    }

    if (ip & ( 1 << 3)) >> 3 == 1 {
        let a4 = a005150(45);
        for item in a4.iter() {
            println!("{}", item);
        }
    }
}

fn main() {
    run();
}