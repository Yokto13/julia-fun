using Plots

function plotcantor(cantor)
    plot(size = (2000, 2000))
    for (cnt, intervals) in enumerate(cantor)
        h = 1 - (cnt - 1) * 1 / length(cantor)
        for interval in intervals
            plot!(interval, [h, h], lw=5, seriestype=:shape, label=false)
        end
    end
    savefig("cantor.png")
end

function cantorize(intervals)
    out = []
    for interval in intervals
        d = interval[2] - interval[1]
        push!(out, [interval[1], interval[1] + 1/3 * d])
        push!(out, [interval[1] + 2/3 * d, interval[2]])
    end
    return out
end

function generatecantor(depth)
    intervals = [[[0.0, 1.0]]]
    for i in 1:depth - 1
        push!(intervals, cantorize(last(intervals))) 
    end
    return intervals
end
    
function cantor(depth)
    intervals = generatecantor(depth)
    # println(intervals)
    plotcantor(intervals)
end

cantor(7)
