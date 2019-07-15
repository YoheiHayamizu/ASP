#script (lua)
clingo = require("clingo")
N = clingo.Number
F = clingo.Function

function g(c, f)
    a = -math.huge
    n = c.name
    r = F(n, f.arguments)
    return r
    end

#end.