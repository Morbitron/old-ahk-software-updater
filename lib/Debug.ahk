D_ShowText(output){
	;Gui, ShowOutput:New, Options, Show Output
	Gui, ShowOutput:Add,Edit,w800 h500 -Wrap,%output% ;Create an Edit control
	Gui, ShowOutput:Add, Button, default gD_ShowTextDestroy, OK
	Gui, ShowOutput:show ;Show the GUI window
}

D_ShowTextDestroy(){
	Gui, ShowOutput:Destroy
}


;Run through an Object and return a text paragraph 
D_TraceObj(curSelObj, indent="    ", num_indent=""){
	if(IsObject(curSelObj))
	{
		curIndent := ""
		
		if(num_indent == "")
		{
			num_indent := 0
		}	
		loop, %num_indent% {
			curIndent .= indent
		}
		num_indent := num_indent + 1
		curSelObjDUMP := ""
		
		for kTO, vTO in curSelObj {
			if(IsObject(vTO))
			{
				new_indent := indent indent
				curSelObjDUMP .= curIndent "[" kTO "] => `r`n" D_TraceObj(vTO, indent, num_indent) "`r`n"
			}else{
				curSelObjDUMP .= curIndent "[" kTO "] => " vTO "`r`n"
			}
		}
		return curSelObjDUMP
	}else{
		return curSelObj
	}
}


;=======================================================================================================================
;= Console =============================================================================================================
;=======================================================================================================================
global D_CONSOLE_CONTENT := ""
Gui, DConsole:New
Gui, DConsole:Font, s8, Courrier New
Gui, DConsole: +Resize +AlwaysOnTop +MinSize800x720 +MaxSize1920x1280 +LabelDConsole
Gui, DConsole:Add, Edit, vDConsoleVal WantTab R10 

; Create the main Edit control and display the window:
D_ConsoleTrace(string_var=""){
	D_CONSOLE_CONTENT := string_var
	GuiControl,, DConsoleVal, %D_CONSOLE_CONTENT%
	;Gui, DConsole:Show, Autosize Center, Console
	Gui, DConsole:Show, x100 y100, Console
}


D_Trace(string_var){
	D_CONSOLE_CONTENT := D_CONSOLE_CONTENT "`r`n" string_var
	GuiControl,, DConsoleVal, %D_CONSOLE_CONTENT%
	SendMessage, 0x0115, 7, 0, Edit1, Console ;WM_VSCROLL
}

D_QTrace(string_var){
	temp_str := D_CONSOLE_CONTENT "`r`n" string_var
	GuiControl,, DConsoleVal, %temp_str%
	SendMessage, 0x0115, 7, 0, Edit1, Console ;WM_VSCROLL
}

DConsoleSize(GuiHwnd="", EventInfo="", width="", height=""){
	if ErrorLevel = 1  ; The window has been minimized.  No action needed.
		return
	; Otherwise, the window has been resized or maximized. Resize the Edit control to match.
	if(width != "" || height != "" ){
		NewWidth := width - 20
		NewHeight := height - 20
	}
	GuiControl, DConsole:Move, DConsoleVal, W%NewWidth% H%NewHeight%
}

DConsoleEscape(){
	Gui, DConsole:Hide
}

DConsoleClose(){
	Gui, DConsole:Hide
}