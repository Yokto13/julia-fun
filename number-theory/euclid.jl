using Random

function euclid_old(a, b)
    while b != 0
        if a >= b
            a -= b
        else
            a, b = b, a
        end
    end
    return a
end

function euclid_c(a, b)
    while b != 0
        a, b = b, a % b 
    end
    return a
end

function euclid_r(a, b)
    if b == 0
        return a
    end
    return euclid_r(b, a % b)
end

function euclid_fast(a, b)
    # https://cp-algorithms.com/algebra/euclid-algorithm.html#binary-gcd
    if a == 0 || b == 0
        return a | b
    end
    s = trailing_zeros(a | b)
    a >>= trailing_zeros(a)
    while true
        b >>= trailing_zeros(b)
        if a > b
            a, b = b, a
        end
        b -= a
        if b == 0
            break
        end
    end
    return a << s
end

# ---------------------
# Corectness
Random.seed!(42)

# small
r = 1:100
testcases = []
for i in 1:10
    push!(testcases, rand(r, 2))
end
for t in testcases
    a, b = t
    gcd = euclid_c(a, b)
    @assert gcd == euclid_old(a, b)
    @assert gcd == euclid_r(a, b)
    @assert gcd == euclid_fast(a, b)
end

# ---------------------
# Timing
# small 
r = 100:(2^32)
testcases = []
for i in 1:100
    push!(testcases, rand(r, 2))
end
for i in 1:100
    push!(testcases, (rand(r), rand(2:100)))
end
c = 0
old = 0
r = 0
fast = 0
for t in testcases
    a, b = t
    global c, old, r, fast
    c += @elapsed euclid_c(a, b)
    old += @elapsed euclid_old(a, b)
    r += @elapsed euclid_r(a, b)
    fast += @elapsed euclid_fast(a, b)
end

println("Averages for small:")
println("c ", c / length(testcases))
println("old ", old / length(testcases))
println("r ", r / length(testcases))
println("fast ", fast / length(testcases))

# ---------------------
# Timing
# big
r = 100:(2^62)
testcases = []
for i in 1:100
    push!(testcases, rand(r, 2))
end
for i in 1:100
    push!(testcases, (rand(r), rand(2:100)))
end
c = 0
r = 0
fast = 0
for t in testcases
    a, b = t
    global c, r,fast 
    c += @elapsed euclid_c(a, b)
    r += @elapsed euclid_r(a, b)
    fast += @elapsed euclid_fast(a, b)
end

println("Averages for small:")
println("c ", c / length(testcases))
println("r ", r / length(testcases))
println("fast ", fast / length(testcases))
