#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance,Force

#Include XML.ahk

attribute:="unity.ApplicationPath"
xmlcontents=
(
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<options version="410">
	<!--group unity.Options-->
	<!--group unity.General-->
	<entryvalue ident="unity.AutoIncrementProjectVer" value="1"></entryvalue>
	<entryvalue ident="unity.AutoCompletion" value="1"></entryvalue>
	<entryvalue ident="unity.DisplayErrorMode" value="0"></entryvalue>
	<entryvalue ident="unity.OpeninContextActive" value="1"></entryvalue>
	<entryvalue ident="unity.DisplayModifiedSections" value="1"></entryvalue>
	<!--group unity.Paths-->
	<entryvalue ident="unity.ApplicationPath" value="C:\Users\Public\Documents\Schneider Electric\Unity Pro"></entryvalue>
	<entryvalue ident="unity.SourcePath" value="C:\Users\Public\Documents\Schneider Electric\Unity Pro"></entryvalue>
	<entryvalue ident="unity.XVMPath" value="C:\Users\Public\Documents\Schneider Electric\Unity Pro"></entryvalue>
	<entryvalue ident="unity.TemplatePath" value="C:\Users\Public\Documents\Schneider Electric\Unity Pro"></entryvalue>
	<entryvalue ident="unity.TemplateFile" value=""></entryvalue>
	<entryvalue ident="unity.CustomLibraryPath" value="C:\ProgramData\Schneider Electric\Unity Pro\CustomLibset\V11.0"></entryvalue>
	<entryvalue ident="unity.WorkingPath" value="C:\"></entryvalue>
	<entryvalue ident="unity.LogPath" value="C:\ProgramData\Schneider Electric\Unity Pro\"></entryvalue>
	<!--group unity.DataLanguages-->
	<!--group unity.SpreadsheetBehavior-->
	<entryvalue ident="unity.CtrlTreeMoveStyle" value="4"></entryvalue>
	<entryvalue ident="unity.CtrlTreeOpenSessionMode" value="1"></entryvalue>
	<!--group unity.Languages-->
	<entryvalue ident="unity.AutoSetVarOnGraphObj" value="0"></entryvalue>
	<entryvalue ident="unity.RefineBehaviour" value="0"></entryvalue>
	<!--group unity.LL984-->
	<entryvalue ident="unity.ShowLatchedCoils" value="0"></entryvalue>
	<entryvalue ident="unity.Reuse984EditorNetwork" value="1"></entryvalue>
	<!--group unity.Mnemonics-->
	<entryvalue ident="unity.-][-" value="NO"></entryvalue>
	<entryvalue ident="unity.-]\[-" value="NC"></entryvalue>
	<entryvalue ident="unity.-]P[-" value="PTC"></entryvalue>
	<entryvalue ident="unity.-]N[-" value="NTC"></entryvalue>
	<entryvalue ident="unity.|SHRT" value="VTS"></entryvalue>
	<entryvalue ident="unity.-SHRT" value="HSH"></entryvalue>
	<entryvalue ident="unity.-( )-" value="CNR"></entryvalue>
	<entryvalue ident="unity.-(L)-" value="CR"></entryvalue>
	<entryvalue ident="unity.L9_SKP" value="SKP"></entryvalue>
	<entryvalue ident="unity.L9_UCTR" value="UCT"></entryvalue>
	<entryvalue ident="unity.L9_DCTR" value="DCT"></entryvalue>
	<entryvalue ident="unity.L9_T1" value="T1"></entryvalue>
	<entryvalue ident="unity.L9_T01" value="T0"></entryvalue>
	<entryvalue ident="unity.L9_T001" value="T00"></entryvalue>
	<entryvalue ident="unity.L9_ADD" value="ADD"></entryvalue>
	<entryvalue ident="unity.L9_SUB" value="SUB"></entryvalue>
	<entryvalue ident="unity.L9_MUL" value="MUL"></entryvalue>
	<entryvalue ident="unity.L9_DIV" value="DIV"></entryvalue>
	<entryvalue ident="unity.L9_R2T" value="RT"></entryvalue>
	<entryvalue ident="unity.L9_T2R" value="TR"></entryvalue>
	<entryvalue ident="unity.L9_T2T" value="TT"></entryvalue>
	<entryvalue ident="unity.L9_BLKM" value="BLK"></entryvalue>
	<entryvalue ident="unity.L9_FIN" value="FIN"></entryvalue>
	<entryvalue ident="unity.L9_FOUT" value="FOU"></entryvalue>
	<entryvalue ident="unity.L9_SRCH" value="SRC"></entryvalue>
	<entryvalue ident="unity.L9_STAT" value="STA"></entryvalue>
	<entryvalue ident="unity.L9_AND" value="AND"></entryvalue>
	<entryvalue ident="unity.L9_OR" value="OR"></entryvalue>
	<entryvalue ident="unity.L9_CMPR" value="CMP"></entryvalue>
	<entryvalue ident="unity.L9_SENS" value="SEN"></entryvalue>
	<entryvalue ident="unity.L9_MBIT" value="MBI"></entryvalue>
	<entryvalue ident="unity.L9_COMP" value="COM"></entryvalue>
	<entryvalue ident="unity.L9_XOR" value="XOR"></entryvalue>
	<entryvalue ident="unity.L9_BROT" value="BRO"></entryvalue>
	<!--group unity.Connection-->
	<entryvalue ident="unity.ConnectionIdentification" value="WIN-GU2DRMCAR4H"></entryvalue>
	<entryvalue ident="unity.ConnectionMode" value="1"></entryvalue>
	<!--group unity.OperatorScreens-->
	<!--group unity.OSGrid-->
	<entryvalue ident="unity.Grid" value="0"></entryvalue>
	<entryvalue ident="unity.Step" value="20"></entryvalue>
	<entryvalue ident="unity.SnapToGrid" value="0"></entryvalue>
	<!--group unity.OSEdit-->
	<entryvalue ident="unity.MousePos" value="1"></entryvalue>
	<entryvalue ident="unity.VScrollBar" value="1"></entryvalue>
	<entryvalue ident="unity.HScrollBar" value="1"></entryvalue>
	<!--group unity.OSOnLineMode-->
	<entryvalue ident="unity.EditConnect" value="1"></entryvalue>
	<entryvalue ident="unity.EnableSel" value="1"></entryvalue>
	<!--group unity.OSDefaultScreenSize-->
	<entryvalue ident="unity.cxScreen" value="1280"></entryvalue>
	<entryvalue ident="unity.cyScreen" value="1024"></entryvalue>
	<!--group unity.OSScreenOpening-->
	<entryvalue ident="unity.MultiInstance" value="1"></entryvalue>
	<!--group converters.ConversionOptions-->
	<entryvalue ident="converters.SplitSections" value="1"></entryvalue>
	<entryvalue ident="converters.NetworksToSections" value="30"></entryvalue>
	<entryvalue ident="converters.SepIgnoreJumps" value="0"></entryvalue>
	<entryvalue ident="converters.SymToTopo" value="0"></entryvalue>
	<entryvalue ident="converters.FlatAddressesOnly" value="0"></entryvalue>
	<!--group converters.PL7-->
	<entryvalue ident="converters.TRANSITION_OPTIMIZATION" value="0"></entryvalue>
	<entryvalue ident="converters.STEP_STATE_EXPLICIT_DEFINITION" value="0"></entryvalue>
	<entryvalue ident="converters.SYMBOL_AS_STEP_NAME" value="0"></entryvalue>
	<!--group converters.Concept-->
	<entryvalue ident="converters.VarsAtEmptyPins" value="0"></entryvalue>
	<entryvalue ident="converters.DisAssignementCheck" value="1"></entryvalue>
	<entryvalue ident="converters.GenericEF" value="0"></entryvalue>
	<entryvalue ident="converters.LDNetworkDistance" value="0"></entryvalue>
	<entryvalue ident="converters.TxSubstProc" value="0"></entryvalue>
	<entryvalue ident="converters.SubsQDMF" value="0"></entryvalue>
	<entryvalue ident="converters.CriticalLDGraphDepth" value="43"></entryvalue>
</options>
)
NewXML:=New XML("xml")
NewXML.XML.LoadXML(xmlcontents)
UnityPath:=NewXML.SSN("//*[@ident='" attribute "']/@value").text
MsgBox,%UnityPath%