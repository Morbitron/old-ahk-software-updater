#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

txt := ""
txt_array := Array()
Loop, Read, test.ahk
{ 
	;IfInString, A_LoopReadLine, %word% 
	tmp_str := ""
	
	rule := "[^\s\(\)\!]+\([^\r\n]*\)"
	if(RegExMatch(A_LoopReadLine, rule, leVar)){
		RegExMatch(leVar, "[^\s]+\(", funcName)
		if(!(RegExMatch(txt, funcName))){
			txt .= leVar
			txt_array.Push(leVar)
		}
	}
	;msgbox, pop
	
	;txt .= A_LoopReadLine
		
	
} 
;StringSplit, OutputArray, txt, "|"





;	REGEX find function
;	/[^\s]+\([^\r\n]*\).*\R?\{/g

;	REGEX find procedure
;	/\w+:/g

;	REGEX include
;	/\#include.*/gi


msgbox, % txt



For Key, Value in txt_array
{ 
msgbox, % Value

}