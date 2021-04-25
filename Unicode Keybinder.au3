#RequireAdmin
#NoTrayIcon
Global Const $version = "1.2.4"
If WinExists("Unicode Keybinder v"&$version) Then
	MsgBox(48,"Error", "Unicode Keybinder is already running!")
	Exit
EndIf
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=keybind.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=Unicode Keybinder
#AutoIt3Wrapper_Res_Fileversion=1.2.4.0
#AutoIt3Wrapper_Res_LegalCopyright=applusplus
#AutoIt3Wrapper_Res_Language=1031
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <Misc.au3>
#Include <String.au3>
#include <Constants.au3>

FileInstall(".\record_started.wav", @TempDir & "\record_started.wav", 1)
FileInstall(".\record_stopped.wav", @TempDir & "\record_stopped.wav", 1)
FileInstall(".\record_deleted.wav", @TempDir & "\record_deleted.wav", 1)

Global $Input[10], $Enter[10][2]
Opt("GUIOnEventMode", 1)
Opt("TrayMenuMode",1)
Opt("TrayOnEventMode",1)

$Form1 = GUICreate("Unicode Keybinder v"&$version&" :: by applusplus", 345, 358, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
$Input[0] = GUICtrlCreateInput("", 120, 24, 160, 21)
$Input[1] = GUICtrlCreateInput("", 120, 56, 160, 21)
$Input[2] = GUICtrlCreateInput("", 120, 86, 160, 21)
$Input[3] = GUICtrlCreateInput("", 120, 114, 160, 21)
$Input[4] = GUICtrlCreateInput("", 120, 144, 160, 21)
$Input[5] = GUICtrlCreateInput("", 120, 174, 160, 21)
$Input[6] = GUICtrlCreateInput("", 120, 204, 160, 21)
$Input[7] = GUICtrlCreateInput("", 120, 232, 160, 21)
$Input[8] = GUICtrlCreateInput("", 120, 260, 160, 21)
$Input[9] = GUICtrlCreateInput("", 120, 290, 160, 21)
$Label1 = GUICtrlCreateLabel("Numpad 0:", 15, 28, 56, 17)
$Enter[0][0] = GUICtrlCreateCheckbox("Enter", 70, 26, 47, 17)
$Enter[0][1]= GUICtrlCreateCheckbox("Enter", 290, 26, 45, 17)
$Label2 = GUICtrlCreateLabel("Numpad 1:", 15, 60, 56, 17)
$Enter[1][0] = GUICtrlCreateCheckbox("Enter", 70, 58, 47, 17)
$Enter[1][1] = GUICtrlCreateCheckbox("Enter", 290, 58, 45, 17)
$Label3 = GUICtrlCreateLabel("Numpad 2:", 15, 90, 56, 17)
$Enter[2][0] = GUICtrlCreateCheckbox("Enter", 70, 88, 47, 17)
$Enter[2][1] = GUICtrlCreateCheckbox("Enter", 290, 88, 45, 17)
$Label4 = GUICtrlCreateLabel("Numpad 3:", 15, 118, 56, 17)
$Enter[3][0] = GUICtrlCreateCheckbox("Enter", 70, 116, 47, 17)
$Enter[3][1] = GUICtrlCreateCheckbox("Enter", 290, 116, 45, 17)
$Label5 = GUICtrlCreateLabel("Numpad 4:", 15, 148, 56, 17)
$Enter[4][0] = GUICtrlCreateCheckbox("Enter", 70, 146, 47, 17)
$Enter[4][1]= GUICtrlCreateCheckbox("Enter", 290, 148, 45, 17)
$Label6 = GUICtrlCreateLabel("Numpad 5:", 15, 178, 56, 17)
$Enter[5][0] = GUICtrlCreateCheckbox("Enter", 70, 176, 47, 17)
$Enter[5][1] = GUICtrlCreateCheckbox("Enter", 290, 176, 45, 17)
$Label7 = GUICtrlCreateLabel("Numpad 6:", 15, 208, 56, 17)
$Enter[6][0] = GUICtrlCreateCheckbox("Enter", 70, 206, 47, 17)
$Enter[6][1] = GUICtrlCreateCheckbox("Enter", 290, 206, 45, 17)
$Label8 = GUICtrlCreateLabel("Numpad 7:", 15, 236, 56, 17)
$Enter[7][0] = GUICtrlCreateCheckbox("Enter", 70, 234, 47, 17)
$Enter[7][1] = GUICtrlCreateCheckbox("Enter", 290, 234, 45, 17)
$Label9 = GUICtrlCreateLabel("Numpad 8:", 15, 264, 56, 17)
$Enter[8][0] = GUICtrlCreateCheckbox("Enter", 70, 262, 47, 17)
$Enter[8][1] = GUICtrlCreateCheckbox("Enter", 290, 262, 45, 17)
$Label10 = GUICtrlCreateLabel("Numpad 9:", 15, 294, 56, 17)
$Enter[9][0] = GUICtrlCreateCheckbox("Enter", 70, 292, 47, 17)
$Enter[9][1] = GUICtrlCreateCheckbox("Enter", 290, 292, 45, 17)
$Label1337 = GUICtrlCreateLabel("applusplus © 2011", 130, 332, 100, 23)
GUICtrlSetFont(-1, 9, 400, 0, "Ebrima")
GUICtrlSetColor(-1, 0x3399FF)
$savebox = GUICtrlCreateCheckbox("AutoSave on Exit", 16, 330, 97, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUISetState(@SW_SHOW)
;~ $test1 = 0x41+20
;~ MsgBox(0, "", Hex($test1) )
;~ MsgBox( 0, "", Hex(Asc('2')) )

If FileExists(@ScriptDir&"\UTFBinder.ini") = 1 Then
	Call("LoadCfg")
EndIf
$dll = DllOpen("user32.dll")

TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE,"maxGui")
If @error Then
	MsgBox(0,"Error","TraysetOnEvent")
EndIf

$logOn = False
While 1
;~ 	If _IsPressed("7B", $dll) Then
;~ 		While _IsPressed("7B", $dll) = 1
;~ 			Sleep(1)
;~ 		WEnd
;~ 		If $logOn = True Then
;~ 			SoundPlay(@TempDir & "\record_stopped.wav")
;~ 			$logOn = False
;~ 		Else
;~ 			SoundPlay(@TempDir & "\record_started.wav")
;~ 			$logOn = True
;~ 		EndIf
;~ 	ElseIf _IsPressed("7A", $dll) Then
;~ 		SoundPlay(@TempDir & "\record_deleted.wav")
;~ 		GUICtrlSetData($Input[9], "")
;~ 	EndIf
;~ 	If $logOn = True Then
;~ 		_logText()
;~ 	Else
		If keyState() = 1 Then
			Sleep(500)
		EndIf
;~ 	EndIf
	Sleep(10)
WEnd

Func keyState()
	For $i = 60  To 69 Step +1
		If _IsPressed($i, $dll) Then ;_IsPressed($i, $dll)
			While _IsPressed($i, $dll) = 1
				Sleep(1)
			WEnd
			BlockInput(1)
			Call("sendFunc", $i)
			BlockInput(0)
			Return 1
		EndIf
	Next
EndFunc

Func sendFunc($i)
	$i -= 60
	Send("{BACKSPACE}")
	If GUICtrlRead($Enter[$i][0]) = $GUI_CHECKED Then
		Send("{enter}")
	EndIf
	Sleep(100)
	;ControlSend("", "", "", GUICtrlRead($Input[$i]), 1)
	Send(GUICtrlRead($Input[$i]),1)
	Sleep(100)
	If GUICtrlRead($Enter[$i][1]) = $GUI_CHECKED Then
		Send("{enter}")
	EndIf
EndFunc

Func _logText()
	;Leertaste
	$j = "20"
	If _IsPressed($j, $dll) Then
		While _IsPressed($j, $dll)
			Sleep(1)
		WEnd
		_logToString($j)
		Return 1
	EndIf
	;Enter
	$y = "0D"
	If _IsPressed($y, $dll) Then
		While _IsPressed($y, $dll)
			Sleep(1)
		WEnd
		_logToString($y)
		Return 1
	EndIf
	;Backspace
	$g = "08"
	If _IsPressed($g, $dll) Then
		While _IsPressed($g, $dll)
			Sleep(1)
		WEnd
		_logToString($g)
		Return 1
	EndIf
	; 0 - 9
	For $i = 48 To 57 Step +1   ;0x30 To 0x39 in Dec
		$key = Hex($i)
		If _IsPressed($key, $dll) Then
			If _IsPressed("10", $dll) Or _IsPressed("14", $dll) Then
				$key -= 10
			EndIf
			While  _IsPressed($key, $dll)
				Sleep(1)
			WEnd
			_logToString($key)
			Return 1
		EndIf
	Next
	; A - Z
	For $i = 65 To 90 Step +1	;0x41 To 0x5A in Dec
		$lLower = True
		$key = Hex($i)
		If _IsPressed($key, $dll) Then
			If _IsPressed("10", $dll) Or _IsPressed("14", $dll) Then
				$lLower = False
			Else
				$lLower = True
			EndIf
			While  _IsPressed($key, $dll)
				Sleep(1)
			WEnd
			_logToString($key, $lLower)
			Return 1
		EndIf
	Next
	; Operatoren + - */ etc
;~ 	For $i = 0x6A To 0x6F Step +1
;~ 		If _IsPressed($i, $dll) Then
;~ 			While  _IsPressed($i, $dll)
;~ 				Sleep(1)
;~ 			WEnd
;~ 			_logToString($i)
;~ 			Return 1
;~ 		EndIf
;~ 	Next
EndFunc

Func _logToString($cHex, $lLower = True)
	$nineInput = GUICtrlRead($Input[9])
	If $cHex = "20" Then
		$nineInput &= " "
	ElseIf $cHex = "0D" Then
		$nineInput &= "{ENTER}"
	ElseIf $cHex = "08" Then
		$nineInput = StringTrimRight($nineInput, 1)
	ElseIf $lLower = True Then
		$nineInput &= StringLower(Chr(Dec($cHex)))
	ElseIf $lLower = False Then
		$nineInput &= Chr(Dec($cHex))
	EndIf
	GUICtrlSetData($Input[9], $nineInput)
EndFunc

Func SaveCfg()
	$oFile = FileOpen(@ScriptDir&"\UTFBinder.ini", 2+8+32) ;Unicode kodierte ini erstellen
	FileClose($oFile)
	;Enter vor und nach dem Text
	For $j = 0 To 9 Step +1
		IniWrite(@ScriptDir&"\UTFBinder.ini", "Settings", "Enter"&$j+1&"a", GUICtrlRead($Enter[$j][0]))
		IniWrite(@ScriptDir&"\UTFBinder.ini", "Settings", "Enter"&$j+1&"b", GUICtrlRead($Enter[$j][1]))
	Next
	;Der Text selbst
	For $i = 0 To 9 Step +1
		IniWrite(@ScriptDir&"\UTFBinder.ini", "Settings", "InputBox"&$i+1, GUICtrlRead($Input[$i])&"|")
	Next
EndFunc

Func LoadCfg()
$readsave = IniRead(@ScriptDir&"\UTFBinder.ini", "AutoSave", "AutoSave", 0)
$readsave = StringTrimRight($readsave,1)
If $readsave = 1 Then
	GUICtrlSetState($savebox, $GUI_CHECKED)
	For $j = 0 To 9 Step +1
		$readvar = IniRead(@ScriptDir&"\UTFBinder.ini", "Settings", "Enter"&$j+1&"a", 4)
		GUICtrlSetState($Enter[$j][0], $readvar)
		$readvar = IniRead(@ScriptDir&"\UTFBinder.ini", "Settings", "Enter"&$j+1&"b", 4)
		GUICtrlSetState($Enter[$j][1], $readvar)
	Next
	For $i = 0 To 9 Step +1
		$readvar = IniRead(@ScriptDir&"\UTFBinder.ini", "Settings", "InputBox"&$i+1, "")
		$readvar = StringTrimRight($readvar,1)
		GUICtrlSetData($Input[$i], $readvar)
	Next
Else
	GUICtrlSetState($savebox, $GUI_UNCHECKED)
EndIf
EndFunc

Func SpecialEvents()
    Select
        Case @GUI_CtrlId = $GUI_EVENT_CLOSE
            DllClose($dll)
			If GUICtrlRead($savebox) = $GUI_CHECKED Then
				Call("SaveCfg")
				IniWrite(@ScriptDir&"\UTFBinder.ini", "AutoSave", "AutoSave", 1&"|")
;~ 			Else
;~ 				IniWrite(@ScriptDir&"\UTFBinder.ini", "AutoSave", "AutoSave", 0&"|")
			EndIf
			FileDelete(@TempDir & "\record_started.wav")
			FileDelete(@TempDir & "\record_stopped.wav")
			FileDelete(@TempDir & "\record_deleted.wav")

			Exit

        Case @GUI_CtrlId = $GUI_EVENT_MINIMIZE
			GUISetState(@SW_HIDE, $Form1)
			Opt("TrayIconHide", 0)
			TrayTip("I am here now!", "Restore me with a doubleclick", 5)

        Case @GUI_CtrlId = $GUI_EVENT_RESTORE

    EndSelect
EndFunc

Func maxGui()
	$ergui = GUISetState(@SW_SHOW, $Form1)
	If $ergui = 0 Then
		MsgBox(0,"Error","Restore Error")
	EndIf
	Opt("TrayIconHide", 1)
EndFunc