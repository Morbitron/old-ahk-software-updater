#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Include XML.ahk


;               | Root Element XML files can have only 1 root element, this creates that.
; |        | Optional Path/Filename if you want to use an xml file outside of the scripts directory
; |        |
MyXML:=new XML("RootElement","lib\MyXML.xml") ;Creates or Loads the XML if the file exists
;| Stored object into the name Node
;|           | Path of the new Element you wish to create
;|           | | Associative Array of Attributes that you want to be in the new element
;|           | | | A text string that is appended to <node>HERE!</node> but be careful
;|           | | | If you want to have nodes below this current node do not give it a text value
;|           | | |    | Duplicate, This allows for the same named Element to be at the same level 1=Allow Duplicate
;|           | | |    |
Node:=MyXML.Add("My/New/Path",{Attribute:"Value",Another:"Attribute"},"Text Value",0) ;Create a new Node Element
loop, 5
 Node:=MyXML.Add("My/New/Path",{Attribute:"Value",index:A_Index,Another:"Attribute"},"hello" A_Index+10,1) ;Create a new Node Element
 
Top:=MyXML.Add("Just_A_Node") ;Create a node on its own
 
 
;            | The node object that you created previously
;            | | The name for the new node
;            | | | Like above an Associative Array for the Attributes
;            | | | | Text Value for the Node
;            | | | |
MyXML.Under(Top,"Node_Name",{Attribute:"Value"},"Text Value")
 
MyXML.Transform() ;Makes the XML Pretty
MyXML.Transform() ;Sometimes needed.
 
;~list:=MyXML.SN("//Path") ;Select NODES: build list which has all nodes with the nodename of Path  ;// means look everywhere
;~node:=myxml.SSN("//My/New")
;~list:=SN(node,"Path")
;~while(item:=list.item[a_index-1],obj:=xml.EA(item))
;~m(item.xml,obj.Attribute,obj.index)
;~m(MyXML.SSN("//My/New").xml)
;~m(SSN(Top,"Node_Name").xml) ;first item is ahk object.  then pass what we want from that object
;~m(SSN(Top,"Node_Name").xml) ;first item is ahk object.  then pass what we want from that object
 
;      @=Attribute
;~m(MyXML.SSN("//Path[@index='4']").xml) ;//Path gets first.  If want multiple ones (and want specific one) use brackets and @index
;~m(MyXML.SSN("//Path[text()='15']").xml) ;//Path gets first.  If want multiple ones (and want specific one) use brackets and @index
;                   text() =looking for exact text values
;~m(MyXml.SSN("//Path[contains(text(),'lo11')]").xml)
;                   does matching across all path nodes thtat contain text value
                    ;~swap contains(text(),'lol1')  to contains(@Attribute,'" variable "') ;use inside double outside single quotes to pass variable
 
 
 
m(MyXML[]) ;Shows a MsgBox with the contents of the new node
;          1 is to "Make the XML pretty"
MyXML.Save(1) ;Saves the xml
ExitApp