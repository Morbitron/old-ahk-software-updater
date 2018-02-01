#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

color := HtmlBgColor()

;// HTML to be added to a GUI:
html =
(
   <body style='background-color:%color%;overflow:auto'>
      <span id='id' style='color:black'>text color</span> example
   </body>
)

;// create a simple GUI
Gui, Add, Button, x6 y60 w55 h20, Red
Gui, Add, Button, x71 y60 w55 h20, Blue
Gui, Add, ActiveX, x0 y-5 w140 h50 vdocument, HTMLFile
document.write(html)
Gui, Show, x399 y246 w138 h86, HTML
return

GuiClose:
   Gui, Destroy
   ExitApp
ButtonRed:
ButtonBlue:
   document.all("id").style.color := SubStr(A_ThisLabel,7)
   return

HtmlBgColor() {
   Format := A_FormatInteger
   SetFormat, IntegerFast, Hex
   color := SubStr(DllCall("GetSysColor", "int",15),3)
   SetFormat, IntegerFast, %Format%
   return SubStr(color,5,2) SubStr(color,3,2) SubStr(color,1,2) ;// switch from BGR -> RGB
}