; Steven de Brouwer - 06-nov-2016: made a minimal application around KillCopy
; 
; Steph - 09/03/2005  <-- minimal application
; joshwhitk - 2015    <-- suppress-property-loss-dialog-during-copy-in-Windows-Explorer

Opt("MustDeclareVars", 1)   ; Require that variables are declared (Dim) before use
Opt("TrayMenuMode",1)       ; No pause or exit item
TraySetClick(16)            ; only right (secondary) click will show the tray menu

#include <GuiConstants.au3>
Const $TRAY_EVENT_PRIMARYDOUBLE =   -13

Global $gui_Main
Global $bt_main_Hide, $bt_main_Exit
Global $mn_tray_Exit, $mn_tray_show

Dim $msg, $traymsg

CreateGui()
CreateTray()

Do
    $msg = GUIGetMsg()
    $traymsg = TrayGetMsg()
    Select
        Case $msg = $bt_main_Hide
            GUISetState(@SW_HIDE, $gui_main)
        Case $traymsg = $TRAY_EVENT_PRIMARYDOUBLE or $traymsg = $mn_tray_Show
            GUISetState(@SW_SHOW, $gui_main)
    EndSelect
	KillCopy()
Until $msg = $GUI_EVENT_CLOSE Or $msg=$bt_main_Exit Or $traymsg = $mn_tray_Exit
Exit

Func CreateGui()
	; Feel free to add other stuff, like 'about' or input-field: 'title of window'
    $gui_Main               = GuiCreate("Hide to tray demo", 405, 280, -1, -1, $WS_EX_DLGMODALFRAME )
    $bt_main_Hide           = GUICtrlCreateButton("Hide", 280, 195, 110, 20)
    $bt_main_Exit           = GUICtrlCreateButton("Exit", 280, 220, 110, 20)
EndFunc

Func CreateTray()
	; Tray exists of only menu-items
    $mn_tray_show           = TrayCreateItem("Show")
    $mn_tray_Exit           = TrayCreateItem("Exit")
EndFunc

;*********************************************************************
Func KillCopy()
   ; Title was originally: 'Property Loss'
   If WinExists("1 Interrupted Action") Then
	  WinActivate("1 Interrupted Action")  ;the windows explorer dialog we are targeting always has this exact text as its title
	  Send("!a") ;for "do this for all"
	  send("!y") ;for alt-y, yes
   EndIf
EndFunc
