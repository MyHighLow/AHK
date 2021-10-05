; Start-Service sshd
; Stop-Service sshd

; Get-Service sshd
; Get-Service -Name sshd | Select-Object -Property *
; Get-Service -Name sshd | Select-Object -Property StartType

; Set-Service -Name sshd -StartupType 'Automatic'
; Set-Service -Name sshd -StartupType 'Manual'

; get rdp status
; reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections

; ENABLE rdp
; reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

; DISABLE rdp
; reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f

; ENABLE rdp firewall passthrough
; Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

; DISABLE rdp firewall passthrough
; Disable-NetFirewallRule -DisplayGroup "Remote Desktop"

; get status of rdp firewall passthrough
; Get-NetFirewallRule -DisplayGroup "Remote Desktop"
; Get-NetFirewallRule -DisplayGroup "Remote Desktop" | sed -E "/(^Name|^Enabled)/!d"

; Reopen as admin https://www.autohotkey.com/docs/commands/Run.htm#RunAs
if not (A_IsAdmin) {
	try {
		Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
	}
	ExitApp
}

Gui, New, , Remote Manager
	Gui, Add, GroupBox, xm ym w250 h200, SSHD
		Gui, Add, GroupBox, xm+10 yp+20 w230 h65, Service
			Gui, Add, Button, section xp+10 yp+20 w100 h30 gActivateSSHD, Activate
			Gui, Add, Button, x+10 w100 h30 gDeactivateSSHD, Deactivate
		Gui, Add, GroupBox, xm+10 y+20 w230 h65, Startup
			Gui, Add, Button, xs yp+20 w100 h30 gEnableSSHD, Enable
			Gui, Add, Button, x+10 w100 h30 gDisableSSHD, Disable
		Gui, Add, Button, xm+75 y+20 w100 h30 gStatusSSHD, Status
	Gui, Add, GroupBox, xm y+20 w250 h245, RDP
		Gui, Add, GroupBox, xm+10 yp+20 w230 h100, Service
			Gui, Add, Button, xp+10 yp+20 w100 h30 gActivateRDP, Activate
			Gui, Add, Button, x+10 w100 h30 gDeactivateRDP, Deactivate
			Gui, Add, Button, xm+75 y+10 w100 h30 gStatusRDP, Status
		Gui, Add, GroupBox, xm+10 yp+50 w230 h100, Firewall Bypass
			Gui, Add, Button, xp+10 yp+20 w100 h30 gEnableFirewallRuleRDP, Enable
			Gui, Add, Button, x+10 w100 h30 gDisableFirewallRuleRDP, Disable
			Gui, Add, Button, xm+75 y+10 w100 h30 gStatusFirewallRuleRDP, Status

Gui, Show
Return

ActivateSSHD:
Run, PowerShell.exe -Command Start-Service sshd
Return

DeactivateSSHD:
Run, PowerShell.exe -Command Stop-Service sshd
Return

EnableSSHD:
Run, PowerShell.exe -Command Set-Service -Name sshd -StartupType 'Automatic'
Return

DisableSSHD:
Run, PowerShell.exe -Command Set-Service -Name sshd -StartupType 'Manual'
Return

StatusSSHD:
RunWait, PowerShell.exe -noexit -Command D:/AutoHotkey_Scripts/helpers/Get_SSHD_Status.ps1
Return

ActivateRDP:
Run, PowerShell.exe -Command reg add \"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\" /v fDenyTSConnections /t REG_DWORD /d 0 /f
Return

DeactivateRDP:
Run, PowerShell.exe -Command reg add \"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\" /v fDenyTSConnections /t REG_DWORD /d 1 /f
Return

StatusRDP:
RunWait, PowerShell.exe -noexit -Command reg query \"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\" /v fDenyTSConnections
Return

EnableFirewallRuleRDP:
Run, PowerShell.exe -Command Enable-NetFirewallRule -DisplayGroup \"Remote Desktop\"
Return

DisableFirewallRuleRDP:
Run, PowerShell.exe -Command Disable-NetFirewallRule -DisplayGroup \"Remote Desktop\"
Return

StatusFirewallRuleRDP:
RunWait, PowerShell.exe -noexit -Command  Get-NetFirewallRule -DisplayGroup \"Remote Desktop\" | sed -E \"/(^Name|^Enabled)/!d\"
Return

GuiClose:
ExitApp
Return