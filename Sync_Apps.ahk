#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

/*   Application map

CheckUpdate(app_id){
static TEMP_FOLDER

	;check if update
	if(YES)
		Msg You want to update
			UpdateApp(app_id)
	else
		return
}


UpdateApp(app_id){
	if(DownloadApp(app_url, TEMP_FOLDER))
		InstallApp(app_url, TEMP_FOLDER)
}


DownloadApp(app_url, TEMP_FOLDER){
	;GetUrl and download to folder
	if(download_work)
		update app "download_date" field
		update app "version" field
	return download_work
}


InstallApp(app_url, TEMP_FOLDER){
	;Do operations of app:
		move(from,to,overwrite)
		copy(from,to,overwrite)
		delete(regex)
		extract(from,to,overwrite)
}
*/


#include <Help_Class>
#include <AHK_general_functions>
#include <Debug>
#include <XA>
#include <7zip>

global FOLDER_library := "lib"
global FOLDER_DOWNLOAD := "download"

;leXML := XA_Load("template_pc_profile.xml") 
;MsgBox, % D_TraceObj(leXML)
;XA_Save(leXML,"text2.xml") 
;URLDownloadToFile, https://autohotkey.com/boards/viewtopic.php?t=3787, page.html
;lol := URLToVar("https://autohotkey.com/boards/viewtopic.php?t=3787")
D_ShowText(URLToVar("https://autohotkey.com/boards/viewtopic.php?t=3787"))











/*
DATA TYPES ////////////////////////////////////

App Internet ------------------------------
{
	"AppID":"LeAPP01",
	"AppName":"Le App Natural Name",
	"AppGroup":"Le Group",
	"DownURL":["URL1","URL2"],
	"PageURL":["URL1","URL2","URL3"],
	""
	"RelPath":".\\compagny\\product\\",
	"InstallDir":"{Author}{Category}{RelPath}{DownloadDate}\\lol\\"
}


PC File/Folder Path config -----------------------

{
	"GroupName":"Group Natural Name",
	"Path":"C:\\type_folder\\stuff\\",
	"Apps":["LeAPP01","LeAPP02","LeAPP03"],
	"FolderRules":["Folder1","Folder2","Folder3"]
}




App PC File/Folder -----------------------
{
	FolderRuleName:"",
	FolderOutRoot:"",
	"Operations":[
		{"type":"move", "In":"", "Out":"", "options":["",""]},
		{"type":"copy", "In":"", "Out":"", "options":["",""]},
		{"type":"delete", "In":"", "options":["",""]}
	]
}








;JSON Indentation
;{"num1":{"num2":{"num3":{}}}}


*/


;DOWNLOAD
downloadURL(url, path)
{
	UrlDownloadToFile, %url%, %path%
	if(ErrorLevel || !FileExist(path) ) {
		msgbox, Download failed!
		return false
	}
	;Run, hotstrings.ahk
	return true
}




;Create Gui
pop()
{
	Gui, RMA2:Add, Edit, w100 vProb_%prodIndex% limit150 yp+0 xp+120
}


;archive := "temp.zip"
;downloadURL("https://github.com/Drugoy/Autohotkey-scripts-.ahk/archive/master.zip", archive)









