@echo off
setlocal enableDelayedExpansion
::
::
:: SteamDeckPostInstallScript script by ryanrudolf.
:: This is an inspiration from the guide here - https://github.com/baldsealion/Steamdeck-Ultimate-Windows11-Guide
:: This script installs the needed apps and configuration settings for WindowsOnDeck - except the Equalizer and Peace GUI.
:: It does not install the Valve drivers, grab them from the official Steam Deck website and install them - 
:: https://help.steampowered.com/en/faqs/view/6121-ECCD-D643-BAA8
::
:: I still need to learn the autohotkey scripting. For now this utilizes Checkmate AHK scripts.
:: 
:: There are 2 prerequisites for this script to work correctly -
:: 1] Make sure you are connected to the Internet before running this script or else the HIDHide install will fail.
:: 2] Script needs to run with admin rights. Right-click the script and select RunAs Administrator.
::
:: There are portions in the script that are optional - autologin and unbranded boot. They are commented by default,
:: uncomment them if you want to use them. On my build I use autologin and unbranded boot to have a seamless video during bootup.
::
:: define variables here
:: change the localname and localpassword to match the local Windows account on your system
:: change the newcomputername and change the swapsize accordingly
set localname=steamdeck
set localpassword=deck
set newcomputername=steamdeck512g
set swapsize=4096
::
:: registry edit for autologin - localname:localpassword. uncomment this segment if you want to utilize autologin
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v AutoAdminLogon /t REG_SZ /d 1
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultUserName /t REG_SZ /d %localname%
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultPassword /t REG_SZ /d %localpassword%
::
:: registry edit for unbranded boot. uncomment this segment if you want to utilize unbranded boot
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Embedded\EmbeddedLogon" /f /v HideAutoLogonUI /t REG_DWORD /d 1
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Embedded\EmbeddedLogon" /f /v HideFirstLogonAnimation /t REG_DWORD /d 1
::reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Embedded\EmbeddedLogon" /f /v BrandingNeutral /t REG_DWORD /d 1
::bcdedit -set {globalsettings} bootuxdisabled on
::
:: disable hibernate, import and set power scheme, disable password prompt from sleep mode
powercfg /hibernate off
powercfg /import %~dp0packages\config\steamdeck.pow 11111111-aaaa-bbbb-cccc-111111111111
powercfg /setactive 11111111-aaaa-bbbb-cccc-111111111111
powercfg /setdcvalueindex scheme_current sub_none consolelock 0
powercfg /setacvalueindex scheme_current sub_none consolelock 0
::
:: set swap size
wmic computersystem set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%swapsize%,MaximumSize=%swapsize%
::
:: change computername
wmic computersystem where name="%computername%" call rename %newcomputername%
::
:: registry import for Time Settings and gamebar
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /f /v RealTimeIsUniversal /t REG_DWORD /d 1
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation" /f /v TimeZoneKeyName /t REG_SZ /d "Eastern Standard Time"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /f /v AppCaptureEnabled /t REG_DWORD /d 0
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /f /v GameDVR_Enabled /t REG_DWORD /d 0
::
::
:: *** software install begins here ***
::
::
:: perform a silent install - vc++, swicd, tetherscript, vigembus, hidhide, winrar directx
mkdir c:\tools
start "" /wait %~dp0packages\vcpp-aio.exe /y
start "" /wait %~dp0packages\swicd.exe /S
start "" /wait %~dp0packages\tether.exe /verysilent /norestart
start "" /wait %~dp0packages\vigembus.exe /qn /norestart
start "" /wait %~dp0packages\hidhide.exe /qn /norestart
start "" /wait %~dp0packages\RTSSSetup733 /S
start "" /wait %~dp0packages\winrar.exe /S
start "" /wait %~dp0packages\directx.exe /q /t:c:\tools\directx
start "" /wait c:\tools\directx\dxsetup.exe /silent
::
:: copy apps that doesnt have silent install to c:\tools - ryzenadj, hwinfo, checkmate_ahk, nircmd
xcopy %~dp0packages\ahk c:\tools\ahk /s /i /y
xcopy %~dp0packages\hwinfo64 c:\tools\hwinfo64 /s /i /y
xcopy %~dp0packages\ryzenadj c:\tools\ryzenadj /s /i /y
xcopy %~dp0packages\nircmd c:\tools\nircmd /s /i /y
::
::
:: *** software configuration begins here ***
::
::
:: hwinfo configuration
schtasks /create /tn HWINFO /xml %~dp0packages\config\HWiNFO.xml
::
:: ahk configuration. 5sec pause as the previous schtask command may not have completed yet
timeout /t 5 > nul
schtasks /create /tn AHK /xml %~dp0packages\config\AHK.xml
::
:: swicd configuraton
call "C:\Program Files (x86)\HID Virtual Device Kit Standard 2.1\Drivers Signed\Gamepad\uninstall.bat"
call "C:\Program Files (x86)\HID Virtual Device Kit Standard 2.1\Drivers Signed\Joystick\uninstall.bat"
mkdir %userprofile%\documents\swicd
copy /y %~dp0packages\config\app_config.json %userprofile%\documents\swicd\app_config.json
::
:: RTSS configuration
mkdir "C:\Program Files (x86)\RivaTuner Statistics Server\Profiles"
copy /y %~dp0packages\config\hwinfo64.ovl "C:\Program Files (x86)\RivaTuner Statistics Server\Plugins\Client\Overlays"
copy /y %~dp0packages\config\Config "C:\Program Files (x86)\RivaTuner Statistics Server\Profiles"
copy /y %~dp0packages\config\Global "C:\Program Files (x86)\RivaTuner Statistics Server\Profiles"
copy /y %~dp0packages\config\HotkeyHandler.cfg "C:\Program Files (x86)\RivaTuner Statistics Server\Plugins\Client"
copy /y %~dp0packages\config\OverlayEditor.cfg "C:\Program Files (x86)\RivaTuner Statistics Server\Plugins\Client"
schtasks /create /tn RTSS /xml %~dp0packages\config\RTSS.xml
::
:: hidhide configuration
%~dp0packages\hidhidecli.exe --app-reg "C:\Program Files (x86)\Steam\Steam.exe"
%~dp0packages\hidhidecli.exe --app-reg "C:\Program Files (x86)\Steam\Streaming_client.exe"
%~dp0packages\hidhidecli.exe --app-reg "C:\Program Files (x86)\Steam\GameOverlayUI.exe"
%~dp0packages\hidhidecli.exe --dev-hide "HID\VID_28DE&PID_1205&MI_02\8&3b15de89&0&0000"
%~dp0packages\hidhidecli.exe --inv-on
%~dp0packages\hidhidecli.exe --cloak-on
::
:: all done! reboot for changes to take effect
shutdown /r /c "Windows needs to restart to complete the installation . . ."