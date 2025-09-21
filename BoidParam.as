;
#ifndef __BOID_PARAM__
#define __BOID_PARAM__

;----------------------------------------
; BoidParam モジュール定義
;----------------------------------------
#module BoidParam vision_, separate_r_, cohesion_k_, alignment_k_, separation_k_, maxspeed_, wallmode_
	#modinit
		vision_	  		= 40.0
		separate_r_  	= 40.0
		cohesion_k_  	= 0.01
		alignment_k_ 	= 0.08
		separation_k_	= 0.19
		maxspeed_		= 3.0
		wallmode_		= 0	; 0=Wrap, 1=Reflect
		return

	; setter/getter（local）
	#modfunc local setVision double aV
		vision_ = aV
		return
	#modcfunc local getVision
		return vision_

	#modfunc local setSeparateR double aV
		separate_r_ = aV
		return
	#modcfunc local getSeparateR
		return separate_r_

	#modfunc local setCohesionK double aV
		cohesion_k_ = aV
		return
	#modcfunc local getCohesionK
		return cohesion_k_

	#modfunc local setAlignmentK double aV
		alignment_k_ = aV
		return
	#modcfunc local getAlignmentK
		return alignment_k_

	#modfunc local setSeparationK double aV
		separation_k_ = aV
		return
	#modcfunc local getSeparationK
		return separation_k_

	#modfunc local setMaxSpeed double aV
		maxspeed_ = aV
		return
	#modcfunc local getMaxSpeed
		return maxspeed_

	#modfunc local setWallMode int aV
		wallmode_ = aV
		return
	#modcfunc local getWallMode
		return wallmode_
#global

#endif	; __BOID_PARAM__
