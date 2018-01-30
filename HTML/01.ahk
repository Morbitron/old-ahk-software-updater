#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;// download the webpage source
URLDownloadToFile, http://www.google.com, Google_HTML
FileRead, html, Google_HTML
FileDelete, Google_HTML

;// write the Google Source to an HTMLfile
document := ComObjCreate("HTMLfile")
document.write(html)

;// loop through all the links
links := document.links
while (A_Index<=links.length, i:=A_Index-1)
   list .= i ") " links[i].innerText "`nURL: " links[i].href "`n`n"

;// some URLs have "about:" rather than the domain
StringReplace, list, list, about:, http://www.google.com, All

MsgBox, %list%