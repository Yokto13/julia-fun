# Simple RSA example, do *not* use this at home.

function extendedeuclid(a, b)
    u, v, w, x = 1, 0, 0, 1
    while b != 0
        t = (w, x)
        q = div(a, b)
        w, x = [u, v] .- q * [w, x]
        u, v = t
        a, b = b, a % b
    end
    return u, v
end

function exp(a, e, m)
    a %= m
    res = 1
    while e > 0
        if e % 2 == 1
            res = res * a % m
        end
        a = a * a % m
        e = div(e, 2)
    end
    return res
end

function modinv(a, m)
    return (extendedeuclid(a, m)[1] + m) % m
end

@assert 3 == extendedeuclid(77, 10)[1]

println("RSA")

e = 3
p = 11 
q = 5
tot = (p - 1) * (q - 1)
N = p * q
d = modinv(e, tot)
@assert e * d % tot == 1
@assert gcd(e, tot) == 1
println(d)
println(tot)

println("Public N: ", N)
println("Public e: ", e)


println("Give me the message: ")
mess = readline()
mess = parse(Int64, mess)


decrypted = exp(mess, d, N)
println("The decrypted message is: ", decrypted)
