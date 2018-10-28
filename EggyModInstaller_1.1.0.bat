@echo off
set ln=------------------------------------------
set version=1.1.0
set letter=Please press the corresponding letter to choose your Installation.
set letter2=Please make sure that you are launching the correct Minecraft version for each mod. 
set letter3=Remember to remove all mods that are not compatible with the MC version you are using.
title Eggy Mod Installer 1.1.0

:UPDATECHECK
cls
echo Checking for updates and old versions to clean up...
if exist latest.txt del latest.txt
if exist EggyModInstaller_1.0.0.bat set changelog=1 && del EggyModInstaller_1.0.0.bat
if exist EggyModInstaller_1.0.1.bat set changelog=1 && del EggyModInstaller_1.0.1.bat
if exist EggyModInstaller_1.0.2.bat set changelog=1 && del EggyModInstaller_1.0.2.bat
if "%changelog%" NEQ "1" goto updaterdownload

:CHANGELOG
echo %ln%
echo Changelog
echo %ln%
echo.
echo You may have realised that your Installer has just updated!
echo In this update, the following changes were made:
echo.
echo - Added Old version cleanup
echo - Changed formatting for menu
echo - Fixed critical bug that prevented updating
echo - Fixed newer versions downgrading to older ones
echo - Added checking for .minecraft directory
echo - Removed some BS Code in the system
echo 	- Removed previous mod version checking compatibility
echo 		- Doesn't work
echo 		- Not necessary
echo - Removed the Cookie Monster

:UPDATERDOWNLOAD
bitsadmin.exe /transfer "Downloading Updater..." https://raw.githubusercontent.com/potatoeggy/installers/master/latest.txt "%cd%\latest.txt">nul
(
set /p latest=%latest%
)<latest.txt
if "%latest%" LEQ "%version%" (goto noupdate) else (goto update)

:UPDATE
echo Update found. Updating to version %latest%...
pause
echo Preparing file for update...
if "%~dpnx0" NEQ "EggyModInstaller_1.1.0.bat" (goto ren) else (goto contupdate)

:REN
echo File unprepared. File corruption detected. Repairing...
echo You may need to reboot this program manually.
ren "%~dpnx0" "EggyModInstaller_1.1.0.bat"
goto contupdate

:CONTUPDATE
echo Ready to recieve update. Updating...
bitsadmin.exe /transfer "Downloading Update..." https://raw.githubusercontent.com/potatoeggy/installers/master/EggyModInstaller_%latest% "%cd%\EggyModInstaller_%latest%.bat">nul
echo Update complete. Rebooting...
if exist latest.txt del latest.txt
start "" "EggyModInstaller_%latest%"

:NOUPDATE
echo No update found.
if exist latest.txt del latest.txt
pause
goto menu

:MENU
cls
if not exist "%APPDATA%\.minecraft" goto nominecraft
echo %ln%
echo Eggy Mod Installer
echo %ln%
echo %letter%
echo %letter2%
echo %letter3%
echo.
echo A) Lucky Block Series 
echo B) MorePies Mod Testing
echo C) MoreDirtMod Mod Testing
echo D) Minecraft Forge (Not yet supported)
echo E) Minecraft (Not yet supported)
choice /c ABC >nul

if %errorlevel%==1 goto luckypassword
if %errorlevel%==2 goto morepies
if %errorlevel%==3 goto moredirtmod

:LUCKYPASSWORD
cls
echo Lucky Blocks have not been setup yet. Wait for an update!
pause
goto end

:MOREPIES
echo Checking for old versions...

:MOREPIESINSTALL
if not exist "%APPDATA%\.minecraft\Mods" mkdir "%APPDATA%\.minecraft\Mods"
echo Downloading MorePies 1.0.1 for Minecraft 1.10.2 (MorePies-1.10.2-1.0.1-universal.jar)
bitsadmin.exe /transfer "Downloading MorePies..." https://raw.githubusercontent.com/potatoeggy/installers/master/MorePies-1.10.2-1.0.1-universal.jar "%appdata%\.minecraft\Mods\MorePies-1.10.2-1.0.1-universal.jar">nul
echo Download Complete. Enjoy the mod! Contact Eggy for recipes and details.
pause
goto end

:MOREDIRTMOD
echo Checking for old versions...

:MOREDIRTINSTALL
if not exist "%APPDATA%\.minecraft\Mods" mkdir "%APPDATA%\.minecraft\Mods"
echo Downloading MoreDirtMod BETA 1.0.0 for Minecraft 1.10.2 (MoreDirtMod-1.10.2-b1.0.0-universal.jar)
bitsadmin.exe /transfer "Downloading MoreDirtMod..." https://raw.githubusercontent.com/potatoeggy/installers/master/MoreDirtMod-1.10.2-b1.0.0-universal.jar "%appdata%\.minecraft\Mods\MoreDirtMod-1.10.2-b1.0.0-universal.jar">nul
echo Download Complete. Enjoy the mod! Contact Eggy for recipes and details.
pause
goto end

:NOMINECRAFT
echo Minecraft does not seem to be installed on your PC. 
echo Please install Minecraft, or run this batch file from another one,
echo with the following text inside:
echo.
echo @echo off
echo set APPDATA=insert where you want appdata to be (i.e.:C:\Potato)
echo start EggyModInstaller_1.0.2.bat
pause
goto end

:END
exit /b
