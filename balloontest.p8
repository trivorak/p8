pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

--cos(angle) * radius = x coordinate
function _init()
	air = 0
	hcolor = 0
	angle = 0
	popped = false
	cx = 128/2
	cy = 128/2
	ballcol = 2
	movex = 0
	movey = 0
	speed = 10
	rel = false
	invx = false
	invy = false
end

function _update()
	if (btn(2)) and (popped == false) then 
		air += 2
	else 
		air -= 0.25
	end
	
	if (btn(2) == false) and (popped == true) then 
		popped = false 
	end
	
	if (air>100) then 
		air = 0  
		popped = true
		sfx(0) 
	end
	
	if (btn(4)) then 
		cx += movex
		cy += movey
		angle = (rnd(10)-5) + angle
		air -= 1
		if (invx == true) then 
			movex = getsinx(speed,angle)
		else
			movex = getsinx(speed,angle)*-1
		end
		if (invy == true) then
			movey = getcosy(speed,angle)
		else 
			movey = getcosy(speed,angle)*-1
		end

	end

	if (btn(5)) then cy += 2 end
	if (air<0) then air = 0 end

	if (btn(1)) then 
		movex = getsinx(speed,angle)*-1
		movey = getcosy(speed,angle)*-1
		angle += 5 
	end

	if (btn(0)) then 
		movex = getsinx(speed,angle)*-1
		movey = getcosy(speed,angle)*-1
		angle -= 5 
	end

	if (angle > 359) then angle = 0 end
	if (angle < 0) then angle = 359 end
	healthclr()
	if (btnp(3)) then ballcol += 1 end
	if (ballcol>15) then ballcol = 1 end
	
	--correct for edge overhang and reverse
	if (cx + air/2 > 128) then
		cx = cx -((cx+air/2)-128)
		movex *= -1 
		updateangle()
	end
	
	if (cx - air/2 < 0) then 
		cx = cx-((cx-air/2)-0)
		movex *= -1 
		updateangle()
	end
	
	if (cy + air/2 > 128) then 
		cy = cy -((cy+air/2)-128)
		movey *= -1 
		updateangle()
	end
	
	if (cy - air/2 < 0) then 
		cy = cy - ((cy-air/2)-0)
		movey *= -1 
		updateangle()
	end
end

function _draw()
	cls()
	mkhealth()
	circfill(cx,cy,air/2,ballcol)
	--if (air>12) then circfill(cx+getsinx(air/2,angle),cy+getcosy(air/2,angle),5,ballcol) end
	print("p = " .. tostr(popped),0,7,12)
	print("an = " .. angle,0,14,12)
	--line(cx,cy,cx+getsinx(air/2,angle),cy+getcosy(air/2,angle),9)
end

function mkhealth()
	--make line rectangle
	rectfill(0,128,1,128-(air+2),hcolor)
	print("a = ".. air,0,0,12)
end

function healthclr()
	--change health color based on amount
	if (air < 90) then hcolor = 10 end
	if (air > 90) then hcolor = 9 end
	if (air > 95) then hcolor = 8 end
end

function getcosy(rad,ang)
	return rad*(cos(ang/360))
end

function getsinx(rad,ang)
	return rad*(sin(ang/360) *-1)
end

function updateangle()
	angle = atan2(movex,movey)*360
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002265008650046500165000650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0009000533600236200f6301363022650036500465005650066500665006650066501865024650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
