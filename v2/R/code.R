primeSieve <- function(n) {
    prime = c(n)
    for (i in 1:n) {
        prime[i] = TRUE
    }
    p = 2
    while (p * p <= n) {
        if (prime[p]) {
            for (i in seq(p*2, n, by=p)) {
                prime[i] = FALSE
            }
        }
        p = p + 1
    }
    prime[1] = FALSE

    rval = c()
    counter = 1
    for (p in 1:n) {
        if (prime[p]) {
            rval[counter] = p
            counter = counter + 1
        }
    }
    dim(rval) = c(counter-1)
    return(rval)
}

cat("s")
if (dim(primeSieve(100000000)) != 5761455) { stop("Prime sieve failed!") }
cat("f")
