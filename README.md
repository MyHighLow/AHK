# Autohotkey Network Utilites and Script Manager

## Menu Items
### network_info.ahk
This AHK script is intended to be launched from the ahk_menu, but can be run manually as well. Displays network info that would be useful for hosting SSH connections, such as interface names, IP Adresses, Subnet Prefixes, and Default Gateways. This is intended to give a more simplified view of network information than ipconfig gives by default.

### Remote_Manager.ahk
This is the main script that this system is built around. The remote manager script launches an interactive window that allows you to:
- Activate, deactivate, enable, disable, and check status of the SSH service
- Activate, deactivate, and check the status of the RDP service
- Enable, disable, and check the status of the RDP firewall bypass rule
## Directories

### deliberate/
Stores AHK scripts that are intended to be launched manually.

### helpers/
Stores powershell scripts that are utilized by autohotkey scripts to simplify more complex functions

### menu/
Stores AHK scripts. Scripts in menu/ will be automatically detected and displayed by deliberate/ahk_menu.ahk

