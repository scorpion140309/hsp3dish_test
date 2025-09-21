; BoidPlayer.as
#ifndef __BOID_PLAYER__
#define __BOID_PLAYER__

;----------------------------------------
; Boid Player
;----------------------------------------
#module BoidPlayer flag_enabled_, x_, y_, radius_, mode_
	#modinit
		flag_enabled_ = 1
		x_ = 0.0
		y_ = 0.0
		radius_ = 200.0
		; mode_ : 1=Follow, 2=Avoid
		mode_ = 1
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

#global

#endif	; __BOID_PLAYER__
