def primeSieve(n)
    prime = Array.new(n+1, true)
    p = 2
    while p * p <= n
        if prime[p]
            (p*2..n+1).step(p) do |i|
                prime[i] = false
            end
        end
        p += 1
    end
    prime[0] = false
    prime[1] = false

    rval = Array.new
    for p in 0..n
        if prime[p]
            rval.push(p)
        end
    end
    return rval
end

if __FILE__ == $0
    puts "s"
    if primeSieve(100000000).length != 5761455
        raise Exception.new "Prime sieve failed!"
    end
    puts "f"
end