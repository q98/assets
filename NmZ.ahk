#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

cakeColor := 0xFF0000
sorbColor := 0x00FAFF
ovlColor := 0x00FF00
logTab := 0xFFB700FF
logOption := 0xFFFF5700
notBusy := false
shouldCake := false
shouldAbsorb := false
shouldOvl := false
sorbX := 0
sorbY := 0
invX := 0
invY := 0
ovlX := 0
ovlY := 0
usingOvl := true ;switch to false for long afk



target_random(min, target, max){
	Random, lower, min, target
	Random, upper, target, max
	Random, weighted, lower, upper
	Return, weighted

}
rand_range(min, max) {
	Random, r, %min%, %max%
	return r
}

clickx(x, y) {
	sleep rand_range(250, 500)
	MouseClick,, % x+target_random(-10,0,10), % y+target_random(-10,0,10)
	sleep rand_range(250, 500)	
}
shiftclick(x, y) {
	sleep rand_range(250, 500)
	Send {Shift down}
	MouseClick,, % x+target_random(-10,0,10), % y+target_random(-10,0,10)	
	sleep rand_range(250, 500)
	Send {Shift up}
}

logout() {
	clickx(648,503)
	sleep 200
	clickx(644,454)
	MsgBox, script ended
	ExitApp
	
}

1::
loop {
	SetDefaultMouseSpeed, rand_range(0,16)
	SetMouseDelay, rand_range(-1,50)
	
	PixelSearch, logTabX, logTabY, 529, 486, 663, 527, logTab, 1, fast RGB
	if (ErrorLevel = 0) { 
		logout()
	}else {
		
	}
	PixelSearch, invX, invY, 550, 227, 744, 505, cakeColor, 1, fast RGB
	sleep 300
	if (ErrorLevel = 0) { 
		notBusy := false
		shouldCake := true
	} else {
		shouldCake := false
	}
	PixelSearch, sorbX, sorbY, 550, 227, 744, 505, sorbColor, 1, fast RGB
	sleep 300
	if (ErrorLevel = 0) {
		notBusy := false
		shouldAbsorb := true
	} else {
		shouldAbsorb := false
	}
	
	if (usingOvl) {
		PixelSearch, ovlX, ovlY, 550, 227, 744, 505, ovlColor, 1, fast 
		sleep 300
		if (ErrorLevel = 0) {
			notBusy := false
			shouldOvl := true
		} else {
			shouldOvl := false
		}
	}
	
	
	
	
	
	if (shouldCake) && (!shouldAbsorb) && (!shouldOvl) {
		shiftclick(invX, invY)
		sleep rand_range(500, 2000)		
	}
	if (shouldCake) && (shouldOvl) {
		clickx(ovlX, ovlY)
		sleep rand_range(4500, 6000)
	}
	if (shouldCake) && (shouldOvl) && (shouldAbsorb) {
		clickx(ovlX, ovlY)
		sleep rand_range(4500, 6000)
	}
	if (shouldCake) && (shouldAbsorb) && (!shouldOvl){
		shiftclick(invX, invY)
		sleep rand_range(500, 2000)		
	}
	if (shouldAbsorb) && (!shouldCake) && (!shouldOvl) {
		;sleep rand_range(500, 2000)
		clickx(sorbX, sorbY)
		sleep rand_range(500, 2000)
	}
	if (!shouldCake) && (!shouldOvl) && (!shouldAbsorb) {
		notBusy := true
	}
	
	if (notBusy) {
		MouseMove, rand_range(850,1012), rand_range(27,527)
		Sleep, rand_range(500,3000)
	}
	
	
	
	
}

	;todo add random sleep stuff and randomization

	3::ExitApp