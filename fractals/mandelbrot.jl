using Plots

x = -3:0.01:2.
y = -2:0.01:2

function mandelbrot(x, y, it)
    c = x + y * im
    z = 0
    for i=1:it
        z = z ^ 2 + c
        if abs(z) > 2
            return abs(z) / i
        end
    end
    return 0
end

f(x, y) = mandelbrot(x, y, 300)

contour(x, y, f, fill=(true,cgrad(:pearl)), 
        title = "Mandelbrot",
        linewidth=0
        )

savefig("mandelbrot.png")

