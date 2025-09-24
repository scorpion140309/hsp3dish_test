;
#ifndef __USER_INPUT__
#define __USER_INPUT__

#include "BoidObject.as"
#include "BoidPlayer.as"

#module UserInput

; キー入力状態
k_space = 0
k_esc   = 0
k_q = 0 : k_w = 0 : k_a = 0 : k_s = 0
k_z = 0 : k_x = 0 : k_e = 0 : k_r = 0
k_d = 0 : k_f = 0 : k_c = 0 : k_v = 0
k_m = 0 : k_p = 0
k_i = 0 : k_o = 0

; キー入力旧状態（チャタリング防止）
k_space_old = 0
k_esc_old   = 0
k_q_old = 0 : k_w_old = 0 : k_a_old = 0 : k_s_old = 0
k_z_old = 0 : k_x_old = 0 : k_e_old = 0 : k_r_old = 0
k_d_old = 0 : k_f_old = 0 : k_c_old = 0 : k_v_old = 0
k_m_old = 0 : k_p_old = 0
k_i_old = 0 : k_o_old = 0

#deffunc local Key var aParam, var aPlayer, var aFlagRunning
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

	; Cohesion K (Q/W)
	getkey k_q, 'Q'
	if k_q = 1 & k_q_old = 0 {
		v = getCohesionK@BoidParam(aParam) + 0.01
		setCohesionK@BoidParam aParam, v
	}
	k_q_old = k_q

	getkey k_w, 'W'
	if k_w = 1 & k_w_old = 0 {
		v = getCohesionK@BoidParam(aParam) - 0.01
		if v < 0.0 { v = 0.0 }
		setCohesionK@BoidParam aParam, v
	}
	k_w_old = k_w

	; Alignment K (A/S)
	getkey k_a, 'A'
	if k_a = 1 & k_a_old = 0 {
		v = getAlignmentK@BoidParam(aParam) + 0.01
		setAlignmentK@BoidParam aParam, v
	}
	k_a_old = k_a

	getkey k_s, 'S'
	if k_s = 1 & k_s_old = 0 {
		v = getAlignmentK@BoidParam(aParam) - 0.01
		if v < 0.0 { v = 0.0 }
		setAlignmentK@BoidParam aParam, v
	}
	k_s_old = k_s

	; Player influence radius adjust (Z/X) ? BoidPlayer.addRadius
	getkey k_z, 'Z'
	if k_z = 1 & k_z_old = 0 {
		addRadius@BoidPlayer aPlayer, 10.0
	}
	k_z_old = k_z

	getkey k_x, 'X'
	if k_x = 1 & k_x_old = 0 {
		addRadius@BoidPlayer aPlayer, -10.0
	}
	k_x_old = k_x

	; Vision (E/R)
	getkey k_e, 'E'
	if k_e = 1 & k_e_old = 0 {
		v = getVision@BoidParam(aParam) + 5.0
		setVision@BoidParam aParam, v
	}
	k_e_old = k_e

	getkey k_r, 'R'
	if k_r = 1 & k_r_old = 0 {
		v = getVision@BoidParam(aParam) - 5.0
		if v < 5.0 { v = 5.0 }
		setVision@BoidParam aParam, v
	}
	k_r_old = k_r

	; MaxSpeed (D/F) -- F 下限 0.1
	getkey k_d, 'D'
	if k_d = 1 & k_d_old = 0 {
		v = getMaxSpeed@BoidParam(aParam) + 0.1
		setMaxSpeed@BoidParam aParam, v
	}
	k_d_old = k_d

	getkey k_f, 'F'
	if k_f = 1 & k_f_old = 0 {
		v = getMaxSpeed@BoidParam(aParam) - 0.1
		if v < 0.1 { v = 0.1 }
		setMaxSpeed@BoidParam aParam, v
	}
	k_f_old = k_f

	; Separation K (I/O)
	getkey k_i, 'I'
	if k_i = 1 & k_i_old = 0 {
		v = getSeparationK@BoidParam(aParam) + 0.01
		setSeparationK@BoidParam aParam, v
	}
	k_i_old = k_i

	getkey k_o, 'O'
	if k_o = 1 & k_o_old = 0 {
		v = getSeparationK@BoidParam(aParam) - 0.01
		if v < 0.0 { v = 0.0 }
		setSeparationK@BoidParam aParam, v
	}
	k_o_old = k_o

	; Wall mode toggle (M)
	getkey k_m, 'M'
	if k_m = 1 & k_m_old = 0 {
		setWallMode@BoidParam aParam, 1 - getWallMode@BoidParam(aParam)
	}
	k_m_old = k_m

	; Player mode ? Ignore -> Follow -> Avoid
	getkey k_p, 'P'
	if k_p = 1 & k_p_old = 0 {
		mode_current = getMode@BoidPlayer(aPlayer)
		mode_next = (mode_current + 1) \ 3
		setMode@BoidPlayer aPlayer, mode_next
	}
	k_p_old = k_p

	return
#global

#endif	; __USER_INPUT__
