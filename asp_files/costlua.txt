#begin_lua

loc_table={}
loc_table["s0"] = 0
loc_table["s7"] = 7
loc_table["s10"] = 10
loc_table["s13"] = 13
loc_table["s1"] = 1
loc_table["s2"] = 2
loc_table["s4"] = 4
loc_table["s5"] = 5
loc_table["s6"] = 6
loc_table["s8"] = 8
loc_table["s9"] = 9
loc_table["s11"] = 11
loc_table["s12"] = 12
loc_table["s14"] = 14
door_table={}
door_table["d0"] = 0
door_table["d1"] = 1
door_table["d2"] = 2
door_table["d3"] = 3
door_table["d4"] = 4

function dis(a,b,c)
	d1 = door_table[tostring(a)]
	d2 = door_table[tostring(b)]
	if d1==d2 then return 1 end
	loc = loc_table[tostring(c)]
	if loc==0 then
		if d1==0 then
			if d2==2 then return 1 end
		end
		if d1==2 then
			if d2==0 then return 1 end
		end
	end
	if loc==1 then
		if d1==0 then
			if d2==2 then return 1 end
		end
		if d1==2 then
			if d2==0 then return 1 end
		end
	end
	if loc==2 then
		if d1==0 then
			if d2==2 then return 1 end
		end
		if d1==0 then
			if d2==2 then return 1 end
		end
	end
	if loc==3 then
		if d1==1 then
			if d2==1 then return 1 end
		end
	end
	if loc==4 then
		if d1==1 then
			if d2==1 then return 1 end
		end
	end
	if loc==5 then
		if d1==0 then
			if d2==1 then return 2 end
			if d2==4 then return 2 end
		end
		if d1==1 then
			if d2==0 then return 2 end
			if d2==4 then return 2 end
		end
		if d1==4 then
			if d2==0 then return 2 end
			if d2==1 then return 2 end
		end
	end
    if loc==6 then
		if d1==0 then
			if d2==1 then return 2 end
			if d2==4 then return 2 end
		end
		if d1==1 then
			if d2==0 then return 2 end
			if d2==4 then return 2 end
		end
		if d1==4 then
			if d2==0 then return 2 end
			if d2==1 then return 2 end
		end
	end
    if loc==7 then
		if d1==0 then
			if d2==1 then return 1 end
			if d2==4 then return 1 end
		end
		if d1==1 then
			if d2==0 then return 1 end
			if d2==4 then return 1 end
		end
		if d1==4 then
			if d2==0 then return 1 end
			if d2==1 then return 1 end
		end
	end
    if loc==8 then
		if d1==0 then
			if d2==1 then return 2 end
			if d2==4 then return 2 end
		end
		if d1==1 then
			if d2==0 then return 2 end
			if d2==4 then return 2 end
		end
		if d1==4 then
			if d2==0 then return 2 end
			if d2==1 then return 2 end
		end
	end
    if loc==9 then
		if d1==3 then
			if d2==4 then return 1 end
		end
		if d1==4 then
			if d2==3 then return 1 end
		end
	end
    if loc==10 then
		if d1==3 then
			if d2==4 then return 1 end
		end
		if d1==4 then
			if d2==3 then return 1 end
		end
	end
    if loc==11 then
		if d1==3 then
			if d2==4 then return 1 end
		end
		if d1==4 then
			if d2==3 then return 1 end
		end
	end
    if loc==12 then
		if d1==2 then
			if d2==3 then return 2 end
		end
		if d1==3 then
			if d2==2 then return 2 end
		end
	end
    if loc==13 then
		if d1==2 then
			if d2==3 then return 1 end
		end
		if d1==3 then
			if d2==2 then return 1 end
		end
	end
    if loc==14 then
		if d1==2 then
			if d2==3 then return 2 end
		end
		if d1==3 then
			if d2==2 then return 2 end
		end
	end
	return 1
end

#end_lua.