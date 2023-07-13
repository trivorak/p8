-- desc:    balloon cheap
-- license  I dont know
-- version: 0.1
-- script:  lua

bgcolor = 9
air = 0
hcolor = 5
angle = 0
popped = false
cx = 120
cy = 68
ballcol = 12
movex = 0
movey = 0
speed = 7
rel = false
invx = false
invy = false
lnx = 0
lny = 0
invxv = 1
invyv = 1
lastrandom = 0
currentrandom = 0

function TIC()
 
	if (cx+air/2 > 240) then 
		invx = callinverse(invx)	
		cx = 240 - air/2
	elseif (cx-air/2 < 0) then 
		invx = callinverse(invx)
		cx = air/2 - 0 
	elseif (cy+air/2 > 135) then
		invy = callinverse(invy)
		cy = 135 - air/2
	elseif (cy-air/2 < 0) then
		invy = callinverse(invy)
		cy = air/2 + 0
	end

	if invx == true then
		invxv = -1
	elseif invx == false then
		invxv = 1
	end

	if invy == true then
		invyv = -1
	elseif invy == false then
		invyv = 1
	end

 -- controls
	if btn(0) and (popped == false) then
		air = air + 2
	end
	
	if btn(1) and (popped == false) then 
		air = air -2
	end
	
	if btn(2) then 
		angle = (angle-2)%360 
	end
	
	if btn(3) then 
		angle = (angle+2)%360 
	end
	
	if btn(4) then
		cx = cx + mvx * -1 * invxv
		cy = cy + mvy * -1 * invyv
		currentrandom = math.random(10)-5 + lastrandom/1.08
		angle = angle + currentrandom
		lastrandom = currentrandom
	end
	-- air repair
	if air < 0 then air = 0 end
	if air > 76 then air = 76 end 

	lnx = sinx(air/2,angle)*invxv+cx
	lny = cosy(air/2,angle)*invyv+cy
	mvx = sinx(speed,angle)
	mvy = cosy(speed,angle)
	
	-- draw shit
 	cls(bgcolor)
	circ(cx,cy,air/2,ballcol)
	circ(lnx,lny,3,ballcol)
	--health for display
	rectb(0,130-air,1,air,hcolor)
	line(cx,cy,lnx,lny,10)
	print(lnx,0,6,12)
end

function sinx(rad,angle)
	return rad*(math.sin(math.rad(angle)))
end

function cosy(rad,angle)
	return rad*math.cos(math.rad(angle))
end

function callinverse(input)
	if input == true then 
		return false 
	end
	if input == false then 
		return true 
	end
end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

