#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
/*

#NoEnv

#Warn All
#Warn LocalSameAsGlobal, Off

#MaxThreadsBuffer On


*/






global g_Helper_Id
WinGet, g_Helper_Id, ID, A

prefs_ListBoxRows := 5


g_ListBox%A_Index% := Array("gggg","hfghf","popoog")
g_ListBox := Array("gggg","hfghf","popoog")
g_ListBox = gggg|fsdsf|gffgdfg|gfdgfdgd|fgdfdsgfdsg

g_DelimiterChar := |
g_ListBoxPosX := HCaretX()
ListBoxPosY := HCaretY()
ListBoxActualSizeH := 100
ListBoxActualSizeW := 100


Gui, ListBoxGui: -Caption +AlwaysOnTop +ToolWindow +Delimiter%g_DelimiterChar%

  ; Loop, %prefs_ListBoxRows%
 ;  {
      ;GuiControl, ListBoxGui:-Redraw, g_ListBox%A_Index%
      GuiControl, ListBoxGui:-Redraw, g_ListBox
      ;can't use a g-label here as windows sometimes passes the click message when spamming the scrollbar arrows
      Gui, ListBoxGui: Add, ListBox, vg_ListBox R4 X0 Y0 hwndg_ListBoxHwnd
   ;}


Gui, ListBoxGui: Show, NoActivate X%g_ListBoxPosX% Y%ListBoxPosY% H%ListBoxActualSizeH% W%ListBoxActualSizeW%, Word List Appears Here.
Gui, ListBoxGui: +LastFound +AlwaysOnTop





;------------------------------------------------------------------------

; function to grab the X position of the caret for the ListBox
HCaretX() 
{ 
   global g_Helper_Id
    
   WinGetPos, HelperX,,,, ahk_id %g_Helper_Id% 
   if HelperX !=
   { 
      return HelperX
   } 
   if ( CheckIfCaretNotDetectable() )
   { 
      MouseGetPos, MouseX
      return MouseX
   } 
   return A_CaretX 
} 

;------------------------------------------------------------------------

; function to grab the Y position of the caret for the ListBox
HCaretY() 
{ 
   global g_Helper_Id

   WinGetPos,,HelperY,,, ahk_id %g_Helper_Id% 
   if HelperY != 
   { 
      return HelperY
   } 
   if ( CheckIfCaretNotDetectable() )
   { 
      MouseGetPos, , MouseY
      return MouseY + 20
   } 
   return A_CaretY 
}

;------------------------------------------------------------------------

CheckIfCaretNotDetectable()
{
   ;Grab the number of non-dummy monitors
   SysGet, NumMonitors, 80
   
   IfLess, NumMonitors, 1
      NumMonitors = 1
   
   if !(A_CaretX)
   {
      Return, 1
   }
   
   ;if the X caret position is equal to the leftmost border of the monitor +1, we can't detect the caret position.
   Loop, %NumMonitors%
   {
      SysGet, Mon, Monitor, %A_Index%
      if ( A_CaretX = ( MonLeft ) )
      {
         Return, 1
      }
      
   }
   
   Return, 0
}





Loopfunc(){
global
g_ListBoxPosX := HCaretX()
ListBoxPosY := HCaretY()
Gui, ListBoxGui: Show, NoActivate X%g_ListBoxPosX% Y%ListBoxPosY% H%ListBoxActualSizeH% W%ListBoxActualSizeW%, Word List Appears Here.
sleep 300
Loopfunc()
}

Loopfunc()


sleep 3000
exitapp






InitializeListBox()
{
   global
   
   Gui, ListBoxGui: -Caption +AlwaysOnTop +ToolWindow +Delimiter%g_DelimiterChar%
   /*
   Local ListBoxFont
   if (prefs_ListBoxFontOverride && prefs_ListBoxFontOverride != "<Default>")
   {
      ListBoxFont := prefs_ListBoxFontOverride
   } else IfEqual, prefs_ListBoxFontFixed, On
   {
      ListBoxFont = Courier New
   } else {
      ListBoxFont = Tahoma
   }
      
   Gui, ListBoxGui:Font, s%prefs_ListBoxFontSize%, %ListBoxFont%

   Loop, %prefs_ListBoxRows%
   {
      GuiControl, ListBoxGui:-Redraw, g_ListBox%A_Index%
      ;can't use a g-label here as windows sometimes passes the click message when spamming the scrollbar arrows
      Gui, ListBoxGui: Add, ListBox, vg_ListBox%A_Index% R%A_Index% X0 Y0 hwndg_ListBoxHwnd%A_Index%
   }
	*/
   
   Return
}
InitializeListBox()







g_ListBoxPosX := 10
ListBoxPosY := 10
ListBoxActualSizeH := 100
ListBoxActualSizeW := 100


      Gui, ListBoxGui: Show, NoActivate X%g_ListBoxPosX% Y%ListBoxPosY% H%ListBoxActualSizeH% W%ListBoxActualSizeW%, Word List Appears Here.
      Gui, ListBoxGui: +LastFound +AlwaysOnTop
      
      
      WinGet, g_ListBox_Id, ID, Word List Appears Here.
      
      ListBoxThread := DllCall("GetWindowThreadProcessId", "Ptr", g_ListBox_Id, "Ptr", g_NULL)
       
      









/*



InitializeListBox()
{
   global
   
   Gui, ListBoxGui: -Caption +AlwaysOnTop +ToolWindow +Delimiter%g_DelimiterChar%
   
   Local ListBoxFont
   if (prefs_ListBoxFontOverride && prefs_ListBoxFontOverride != "<Default>")
   {
      ListBoxFont := prefs_ListBoxFontOverride
   } else IfEqual, prefs_ListBoxFontFixed, On
   {
      ListBoxFont = Courier New
   } else {
      ListBoxFont = Tahoma
   }
      
   Gui, ListBoxGui:Font, s%prefs_ListBoxFontSize%, %ListBoxFont%

   Loop, %prefs_ListBoxRows%
   {
      GuiControl, ListBoxGui:-Redraw, g_ListBox%A_Index%
      ;can't use a g-label here as windows sometimes passes the click message when spamming the scrollbar arrows
      Gui, ListBoxGui: Add, ListBox, vg_ListBox%A_Index% R%A_Index% X0 Y0 hwndg_ListBoxHwnd%A_Index%
   }

   Return
}












;Show matched values
; Any changes to this function may need to be reflected in ComputeListBoxMaxLength()
ShowListBox()
{
   global

   IfNotEqual, g_Match,
   {
      Local BorderWidthX
      Local ListBoxActualSize
      Local ListBoxActualSizeH
      Local ListBoxActualSizeW
      Local ListBoxPosY
      Local ListBoxSizeX
      Local ListBoxThread
      Local MatchEnd
      Local Rows
      Local ScrollBarWidth
      static ListBox_Old_Cursor

      Rows := GetRows()
      
      IfGreater, g_MatchTotal, %Rows%
      {
         SysGet, ScrollBarWidth, %g_SM_CXVSCROLL%
         if ScrollBarWidth is not integer
            ScrollBarWidth = 17
      } else ScrollBarWidth = 0
   
      ; Grab the internal border width of the ListBox box
      SysGet, BorderWidthX, %g_SM_CXFOCUSBORDER%
      If BorderWidthX is not integer
         BorderWidthX = 1
      
      ;Use 8 pixels for each character in width
      ListBoxSizeX := g_ListBoxCharacterWidthComputed * g_MatchLongestLength + g_ListBoxCharacterWidthComputed + ScrollBarWidth + (BorderWidthX * 2)
      
      g_ListBoxPosX := HCaretX()
      ListBoxPosY := HCaretY()
      
      ; In rare scenarios, the Cursor may not have been detected. In these cases, we just won't show the ListBox.
      IF (!(g_ListBoxPosX) || !(ListBoxPosY))
      {
         return
      }
      
      MatchEnd := g_MatchStart + (prefs_ListBoxRows - 1)
      
      Loop, %prefs_ListBoxRows%
      { 
         IfEqual, A_Index, %Rows%
         {
            GuiControl, ListBoxGui: -Redraw, g_ListBox%A_Index%
            GuiControl, ListBoxGui: Move, g_ListBox%A_Index%, w%ListBoxSizeX%
            GuiControl, ListBoxGui: ,g_ListBox%A_Index%, %g_DelimiterChar%%g_Match%
            IfNotEqual, g_MatchPos,
            {
               GuiControl, ListBoxGui: Choose, g_ListBox%A_Index%, %MatchEnd%
               GuiControl, ListBoxGui: Choose, g_ListBox%A_Index%, %g_MatchPos%
            }
            GuiControl, ListBoxGui: +AltSubmit +Redraw, g_ListBox%A_Index%
            GuiControl, ListBoxGui: Show, g_ListBox%A_Index%
            GuiControlGet, ListBoxActualSize, ListBoxGui: Pos, g_ListBox%A_Index%
            Continue
         }
      
         GuiControl, ListBoxGui: Hide, g_ListBox%A_Index%
         GuiControl, ListBoxGui: -Redraw, g_ListBox%A_Index%
         GuiControl, ListBoxGui: , g_ListBox%A_Index%, %g_DelimiterChar%
      }
      
      ForceWithinMonitorBounds(g_ListBoxPosX,ListBoxPosY,ListBoxActualSizeW,ListBoxActualSizeH,Rows)
      
      g_ListBoxContentWidth := ListBoxActualSizeW - ScrollBarWidth - BorderWidthX
      
      IfEqual, g_ListBox_Id,
      {
         
         if prefs_DisabledAutoCompleteKeys not contains L
         {
            if (!ListBox_Old_Cursor)
            {
               ListBox_Old_Cursor := DllCall(g_SetClassLongFunction, "Uint", g_ListBoxHwnd%Rows%, "int", g_GCLP_HCURSOR, "int", g_cursor_hand)
            }
            
            DllCall(g_SetClassLongFunction, "Uint", g_ListBoxHwnd%Rows%, "int", g_GCLP_HCURSOR, "int", g_cursor_hand)
            
         ; we only need to set it back to the default cursor if we've ever unset the default cursor
         } else if (ListBox_Old_Cursor)
         {
            DllCall(g_SetClassLongFunction, "Uint", g_ListBoxHwnd%Rows%, "int", g_GCLP_HCURSOR, "int", ListBox_Old_Cursor)
         }
            
      }
      
      Gui, ListBoxGui: Show, NoActivate X%g_ListBoxPosX% Y%ListBoxPosY% H%ListBoxActualSizeH% W%ListBoxActualSizeW%, Word List Appears Here.
      Gui, ListBoxGui: +LastFound +AlwaysOnTop
      
      IfEqual, g_ListBox_Id,
      {
         
         EnableKeyboardHotKeys()   
      }
      
      WinGet, g_ListBox_Id, ID, Word List Appears Here.
      
      ListBoxThread := DllCall("GetWindowThreadProcessId", "Ptr", g_ListBox_Id, "Ptr", g_NULL)
      if (g_ScrollEventHook && (ListBoxThread != g_ScrollEventHookThread))
      {
         DllCall("UnhookWinEvent", "Uint", g_ScrollEventHook)
         g_ScrollEventHook =
         g_ScrollEventHookThread =
         MaybeCoUninitialize()
      }
         
      if (!g_ScrollEventHook) {
         MaybeCoInitializeEx()
         g_ScrollEventHook := DllCall("SetWinEventHook", "Uint", g_EVENT_SYSTEM_SCROLLINGSTART, "Uint", g_EVENT_SYSTEM_SCROLLINGEND, "Ptr", g_NULL, "Uint", g_ListBoxScrollCallback, "Uint", g_PID, "Uint", ListBoxThread, "Uint", g_NULL)
         g_ScrollEventHookThread := ListBoxThread
      }
      
      OnMessage(g_WM_LBUTTONUP, "ListBoxClickItem")
      OnMessage(g_WM_LBUTTONDBLCLK, "ListBoxClickItem")
      
      IfNotEqual, prefs_ListBoxOpacity, 255
         WinSet, Transparent, %prefs_ListBoxOpacity%, ahk_id %g_ListBox_Id%
   }
}









CloseListBox()
{
   global g_ListBox_Id
   IfNotEqual, g_ListBox_Id,
   {
      Gui, ListBoxGui: Hide
      ListBoxEnd()
   }
   Return
}

DestroyListBox()
{
   Gui, ListBoxGui:Destroy
   ListBoxEnd()
   Return
}

ListBoxEnd()
{
   global g_ScrollEventHook
   global g_ScrollEventHookThread
   global g_ListBox_Id
   global g_WM_LBUTTONUP
   global g_WM_LBUTTONDBLCLK
   
   g_ListBox_Id =
   
   OnMessage(g_WM_LBUTTONUP, "")
   OnMessage(g_WM_LBUTTONDBLCLK, "")

   if (g_ScrollEventHook) {
      DllCall("UnhookWinEvent", "Uint", g_ScrollEventHook)
      g_ScrollEventHook =
      g_ScrollEventHookThread =
      MaybeCoUninitialize()
   }
   DisableKeyboardHotKeys()
   return
}
*/