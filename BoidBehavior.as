; BoidBehavior.as
#ifndef __BOID_BEHAVIOR__
#define __BOID_BEHAVIOR__

;----------------------------------------
; Boid Player
;----------------------------------------
#module BoidBehavior
#deffunc local Update int aScreenW, int aScreenH, array aArrayBoids, int aNum, var aParam, var aPlayer
	;
	vision = getVision@BoidParam(aParam)
	sepR   = getSeparateR@BoidParam(aParam)
	cohK   = getCohesionK@BoidParam(aParam)
	aliK   = getAlignmentK@BoidParam(aParam)
	sepK   = getSeparationK@BoidParam(aParam)
	maxSpd = getMaxSpeed@BoidParam(aParam)
	wmode  = getWallMode@BoidParam(aParam)
	logmes "vision=" + vision

	mouseK = 0.12

	;
	pradius = getRadius@BoidPlayer(aPlayer)
	pmode = getMode@BoidPlayer(aPlayer)
	px = getX@BoidPlayer(aPlayer)
	py = getY@BoidPlayer(aPlayer)
	pflag = getFlagEnabled@BoidPlayer(aPlayer)

	repeat aNum
		i = cnt
		x = getX@BoidObject(aArrayBoids(i))
		y = getY@BoidObject(aArrayBoids(i))
		vx = getVX@BoidObject(aArrayBoids(i))
		vy = getVY@BoidObject(aArrayBoids(i))

		sumx = 0.0 : sumy = 0.0
		sumvx = 0.0 : sumvy = 0.0
		sepx = 0.0 : sepy = 0.0
		nCoh = 0 : nSep = 0

		repeat aNum
			j = cnt
			if j = i { continue }
			x2 = getX@BoidObject(aArrayBoids(j))
			y2 = getY@BoidObject(aArrayBoids(j))
			vx2 = getVX@BoidObject(aArrayBoids(j))
			vy2 = getVY@BoidObject(aArrayBoids(j))

			dx = x2 - x
			dy = y2 - y
			d2 = dx*dx + dy*dy
			if d2 = 0.0 { continue }

			if d2 < vision * vision {
				sumx += x2 : sumy += y2
				sumvx += vx2 : sumvy += vy2
				nCoh++
			}

			if d2 < sepR * sepR {
				d = sqrt(d2)
				if d > 0.0 {
					sepx += (x - x2) / d
					sepy += (y - y2) / d
					nSep++
				}
			}
		loop

		; Cohesion + Alignment
		if nCoh > 0 {
			avgx = sumx / nCoh : avgy = sumy / nCoh
			vx += (avgx - x) * cohK
			vy += (avgy - y) * cohK

			avgvx = sumvx / nCoh : avgvy = sumvy / nCoh
			vx += (avgvx - vx) * aliK
			vy += (avgvy - vy) * aliK
		}

		; Separation
		if nSep > 0 {
			vx += sepx * sepK
			vy += sepy * sepK
		}

		; プレイヤー誘導/回避（有効フラグかつ半径内のみ）
		if pflag != 0 {
			ddx = px - x
			ddy = py - y
			dd = sqrt(ddx*ddx + ddy*ddy)
			if dd > 0.0 & dd < pradius {
				if pmode = 1 {
					vx += (ddx / dd) * mouseK
					vy += (ddy / dd) * mouseK
				} else {
					if pmode = 2 {
						vx -= (ddx / dd) * mouseK
						vy -= (ddy / dd) * mouseK
					}
				}
			}
		}

		; 速度制限
		sp = sqrt(vx*vx + vy*vy)
		if sp > maxSpd {
			vx = vx / sp * maxSpd
			vy = vy / sp * maxSpd
		}

		; 位置更新
		x += vx : y += vy

		; 壁処理（Wrap / Reflect）
		if wmode = 0 {
			if x < 0.0 { x += aScreenW }
			if x >= aScreenW { x -= aScreenW }
			if y < 0.0 { y += aScreenH }
			if y >= aScreenH { y -= aScreenH }
		} else {
			if x < 0.0 { x = 0.0 : vx = -vx }
			if x > aScreenW { x = aScreenW : vx = -vx }
			if y < 0.0 { y = 0.0 : vy = -vy }
			if y > aScreenH { y = aScreenH : vy = -vy }
		}

		setX@BoidObject aArrayBoids(i), x
		setY@BoidObject aArrayBoids(i), y
		setVX@BoidObject aArrayBoids(i), vx
		setVY@BoidObject aArrayBoids(i), vy
	loop
	return

#global

#endif	; __BOID_BEHAVIOR__
