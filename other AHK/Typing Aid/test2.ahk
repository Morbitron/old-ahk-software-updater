#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinGet, active_id, ID, A ; store active program

Send, ^!{LEFT} ; select word up to dot

Send, ^x ; cut word

Send, {BS} ; delete dot

list=Win98|W2K|WinXP|Vista|Mac OSX|Ubuntu 7|Redhat 9|MSDOS 6.2

If  (Clipboard = "os")

	list=Win98|W2K|WinXP|Vista|Mac OSX|Ubuntu 7|Redhat 9|MSDOS 6.2

If  (Clipboard = "oz")

	list=Wizard|Yellow Brick Road|Wicked Witch



Gui, -border +toolwindow

Gui, add, listbox, x0 y0 w300 h200 sort vSelected, %list%

Gui, Add, Button, Default, &OK ; "hidden" button

Gui, Show, w300 h200

Return



ButtonOK:

Gui, Submit

Gui, Destroy

WinActivate ahk_id %active_id%

Clipboard:=selected

Send ^v ; or Send % selected

Return



Esc:

GuiEscape:		

GuiClose:		

ExitApp


