SCRIPTS_PATH := "D:\AutoHotkey_Scripts\menu"


PrintScreen::
	Gui, Add, Text,, %SCRIPTS_PATH%
	Gui, Add, ListView, r20 w700 gMyListView, Script|Path

	Loop, %SCRIPTS_PATH%\*.*
		LV_Add("", A_LoopFileName, A_LoopFileFullPath)

	LV_ModifyCol()
	Gui, Show
	return

return

MyListView:
if (A_GuiEvent = "DoubleClick") {
	LV_GetText(filePath, A_EventInfo, 2)
	Run %filePath%
}
return


;GuiClose:
;ExitApp