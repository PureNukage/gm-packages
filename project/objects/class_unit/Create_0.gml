xx = 0
yy = 0
z = 0
onGround = true
thrust = 0
grav = 1

function setThrust(Thrust) {
	onGround = false
	thrust = Thrust
}
	
function applyThrust() {
	thrust -= grav
	z += thrust
	
	if z <= 0 {
		z = 0
		onGround = true
		thrust = 0
	}
}

function setForce(force, direction) {
	xx = lengthdir_x(force, direction)
	yy = lengthdir_y(force, direction)
}

function applyMovement() {
	
	repeat(4) {
		var pixelsX = 0
		var pixelsY = 0
		var sub = false
		
		var signX = sign(xx)
		var signY = sign(yy)
		
		//	Whole horizontal pixels
		if abs(xx) > 0 and abs(xx) >= 1 {
			pixelsX = floor(abs(xx))
			xx -= sign(xx) * floor(abs(xx))
		}
		//	Sub horizontal pixels
		else if abs(xx) > 0 and abs(xx) < 1 {
			pixelsX = abs(xx)
			xx = 0
			sub = true
		}
		//	Whole vertical pixels
		else if abs(yy) > 0  and abs(yy) >= 1 {
			pixelsY = floor(abs(yy))
			yy -= sign(yy) * floor(abs(yy))
		}
		//	Sub vertical pixels
		else if abs(yy) > 0 and abs(yy) < 1 {
			pixelsY = abs(yy)
			yy = 0
			sub = true
		}
		
		//	Movement code
		var loops = ceil(pixelsX + pixelsY)
		pixelsX *= signX
		pixelsY *= signY
		for(var i=0;i<loops;i++) {
			if !sub {
				var pX = sign(pixelsX)
				var pY = sign(pixelsY)
			}
			else {
				var pX = pixelsX
				var pY = pixelsY
			}
			//	Not colliding with collision
			if !place_meeting(x+pX,y+pY,collision) {
				x += pX
				y += pY
			}
			
		}
		
	}
	
	xx = 0
	yy = 0
	
}