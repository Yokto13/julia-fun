# A simple implementation of regression tree. WIP

struct Node
    left
    right
    pred
    isleaf
    ftr
    val
    datainds
end

mutable struct Tree
    root
    data
end

function setprediction!(n, tree)
    res = 0
    for i in n.data
        res += tree.data[i].y
    end
    n.pred = res / length(n.datainds)
end

function splitnode(n, ftrs, tree)
    # This needs tests.
    bestftr = -1
    bestval = -1
    bestcrit = 2 ^ 30
    setprediction!(n, tree)
    baseloss = sum(((n.pred - tree.data[i].y) ^ 2 for i in n.datainds))
    for ftr in 1:ftrs
        left, right, leftpred, rightpred, leftsize, rightsize = 0, 0, n.pred, 0, n.pred, 0, length(n.datainds)
        right = sum(tree.data[i].y for i in n.datainds)
        leftsq, totsq = 0, sum(tree.data[i].y ^ 2 for i in n.datainds)
        sort!(n.datainds, by = x -> tree.data[x][ftr])
        for (cnt, i) in enumerate(n.datainds)
            leftpred = (rightpred * leftsize + tree.data[i].y) / (leftsize + 1)
            leftsize += 1
            left += tree.data[i].y
            leftsq += tree.data[i].y ^ 2
            left += leftsq - 2 * n.pred * left +  
            leftmid = 2 * left * n.pred
            leftc = leftsq + leftmid + cnt * leftpred ^ 2
            right -= tree.data[i].y
            rightpred = (rightpred * rightsize - tree.data[i].y) / (leftsize - 1)
            rightsize -= 1
            rightc = (totsq - leftsq) - 2 * rightpred * right + rightpred ^ 2 * (length(n.datainds) - cnt)
            crit = leftc + rightc
            if bestval > bestcrit
                bestcrit = crit
                bestftr = ftr
                bestval = tree.data[i].x[ftr]
            end
        end
    end
end

function predict(dato, tree::Tree)
    return predict(tree.root)
end

function predict(dato, n::Node)
    if n.isleaf
        return n.pred
    end
    if dato[n.ftr] < n.val
        return n.left
    else
        return n.right
    end
end

function buildtree(t, data)

end
