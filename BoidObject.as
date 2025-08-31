; BoidObject.as
#ifndef __BOID_OBJECT__
#define __BOID_OBJECT__

;----------------------------------------
; Boid Object モジュール定義
;----------------------------------------
#module BoidObject x_, y_, vx_, vy_
	#modinit
		x_ = 0.0
		y_ = 0.0
		vx_ = 0.0
		vy_ = 0.0
		return

	; setter/getter（local）
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

	#modfunc local setVX double aV
		vx_ = aV
		return
	#modcfunc local getVX
		return vx_

	#modfunc local setVY double aV
		vy_ = aV
		return
	#modcfunc local getVY
		return vy_

#global

#endif	; __BOID_OBJECT__
