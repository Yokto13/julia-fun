using Plots

function easy_u(x)
    return x ^ x
end

function easy_l(x)
    return x ^ (x / 2)
end

function e_u(x)
    return ℯ * x * (x / ℯ) ^ x
end

function e_l(x)
    return ℯ * (x / ℯ) ^ x
end

function st(x)
    return √(2 * π * x) * (x / ℯ) ^ x
end

r = 0:7

plot(factorial, r, label="factorial", title="factorial approximations")
#plot!(easy_u, r, label="Simple approximation, upper")
plot!(easy_l, r, label="Simple approximation, lower")
plot!(e_l, r, label="Lower approximation with e")
plot!(e_u, r, label="Upper approximation with e")
plot!(st, r, label="Stirling's formula")


savefig("factorials.png")

