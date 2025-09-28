;
#ifndef __DRAW_SOMETHING__
#define __DRAW_SOMETHING__

#include "BoidObject.as"
#include "BoidPlayer.as"

#module Draw

; const
#const double MATH_PI 3.14159265358979

;
index = 0

#deffunc local BoidSingle var aBoid, double aSize
	pi = MATH_PI
	x = getX@BoidObject(aBoid)
	y = getY@BoidObject(aBoid)
	vx = getVX@BoidObject(aBoid)
	vy = getVY@BoidObject(aBoid)

	ang = atan(vy, vx)
	x1 = x + cos(ang) * aSize : y1 = y + sin(ang) * aSize
	x2 = x + cos(ang + pi*0.75) * (aSize * 0.5) : y2 = y + sin(ang + pi*0.75) * (aSize * 0.5)
	x3 = x + cos(ang - pi*0.75) * (aSize * 0.5) : y3 = y + sin(ang - pi*0.75) * (aSize * 0.5)

	color 0,255,255
	line x1, y1, x2, y2
	line x2, y2, x3, y3
	line x3, y3, x1, y1
	return

#deffunc local PlayerCore var aPlayer, double aSize
	pm = getMode@BoidPlayer(aPlayer)
	px = getX@BoidPlayer(aPlayer)
	py = getY@BoidPlayer(aPlayer)
	pr = getRadius@BoidPlayer(aPlayer)

	switch pm
	col0 = 255
	col1 = 255
	col2 = 255
	case 0
		col0 = 127
		col1 = 127
		col2 = 127
		swbreak
	case 1
		col0 = 0
		col1 = 255
		col2 = 0
		swbreak
	case 2
		col0 = 255
		col1 = 0
		col2 = 0
		swbreak
	swend
	color col0, col1, col2
	circle px-aSize, py-aSize, px+aSize, py+aSize

	;
	color 255,255,255
	circle px-pr, py-pr, px+pr, py+pr, 0

	return

#deffunc local Player var aPlayer, double aSize
	pm = getMode@BoidPlayer(aPlayer)
	if pm != 0 {
		PlayerCore aPlayer, aSize
	}

	return

#deffunc local Information var aParams, var aPlayer, int aFlagRunning
	MARGIN_MENU_X = 32
	MARGIN_MENU_Y = 16
	STEP_MENU_Y = 20
	pos_y = MARGIN_MENU_Y

	color 255,255,255
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	mes "VISION=" + double(getVision@BoidParam(aParams))
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	mes "SEPARATE_R=" + double(getSeparateR@BoidParam(aParams))
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	mes "COHESION_K=" + double(getCohesionK@BoidParam(aParams))
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	mes "ALIGNMENT_K=" + double(getAlignmentK@BoidParam(aParams))
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	mes "SEPARATION_K=" + double(getSeparationK@BoidParam(aParams))
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	mes "MAXSPEED=" + double(getMaxSpeed@BoidParam(aParams))
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	if getWallMode@BoidParam(aParams) = 0 {
		mes "WALLMODE=Wrap"
	} else {
		mes "WALLMODE=Reflect"
	}
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	if aFlagRunning = 1 {
		mes "Running: Yes (Space to Pause)"
	} else {
		mes "Running: No  (Space to Resume)"
	}
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	mes "PLAYER_RADIUS=" + getRadius@BoidPlayer(aPlayer)
	pos MARGIN_MENU_X, pos_y : pos_y += STEP_MENU_Y
	str_mode = "Ignore"
	switch getMode@BoidPlayer(aPlayer)
	case 1
		str_mode = "Follow"
		swbreak
	case 2
		str_mode = "Avoid"
		swbreak
	swend
	mes "PLAYER_MODE=" + str_mode

	;
	id = getSelectedId@BoidParam(aParam)
	cursor_x = 8
	cursor_y = MARGIN_MENU_Y + id * STEP_MENU_Y
	pos cursor_x, cursor_y
	mes ">"

	return

	#deffunc local DrawArrayBoids array aArrayBoids, int aNum, double aSize
		repeat aNum
			BoidSingle aArrayBoids(cnt), aSize
		loop
		return
#global

#endif	; __DRAW_SOMETHING__
