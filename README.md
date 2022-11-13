# SteamDeckPostInstallScript

## About
This repository contains the script, packages and configs I use to automate the WindowsOnDeck installation guide.

This is an inspiration from the guide [here.](https://github.com/baldsealion/Steamdeck-Ultimate-Windows11-Guide) This script installs the needed apps and configuration settings for WindowsOnDeck - except the Equalizer and Peace GUI. I dont use this 2 apps so I didnt added them to the script.

It also does not install the Valve drivers due to the size of the package. Grab them from the [official Steam Deck website](https://help.steampowered.com/en/faqs/view/6121-ECCD-D643-BAA8) and install them.

## What Does the Script Does and What Does it Install?
1. Sets steamdeck:deck for autologin (optional, disabled by default)
2. Configures unbranded boot (optional, disabled by default)
3. Disables hibernate and disables password prompt from wakeup when plugged in or when running in battery
4. Imports and sets active the SteamDeck power profile. If you dont want this power profile you can go back to the Default Balanced Profile
5. Sets the computername to steamdeck512g (you can change this to whatever you want)
6. Sets the pagefile to 4GB (you can change this to whatever you want)
7. Sets time zone to Eastern Time Zone
8. Disables XBOX gamebar DVR to prevent pop-up warning when using SWICD
9. Installs Visual C++ runtime, DirectX Runtime, SWICD, Tetherscript, VIGEM, HIDHIDE, RTSS, Winrar, HWINFO, ryzenadj, nircmd
10. Sets scheduled tasks for HWINFO, RTSS and Checkmate_hotkeys

## Pre-requisites - What is needed for this to run correctly?
1. Make sure you are connected to the Internet before running this script or else the HIDHide install will fail.
2. Script needs to run with admin rights. Right-click the script and select RunAs Administrator.

## How to Use the Script
1. Download and extract the zip archive to a common folder (example c:\temp).
2. Right-click the filename called SteamDeckPostInstallScript.bat and select RunAs Administrator.
3. Wait until the script finishes and it will reboot automatically to apply the changes.
4. There is one thing that needs manual intervetion. When the install for Tetherscript pops-up, press the Install button.
5. 
### Screenshot for reference
![tetherscript](https://user-images.githubusercontent.com/98122529/201535455-2895bf32-7a98-4acc-b4b1-e7512d543154.png)

This automates almost all the manual tasks needed, including RTSS and HWINFO configuration for OnScreen Display.
The RTSS OSD will have a horizontal layout for less clutter similar to SteamOS 3.4

### Screenshot for reference
![image](https://user-images.githubusercontent.com/98122529/201536541-5374331c-e4de-4da0-9169-f8e21e243c3f.png)


## OPTIONAL ITEMS
If you want to use autologin and unbranded boot, then edit the script and look at the heading called define variables.

Edit the localname and localpassword accordingly. Then uncomment the lines and run the script again.

### Screenshot for reference
![image](https://user-images.githubusercontent.com/98122529/201535353-180887a5-09d9-4ee5-9926-d38993af9758.png)

