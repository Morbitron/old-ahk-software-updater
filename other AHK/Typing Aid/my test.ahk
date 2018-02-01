#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance Force

/*
Loop
{
Input, var, L1,,{Home}{End}{Left}{Up}{Down}{Left}{Right}{Control}{Alt} ; etc.
Send, %var%
POPWIN(A_CaretX, A_CaretY)
}

*/


#NoEnv
#Warn All
#Warn LocalSameAsGlobal, Off
#MaxThreadsBuffer On
SetBatchLines, -1

CoordMode, Caret
SetKeyDelay, 0
SendMode, Input



;TRIGGER KEYS
NormalKeyList := "a`nb`nc`nd`ne`nf`ng`nh`ni`nj`nk`nl`nm`nn`no`np`nq`nr`ns`nt`nu`nv`nw`nx`ny`nz" ;list of key names separated by `n that make up words in upper and lower case variants
NumberKeyList := "1`n2`n3`n4`n5`n6`n7`n8`n9`n0" ;list of key names separated by `n that make up words as well as their numpad equivalents
OtherKeyList := "'`n-" ;list of key names separated by `n that make up words
ResetKeyList := "Esc`nSpace`nHome`nPGUP`nPGDN`nEnd`nLeft`nRight`nRButton`nMButton`n,`n.`n/`n[`n]`n;`n\`n=`n```n"""  ;list of key names separated by `n that cause suggestions to reset
TriggerKeyList := "Tab`nEnter" ;list of key names separated by `n that trigger completion



Gosub, ResetWord

;RESET BEFORE EACH KEY PRESS
SetHotkeys(NormalKeyList,NumberKeyList,OtherKeyList,ResetKeyList,TriggerKeyList)



;OnExit, ExitSub
return


;RESET BEFORE EACH KEY PRESS
SetHotkeys(NormalKeyList,NumberKeyList,OtherKeyList,ResetKeyList,TriggerKeyList)
{
    Loop, Parse, NormalKeyList, `n
    {
        Hotkey, ~%A_LoopField%, Key, UseErrorLevel
        Hotkey, ~+%A_LoopField%, ShiftedKey, UseErrorLevel
    }

    Loop, Parse, NumberKeyList, `n
    {
        Hotkey, ~%A_LoopField%, Key, UseErrorLevel
        Hotkey, ~Numpad%A_LoopField%, NumpadKey, UseErrorLevel
    }

    Loop, Parse, OtherKeyList, `n
        Hotkey, ~%A_LoopField%, Key, UseErrorLevel

    Loop, Parse, ResetKeyList, `n
        Hotkey, ~*%A_LoopField%, ResetWord, UseErrorLevel

    Hotkey, IfWinExist, AutoComplete ahk_class AutoHotkeyGUI
    Loop, Parse, TriggerKeyList, `n
        Hotkey, %A_LoopField%, CompleteWord, UseErrorLevel
}







;TRIGGER ONLY IF IN WINDOW I THINK
#IfWinExist

~BackSpace::
CurrentWord := SubStr(CurrentWord,1,-1)
Gosub, Suggest
Return

Key:
CurrentWord .= SubStr(A_ThisHotkey,2)
Gosub, Suggest
Return

ShiftedKey:
Char := SubStr(A_ThisHotkey,3)
StringUpper, Char, Char
CurrentWord .= Char
Gosub, Suggest
Return

NumpadKey:
CurrentWord .= SubStr(A_ThisHotkey,8)
Gosub, Suggest
Return

ResetWord:
CurrentWord := ""
;Gui, Suggestions:Hide
Return





;CORE FUNCTION TO BUILD SUGGEST MENU
Suggest:
ToolTip, %A_CaretX%  %A_CaretY%  "%CurrentWord%" "%A_ThisHotkey%" 
POPWIN(A_CaretX, A_CaretY)
return


POPWIN(posX, posY){
global
WinGet, active_id, ID, A ; store active program

/*
Send, ^!{LEFT} ; select word up to dot

Send, ^x ; cut word

Send, {BS} ; delete dot
*/
Clipboard := ""
Send, ^+{LEFT} ; select word up to dot
Send, ^c ; cut word
Send, {RIGHT} ; select word up to dot
;msgbox, % Clipboard

;fds
 ; fgsdf s df sde fffddd

 list := CurrentWord
 ;list=Win98|W2K|WinXP|Vista|Mac OSX|Ubuntu 7|Redhat 9|MSDOS 6.2
/*
If  (Clipboard = "os")

	list=Win98|W2K|WinXP|Vista|Mac OSX|Ubuntu 7|Redhat 9|MSDOS 6.2

If  (Clipboard = "oz")

	list=Wizard|Yellow Brick Road|Wicked Witch
*/

Gui, menuTip: Destroy
Gui, menuTip: -border +toolwindow -Caption +AlwaysOnTop

Gui, menuTip: add, listbox, x0 y0 w300 h200 sort vSelected, %list%

Gui, menuTip: Add, Button, Default, &OK ; "hidden" button

;MouseGetPos, px, py
CoordMode, Caret, Screen
realx := posX + 10
Gui, menuTip: Show, w300 h200
;Gui, menuTip: Show, w300 h200 x%realx% y%poxY%
;Gui, menuTip: Show, w300 h200 x%realx% y%poxY%


;SetTimer, FollowMouse, 50
}


;TRIGGER TO CHOOSE A SUGGESTION
ButtonOK:

Gui, menuTip: Submit

Gui, menuTip: Destroy

WinActivate ahk_id %active_id%

Clipboard:=selected

Send ^v ; or Send % selected

Return




Esc:

GuiEscape:		

GuiClose:		

ExitApp

