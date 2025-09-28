;
#ifndef __USER_INPUT__
#define __USER_INPUT__

#include "BoidObject.as"
#include "BoidPlayer.as"

#module UserInput

#const CURSOR_L 37
#const CURSOR_U 38
#const CURSOR_R 39
#const CURSOR_D 40

#const NUM_ITEMS 10
#const ID_ITEM_FIRST	0
#const ID_ITEM_LAST		9

#const ID_ITEM_VISION			0
#const ID_ITEM_SEPARATE_R		1
#const ID_ITEM_COHESION_K		2
#const ID_ITEM_ALIGNMENT_K		3
#const ID_ITEM_SEPARATION_K		4
#const ID_ITEM_MAX_SPEED		5
#const ID_ITEM_WALL_MODE		6
#const ID_ITEM_RUNNING			7
#const ID_ITEM_PLAYER_RADIUS	8
#const ID_ITEM_PLAYER_MODE		9


; キー入力状態
k_csr_u = 0 : k_csr_d = 0 : k_csr_l = 0 : k_csr_r = 0
k_space = 0
k_esc   = 0

; キー入力旧状態（チャタリング防止）
k_csr_u_old = 0 : k_csr_d_old = 0 : k_csr_l_old = 0 : k_csr_r_old = 0
k_space_old = 0
k_esc_old   = 0

#deffunc local Key var aParam, var aPlayer, var aFlagRunning

	; Cursor Up
	id = int(getSelectedId@BoidParam(aParam))
	getkey k_csr_u, CURSOR_U
	if k_csr_u = 1 & k_csr_u_old = 0 {
		id --
		if id < ID_ITEM_FIRST {
			id = ID_ITEM_LAST
		}
		setSelectedId@BoidParam aParam, id
	}
	k_csr_u_old = k_csr_u

	; Cursor Down
	id = getSelectedId@BoidParam(aParam)
	getkey k_csr_d, CURSOR_D
	if k_csr_d = 1 & k_csr_d_old = 0 {
		id ++
		if id > ID_ITEM_LAST {
			id = ID_ITEM_FIRST
		}
		setSelectedId@BoidParam aParam, id
	}
	k_csr_d_old = k_csr_d

	; add / sub
	input_dir = 0.0
	; Cursor Left
	getkey k_csr_l, CURSOR_L
	if k_csr_l = 1 & k_csr_l_old = 0 {
		input_dir = -1.0
	}
	k_csr_l_old = k_csr_l

	; Cursor Right
	getkey k_csr_r, CURSOR_R
	if k_csr_r = 1 & k_csr_r_old = 0 {
		input_dir = 1.0
	}
	k_csr_r_old = k_csr_r

	switch id
	case ID_ITEM_VISION
		v = getVision@BoidParam(aParam)
		v += input_dir * 5.0
		if v >= 0.0 {
			setVision@BoidParam aParam, v
		}
		swbreak
	case ID_ITEM_SEPARATE_R
		v = getSeparateR@BoidParam(aParam)
		v += input_dir * 1.0
		if v >= 0.0 {
			setSeparateR@BoidParam aParam, v
		}
		swbreak
	case ID_ITEM_COHESION_K
		v = getCohesionK@BoidParam(aParam)
		v += input_dir * 0.01
		if v < 0.0 {
			v= 0.0
		}
		setCohesionK@BoidParam aParam, v
		swbreak
	case ID_ITEM_ALIGNMENT_K
		v = getAlignmentK@BoidParam(aParam)
		v += input_dir * 0.01
		if v < 0.0 {
			v= 0.0
		}
		setAlignmentK@BoidParam aParam, v
		swbreak
	case ID_ITEM_SEPARATION_K
		v = getSeparationK@BoidParam(aParam)
		v += input_dir * 0.01
		if v < 0.0 {
			v= 0.0
		}
		setSeparationK@BoidParam aParam, v
		swbreak
	case ID_ITEM_MAX_SPEED
		v = getMaxSpeed@BoidParam(aParam)
		v += input_dir * 0.1
		if v < 0.0 {
			v= 0.0
		}
		setMaxSpeed@BoidParam aParam, v
		swbreak
	case ID_ITEM_WALL_MODE
		m = getWallMode@BoidParam(aParam)
		m += int(input_dir * 1.0)
		if m < 0 {
			m = 1
		}
		if m > 1 {
			m = 0
		}
		setWallMode@BoidParam aParam, m
		swbreak
	case ID_ITEM_RUNNING
		m = aFlagRunning
		m += int(input_dir * 1.0)
		if m < 0 {
			m = 1
		}
		if m > 1 {
			m = 0
		}
		aFlagRunning = m
		swbreak
	case ID_ITEM_PLAYER_RADIUS
		addRadius@BoidPlayer aPlayer, (input_dir * 10.0)
		swbreak
	case ID_ITEM_PLAYER_MODE
		m = getMode@BoidPlayer(aPlayer)
		m += int(input_dir * 1.0)
		if m < 0 {
			m = 2
		}
		if m > 2 {
			m = 0
		}
		setMode@BoidPlayer aPlayer, m
		swbreak
	swend

	; Space: pause/resume
	getkey k_space, ' '
	if k_space = 1 & k_space_old = 0 {
		aFlagRunning = 1 - aFlagRunning
	}
	k_space_old = k_space

	; ESC: exit
	getkey k_esc, 27
	if k_esc = 1 & k_esc_old = 0 {
		end
	}
	k_esc_old = k_esc

	return

#global

#endif	; __USER_INPUT__
