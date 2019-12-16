#script (lua)
-- clingo = require("clingo")
-- N = clingo.Number
-- F = clingo.Function

loc_table={}
loc_table["s0"] = 0
loc_table["s1"] = 1
loc_table["s2"] = 2
loc_table["s3"] = 3
loc_table["s4"] = 4
loc_table["s5"] = 5
loc_table["s6"] = 6
loc_table["s7"] = 7
loc_table["s8"] = 8
loc_table["s9"] = 9
loc_table["s10"] = 10
loc_table["s11"] = 11
loc_table["s12"] = 12
loc_table["s13"] = 13
loc_table["s14"] = 14

function dis(a,b)
	s = loc_table[a.name]
	sp = loc_table[b.name]
	ret = 1
	if s==sp then
	    ret = 1
	end

	if s == 0 then
	    if sp == 1 then ret = 1 end
	    if sp == 2 then ret = 1 end
	end
	if s == 1 then
	    if sp == 0 then ret = 1 end
	    if sp == 2 then ret = 1 end
	end
	if s == 2 then
	    if sp == 0 then ret = 1 end
	    if sp == 1 then ret = 1 end
	end
	if s == 3 then
	    if sp == 4 then ret = 1 end
	end
	if s == 4 then
	    if sp == 3 then ret = 1 end
	end
	if s == 5 then
	    if sp == 6 then ret = 1 end
	    if sp == 7 then ret = 1 end
	    if sp == 8 then ret = 2 end
	end
	if s == 6 then
	    if sp == 5 then ret = 1 end
	    if sp == 7 then ret = 1 end
	    if sp == 8 then ret = 1 end
	end
	if s == 7 then
	    if sp == 5 then ret = 1 end
	    if sp == 6 then ret = 1 end
	    if sp == 8 then ret = 1 end
	end
	if s == 8 then
	    if sp == 5 then ret = 2 end
	    if sp == 6 then ret = 1 end
	    if sp == 7 then ret = 1 end
	end
	if s == 9 then
	    if sp == 10 then ret = 1 end
	    if sp == 11 then ret = 1 end
	end
	if s == 10 then
	    if sp == 9 then ret = 1 end
	    if sp == 11 then ret = 1 end
	end
	if s == 11 then
	    if sp == 9 then ret = 1 end
	    if sp == 10 then ret = 1 end
	end
	if s == 12 then
	    if sp == 13 then ret = 1 end
	    if sp == 14 then ret = 2 end
	end
	if s == 13 then
	    if sp == 12 then ret = 1 end
	    if sp == 14 then ret = 1 end
	end
	if s == 14 then
	    if sp == 12 then ret = 2 end
	    if sp == 13 then ret = 1 end
	end
	return ret
end

#end.