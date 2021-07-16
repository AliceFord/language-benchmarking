function primeSieve(n)
    prime = Array{Bool}(undef, n)
    for i in 1:n
        prime[i] = true
    end

    p = 2
    while p * p <= n
        if prime[p]
            for i in p*2:p:n
                prime[i] = false
            end
        end
        p += 1
    end
    prime[1] = false

    rval = Vector{Int}()
    for p in 1:n
        if prime[p]
            append!(rval, p)
        end
    end
    return rval
end

function run()
    println("s")

    if length(primeSieve(100000000)) != 5761455
        throw(error("Prime sieve failed!"))
    end

    println("f")
end

run()