#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;Create standard method/class to access functions and description



/*
Gui,Add,Edit,w800 h500 -Wrap,%page% ;Create an Edit control
Gui,show ;Show the GUI window
*/

class ClassName ;extends BaseClassName
{
    InstanceVar := Expression
    static ClassVar := Expression

    class NestedClass
    {
        ;...
    }

    Method()
    {
        ;...
    }

    Property[]  ; Brackets are optional
    {
        get {
            return ;...
        }
        set {
            return ;... := value
        }
    }
}