# SteamDeckPostInstallScript

## About
This repository contains the script, packages and configs I use to automate the WindowsOnDeck installation guide.

This is an inspiration from the guide [here.](https://github.com/baldsealion/Steamdeck-Ultimate-Windows11-Guide) This script installs the needed apps and configuration settings for WindowsOnDeck - except the Equalizer and Peace GUI.

It also does not install the Valve drivers, grab them from the [official Steam Deck website](https://help.steampowered.com/en/faqs/view/6121-ECCD-D643-BAA8) and install them.

## What Does the Script Does and What Does it Install?


## Pre-requisites - What is needed for this to run correctly?
1. Make sure you are connected to the Internet before running this script or else the HIDHide install will fail.
2. Script needs to run with admin rights. Right-click the script and select RunAs Administrator.

## How to Use the Script
1. Download and extract the zip archive to a common folder (example c:\temp).
2. Right-click the filename called SteamDeckPostInstallScript.bat and select RunAs Administrator.
3. Wait until the script finishes and it will reboot automatically to apply the changes.
4. There is one thing that needs manual intervetion. When the install for Tetherscript pops-up, press the Install button.
### Screenshot for reference
![tetherscript](https://user-images.githubusercontent.com/98122529/201535455-2895bf32-7a98-4acc-b4b1-e7512d543154.png)


## OPTIONAL ITEMS
If you want to use autologin and unbranded boot, then edit the script and look at the heading called define variables.

Edit the localname and localpassword accordingly. Then uncomment the lines and run the script again.

### Screenshot for reference
![image](https://user-images.githubusercontent.com/98122529/201535353-180887a5-09d9-4ee5-9926-d38993af9758.png)

