; BoidPlayer.as
#ifndef __BOID_PLAYER__
#define __BOID_PLAYER__

;----------------------------------------
; Boid Player
;----------------------------------------
#module BoidPlayer flag_enabled_, x_, y_, radius_, mode_, inertia_
	#modinit
		flag_enabled_ = 1
		x_ = 0.0
		y_ = 0.0
		radius_ = 200.0
		; mode_ : 0=Ignore, 1=Follow, 2=Avoid
		mode_ = 0
		inertia_ = 0.9
		return

	; setter/getterÅilocalÅj
	#modfunc local setFlagEnabled int aV
		flag_enabled_ = aV
		return
	#modcfunc local getFlagEnabled
		return flag_enabled_

	#modfunc local setX double aV
		x_ = aV
		return
	#modcfunc local getX
		return x_

	#modfunc local setY double aV
		y_ = aV
		return
	#modcfunc local getY
		return y_

	#modfunc local setRadius double aRadius
		radius_ = aRadius
		return
	#modcfunc local getRadius
		return radius_

	#modfunc local addRadius double aV
		radius_ += aV
		if radius_ < 0.0 {
			radius_ = 0.0
		}
		return

	#modfunc local setMode int aMode
		mode_ = aMode
		return
	#modcfunc local getMode
		return mode_

	#modfunc local setInertia int aInertia
		inertia_ = aInertia
		return
	#modcfunc local getInertia
		return inertia_

	#modfunc local Update double aDistX, double aDistY
		; weight
		s = inertia_
		t = 1.0 - s
	
		; current pos
		oldPlayerX = x_
		oldPlayerY = y_

		; new pos
		x_ = s * oldPlayerX + t * aDistX
		y_ = s * oldPlayerY + t * aDistY
	
		return

#global

#endif	; __BOID_PLAYER__
