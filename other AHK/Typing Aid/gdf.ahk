#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance Force

:*:##::
	Gui, Destroy
	CoordMode, Caret, Screen
	x := A_CaretX
	y := A_CaretY + 20
	openwin()
	RETURN

openwin()
{
	global
	Gui, Add, Edit, vMyEdit
	Gui, Add, MonthCal, gCalender vMyCalendar
	Gui, Add, Button, Default, OK
	FormatTime, l_today, %A_NOW%, dd.MM.yyyy
	GuiControl,,MyEdit, %l_today%
	MsgBox %x% %y%
	Gui, Show, X%x% Y%y%
	return
}

Calender:
FormatTime, date, %MyCalendar%, dd.MM.yyyy
GuiControl,,MyEdit, %date%
RETURN

ButtonOK:
Gui, Submit
Gui, Destroy
sendInput %MyEdit%{Space}

GuiClose:
GuiEscape:
Gui, Destroy