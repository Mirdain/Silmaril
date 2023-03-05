# Silmaril
FFXI Multi-Boxer Tool

Video tutorial on how to install: https://youtu.be/n7nDTAw_tjQ

Discord Server - https://discord.gg/xzRFAMtFKt

Steps to use -

Step 1: Download the two files (Silmaril.exe and Silmaril-Addon.zip) from the release section

https://github.com/Mirdain/Silmaril/releases

Step 2: Remove MOTW (mark-of-the-web) by right clicking on the two files and going to properties (bottom right "Unblock").

Step 3: Unzip the folder Silmaril-Addon.zip.

Step 5: Place the Silmaril *Folder* under the windower addons 
(Should look like *\Windower\addons\Silmaril\Silmaril.lua).

Step 6: Add the following line to the auto load in windower 
(init.txt located at *\Windower\scripts).

lua l Silmaril

Step 7: Place the Silmaril.exe where you would like and launch!

*Note: If the program does not runs check that you have 6.0 .NET or higher installed.  It can be downloaded from microsoft at https://dotnet.microsoft.com/en-us/download

In game commands

//sm stop - stops Silmaril from windower
//sm start - starts Silmaril from windower
//sm follow off|on - turns on/off the movement from Silmaril
//sm debug - Displays in game messages to help trouble shoot
//sm load WHM_SCH_TOON - Loads a file in the same folder as Silmaril  
//sm load Modes_AoE_WHM_RDM_TOON - Folders beneath Silmaril (Modes/AoE)
//sm info - Toggles the in game info such a skillchains for bursting
//sm display - turns off/on the display for when Silmaril is running "Silmaril [\]"
//sm save - saves the settings per chracter
