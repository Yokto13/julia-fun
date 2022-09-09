using Plots

x = -2:0.01:2
y = -2:0.01:2

function julia(x, y, c, it)
    z = x + y * im
    for i=1:it
        z = z ^ 2 + c
        if abs(z) > 2
            return abs(z) / i
        end
    end
    return 0
end

ani = @animate for a=0:0.03:2π
    f(x, y) = julia(x, y, 0.72 * exp(im * a), 100)
    contour(x, y, f, fill=fill=(true,cgrad(:viridis)), 
            title = "Julia set, in Julia, for Julia",
           linewidth=0
          )
end 

gif(ani, "julia.gif", fps=20)

