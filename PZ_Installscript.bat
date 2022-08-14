@echo off
setlocal enableextensions enabledelayedexpansion
:ResetScript
@cd /d "%~dp0"
::
::   || Project Zomboid Auto-Installer Config Settings:
::   || Do not change any lines starting with ::, only change text after '='symbol (Do not use ^,&,<,>,|,\,= characters)
::   || Make Sure this file PZ_Installscript.bat is placed inside the directory given below: 'ServerPath=<folder>\rcon' or it will fail.
::
::  //============================[ Custom Scritpt settings ]=============================================\\
::	Set to Yes if you want to use Zomboid RCON Admin Tool, set to NO if you don't want ot use it. If Yes it will auto download and install .NET Runtime 6.0.6 (https://github.com/kwmx/ZomboidRCON)
Set AdminTool=Yes
:: 	Set to Yes if you want to Auto Update the Server.ini file with below settings (Needed for AutoDownloadMods)
Set AutoUpdateConfig=Yes
:: 	Set to Yes if you want to open the Console log Folders Minimized when watchdog starts..
Set OpenFolders=No
:: 	Set to Yes if you want to autodownload mods, set to No if you want to handle Mod files yourself.
Set AutoDownloadMods=No
:: 	Annonymous logon is not allowed for downloading MODS -If no mods are used Login data is not required.
set SteamUser=
set SteamPassword=
::  \\====================================================================================================//
::
::  //============================[ Custom Server settings ]==============================================\\
::  <Servername.ini> These settings will be automatically configured and can later be changed
::  Set to 'false' for PVE / Set to 'true' for PVP Default=true
set PVP=false
::  Show up in Steam Public Server lists
set SteamPublic=true
::  serverport= Change this if you already have a server on the same network. Default=162621
set serverport=16261
::  servername=For Basic server name pick something small without spaces.
set servername=Terminus
::  fullservername=For Public server name in steam Host search pick anything but do not use ^,&,<,>,|,\,! characters!
set fullservername=Terminus - Public - TESTSERVER
::  PublicDesc=For Public Description of your server, make new line with \n 
set PublicDesc=This is Terminus server \n No lag \n PVP off
::  MaxPlayers=Set max amount of players that can logon Default=32
set MaxPlayers=8
::  ServerPath= Choose where to install the Project Zomboid Server?
set ServerPath=C:\Games\Terminus
::  ServerPass=Lock Server with password and make it not accessible to Public
set ServerPass=
::  Example: ModID=BedfordFalls;tsarslib;autotsartrailers;SkillTapes
Set ModID=tsarslib;autotsartrailers;SkillTapes
::  Example: Map=BedfordFalls;North;South;West;Muldraugh, KY
Set Maps=Muldraugh, KY
::  Example: WorkshopID=2392709985;2282429356;2702055974 (Script Max= 26 mods!)
Set WorkshopID=2392709985;2282429356;2702055974
::  reconport=Can leave default, used for sending remote commands. Default=27015
set reconport=27015
::  reconpass=Change this password!! 
set reconpass=rcon4321
::  SteamPort1=Can leave default, used for steam. Default=8766
set SteamPort1=8766
::  SteamPort2=Can leave default.Default=8767
set SteamPort2=8767
::  \\====================================================================================================//
::
::  //============================[ Custom Server settings ]==============================================\\
::  <StartServer64.bat> These settings will be automatically configured and can later be changed
::  MemorySize=you will need to multiply 500MB per player you have on your server, plus a base 2GB.Choose->2-4-8-16-32-64 for stability.
set MemorySize=4
::  \\====================================================================================================//
::
:: <- EDIT Above HERE
REM -------------------------------------------------------------------------------
REM -------------------------------------------------------------------------------
:: <- Do NOT edit below here
:: // Project Zomboid Server Configuration location(s). 
set ServerConfig=%userprofile%\Zomboid
set LogPath=%ServerPath%\logs
set WatchdogLoc=%ServerPath%\Watchdog
set rcontype=rcon
set PZModsLoc=%ServerConfig%\mods
set workspace=%ServerPath%\Dump
set workspace1=%ServerPath%\PZClient
:: // Steam Install Details
set steamlogin=anonymous
set SteamLoginFULL=%SteamUser% %SteamPassword%
set PZserverBRANCH=380870
set PZClientBRANCH=108600
set steampath=%ServerPath%\steamcmd
set WorkShopIDSteam=%WorkshopID:;= %
:: // Firewall Rules adjusting for 30 players
set /A Serverport1=%serverport%+30
::  Import IP address automatically or can remove '%ip:~1%' and input ip manually
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set serverip=%ip:~1%
:: // Counter for warnings
set counter=15
set counter1=15
set counter2=15
set counter3=15
set counter4=15
set counter5=15
:: // Configure Text color
set BaseColor=color 0F
:: Errors effects
Set ColorRed=color 0C
:: Downloads
set ColorBlue=color 09
:: Fixxed Errors
Set ColorGreen=color 0A
:: End of Script
Set ColorYellow=color 0E
:: // Configure Names for Project
set "spaces=                  "
set "STR[1]=^> PZ Installer"
set "STR[1A]= ActionList"
set "STR[1B]= Installer Details:"
set "STR[2]=^> Java Check"
set "STR[3]=^> Download Tools"
set "STR[4]=^> Prepare Rcon settings"
set "STR[5]=^> Add Firewall Rules"
set "STR[6]=^> Steam Installation"
set "STR[7]=^> Pre-Auto change config values"
set "STR[8]=^> Start Project Zomboid"
set "STR[9]=^> Close Project Zomboid"
set "STR[A1]=^> Post-Auto change config values"
set "STR[A2]=^> Create WelcomeMSG ^& RestartMSG"
set "STR[A3]=^> All finished"
set "STR[A4]=@Dimens"
set "STR[A6]=PZ Server [ %servername% ] Installation"
set "TGB[D3]=Thanks you for using my Project Zomboid InstallerScript^!"
set "TGB[D4]=https://steamcommunity.com/profiles/76561198020468907/"
set "line=%spaces%"
set "line1A=%line:~0,22%- %STR[1A]%"
set "line1B=%line:~0,22%- %STR[1B]%"
set "line2=%line:~0,22%- %STR[2]%"
set "line3=%line:~0,22%- %STR[3]%"
set "line4=%line:~0,22%- %STR[4]%"
set "line5=%line:~0,22%- %STR[5]%"
set "line6=%line:~0,22%- %STR[6]%"
set "line7=%line:~0,22%- %STR[7]%"
set "line8=%line:~0,22%- %STR[8]%"
set "line9=%line:~0,22%- %STR[9]%"
set "lineA1=%line:~0,22%- %STR[A1]%"
set "lineA2=%line:~0,22%- %STR[A2]%"
set "lineA3=%line:~0,22%- %STR[A3]%"
set "lineA4=%line:~0,20% %STR[A4]%"
set "lineA5=%line:~0,21% %STR[A5]%"
set "lineA6=%line:~0,21% %STR[A6]%"
set "TGB[B1]=servername	= %servername%"
set "TGB[G2]=fullSRVNM	= %fullservername%"
set "TGB[B3]=PublicDesc	= %PublicDesc%"
set "TGB[B4]=MaxPlayers	= %MaxPlayers%"
set "TGB[B5]=ServerPath	= %ServerPath%"
set "TGB[B6]=MemorySize	= %MemorySize%GB"
set "TGB[B7]=reconport	= %reconport%"
set "TGB[B8]=reconpass	= %reconpass%"
set "TGB[B9]=SteamPort1	= %SteamPort1%"
set "TGB[C1]=SteamPort2	= %SteamPort2%"
set "TGB[C2]=serverport	= %serverport%"
set "TGB[C3]=serverip	= %serverip%"
set "TGB[C4]=ServerConfig = %ServerConfig%"
set "TGB[C5]=LogPath	   = %LogPath%"
set "TGB[C6]=WatchdogLoc  = %WatchdogLoc%"
set "TGB[C7]=workspace    = %workspace%"
set "TGB[C8]=steamlogin	= %steamlogin%"
set "TGB[C9]=SteamBRANCH   = %PZserverBRANCH%"
set "TGB[D1]=steampath    = %steampath%"
set "lineB1=%line:~0,2%- %TGB[B1]%"
set "lineG2=%line:~0,2%- %TGB[G2]%"
set "lineB3=%line:~0,2%- %TGB[B3]%"
set "lineB4=%line:~0,2%- %TGB[B4]%"
set "lineB5=%line:~0,2%- %TGB[B5]%"
set "lineB6=%line:~0,2%- %TGB[B6]%"
set "lineB7=%line:~0,2%- %TGB[B7]%"
set "lineB8=%line:~0,2%- %TGB[B8]%"
set "lineB9=%line:~0,2%- %TGB[B9]%"
set "lineC1=%line:~0,2%- %TGB[C1]%"
set "lineC2=%line:~0,2%- %TGB[C2]%"
set "lineC3=%line:~0,2%- %TGB[C3]%"
set "lineC4=%line:~0,1%- %TGB[C4]%"
set "lineC5=%line:~0,1%- %TGB[C5]%"
set "lineC6=%line:~0,1%- %TGB[C6]%"
set "lineC7=%line:~0,1%- %TGB[C7]%"
set "lineC8=%line:~0,1%- %TGB[C8]%"
set "lineC9=%line:~0,1%- %TGB[C9]%"
set "lineD1=%line:~0,1%- %TGB[D1]%"
set "lineD3=%line:~0,2% %TGB[D3]%"
set "lineD4=%line:~0,2% %TGB[D4]%"
set "SIZE=70"
set "SIZE2=-75"
set "SIZE3=30"
set "LEN=0"
title "Project Zomboid Installer"
goto StartInstallerScriptA
:StartInstallerScriptA
::Announce File location check
cls
echo.
:Title_Loop1A
if not "!!STR[1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop1A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %line1A%
echo.
echo %line2%
echo %line3%
echo %line5%
echo %line6%
echo %line7%
echo %line8%
echo %line9%
echo %lineA1%
echo %lineA2%
echo %lineA3%
echo.
TIMEOUT 2 > nul
echo		Checking file location..
echo.
echo.
echo.
echo.
TIMEOUT 2 > nul
goto StartupCheck

:StartupCheck
::Check if PZ_Installscript.bat is present
if exist "%WatchdogLoc%\PZ_Installscript.bat" (goto StartupCheck1) else (goto ERRORENC)
:StartupCheck1
::Check if PZ_Watchdog.bat is present
if exist "%WatchdogLoc%\PZ_Watchdog.bat" (goto StartInstallerScriptAend) else (goto ERRORENC1)
:StartInstallerScriptAend
::Show Installer Script Operation Details
cls
echo.
:Title_Loop1A2
if not "!!STR[1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop1A2
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %line1A%
echo.
echo %line2%
echo %line3%
echo %line5%
echo %line6%
echo %line7%
echo %line8%
echo %line9%
echo %lineA1%
echo %lineA2%
echo %lineA3%
echo.
echo		Checking file location.................................FOUND
echo.
timeout 3 > nul
echo 		Proceeding to 'Installer Details'..
echo.
echo.
timeout 3 > nul
goto StartInstallerScriptB

:StartInstallerScriptB
::Show Server Details and give option to edit which after it loops back to ResetScript
cls
echo.
:Title_Loop1B
if not "!!STR[1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop1B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
call :padcenter
GOTO :EOF
:padcenter
call :padrightset name 18
call :padleftset size 13
echo.
echo %line1B%
echo.
echo %lineB1%
echo %lineG2%
echo %lineB3%
echo %lineB5%
echo %lineB4%
echo %lineB6%	   %lineC4%
echo %lineB7%	   %lineC5%
echo %lineB8% %lineC6%
echo %lineB9%     %lineD1%
echo %lineC1%     %lineC7%
echo %lineC2%
echo %lineC3%
goto UseRChoice

:Usesetprompt
set "Userchoice="
set /P "Userchoice=		Server details correct [Y]es to Contingue/[N]o to edit in notepad]?"
set "Userchoice=!Userchoice: =!"
if /I not "!UserChoice!" == "Y" goto DetailsINC
goto JavaCheck1auto

:Userchoice
echo.
choice /C YN /N /T:15 /D:Y /M "Server details correct [Y]es to Contingue/[N]o to edit in notepad?"
if %errorlevel%==1 goto JavaCheck1auto
if %errorlevel%==2 goto DetailsINC
goto DetailsINC

:padrightset
call set padded=%%%1%%%spaces%
call set %1=%%padded:~0,%2%%
goto :eof
:padleftset
call set padded=%spaces%%%%1%%
call set %1=%%padded:~-%2%%
goto :eof

:DetailsINC
cls
echo.
:Title_Loop1C
if not "!!STR[1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop1C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		Installer Details:
echo.
echo %lineB1%
echo %lineG2%
echo %lineB3%
echo %lineB4%
echo %lineB5%
echo %lineB6%		%lineC4%
echo %lineB7%		%lineC5%
echo %lineB8%	%lineC6%
echo %lineB9%		%lineC7%
echo %lineC1%		%lineC8%
echo %lineC2%		%lineC9%
echo %lineC3%	%lineD1%
echo.
echo		Details Incorrect
echo		Edit PZ_Installscript.bat...
pushd %WatchdogLoc%
notepad.exe PZ_Installscript.bat
echo.
echo		- Restarting PZ Installer Script
echo.
TIMEOUT 3 > nul
goto ResetScript

:JavaCheck1auto
::Check if Java is installed in X64
:: _________________________________________________________
cls
echo.
:Title_Loop2A
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 4 > nul
::When NO Java is Detected it will download if detected it will procede with other downloads.
if exist "C:\Program Files\Java" (goto JavaDetected) else (goto NoJAVADetected)
:NoJAVADetected
::No Java Was detected and asking means user input sooooo... proceeding to download Java.
cls
%ColorRed%
cls
echo.
:Title_Loop2C
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation..................................NOT FOUND
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
%BaseColor%
cls
echo.
:Title_Loop2C1
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2C1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation..................................NOT FOUND
echo.
echo		    Downloading Java..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
cls
%ColorBlue%
::Creating TEMP Dir, will later be removed
IF NOT EXIST %ServerPath%\Dump (
Mkdir %ServerPath%\Dump
)
::Downloading Java
if exist "%WORKSPACE%\java_latest_v.exe" (goto JavaDLDone) else (goto JavaDL)
:JavaDL
bitsadmin.exe /transfer replica /priority FOREGROUND "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246806_424b9da4b48848379167015dcc250d8d" %WORKSPACE%\java_latest_v.exe
:JavaDLDone
%BaseColor%
cls
echo.
:Title_Loop2D
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation..................................NOT FOUND
echo.
echo		    Downloading Java................................FINISHED
echo		    Installing Java...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 4 > nul
::Installing JAVA on Machine
call %workspace%\java_latest_v.exe /s
cls
%ColorGreen%
echo.
:Title_Loop2E
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		    Downloading Java................................FINISHED
echo		    Installing Java.................................FINISHED
echo.
echo		Proceeding to download remaining tools..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
%BaseColor%
goto DownloadTools

:JavaDetected
cls
%ColorGreen%
echo.
:Title_Loop2F
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2F
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
%BaseColor%
goto DownloadTools



:DownloadTools
::Downloading rcon(Remote Commandlinetool), SteamCMD (Game Downloader) and ZomboidRCON (Admin Tool).
:: _________________________________________________________
cls
%ColorRed%
echo.
:Title_Loop3A
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
::Creating TEMP dirs for Downloads
IF NOT EXIST %ServerPath%\Dump (
Mkdir %ServerPath%\Dump
)
IF NOT EXIST %ServerPath%\steamcmd (
Mkdir %ServerPath%\steamcmd
)
cls
%BaseColor%
echo.
:Title_Loop3B
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo		    RCON ^& SteamCMD..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
cls
echo.
:Title_Loop3C
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo		    RCON ^& SteamCMD..
echo.
echo		    Downloading RCON...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
%ColorBlue%
::Download RCON
if exist "%WatchdogLoc%\rcon.exe" (goto RCONconfigcheck) else (goto RCONDL)
:RCONconfigcheck
if exist "%WatchdogLoc%\rcon.yaml" (goto RCONDLDone) else (goto RCONDL)
:RCONDL
bitsadmin.exe /transfer replica /priority FOREGROUND "http://github.com/gorcon/rcon-cli/releases/download/v0.10.2/rcon-0.10.2-win64.zip" %WORKSPACE%\dump_data.zip
:RCONDLDone
:Title_Loop3D
%BaseColor%
cls
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo		    RCON ^& SteamCMD..
echo.
echo		    Downloading RCON................................FINISHED
echo		    Downloading Steam Command Line Tool..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 2 > nul
%ColorBlue%
::Download STEAMCMD
if exist "%steampath%\steamcmd.exe" (goto SteamUpdateDLDone) else (goto SteamUpdateDL)
:SteamUpdateDL
bitsadmin.exe /transfer replica /priority FOREGROUND "http://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip" %WORKSPACE%\dump_data1.zip
:SteamUpdateDLDone
%BaseColor%
TIMEOUT 1 > nul
cls
echo.
:Title_Loop3G
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3G
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo		    RCON ^& SteamCMD..
echo.
echo		    Downloading RCON................................FINISHED
echo		    Downloading Steam Command Line Tool.............FINISHED
echo		    Extracting files...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
::Extracting Downloads
pushd %WORKSPACE%
Call :UnZipFile1 "%WORKSPACE%" "%WORKSPACE%\dump_data.zip"
:UnZipFile1Go
TIMEOUT 1 > nul
Call :UnZipFile2 "%steampath%" "%WORKSPACE%\dump_data1.zip"
:UnZipFile2Go
TIMEOUT 1 > nul
cls
echo.
:Title_Loop3H
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3H
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo		    RCON ^& SteamCMD..
echo.
echo		    Downloading RCON................................FINISHED
echo		    Downloading Steam Command Line Tool.............FINISHED
echo		    Extracting files................................FINISHED
echo		    Moving files..
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
::Move Tools to right place so we can delete temp
pushd %WatchdogLoc%
move %workspace%\rcon-0.10.2-win64\rcon.exe
move %workspace%\rcon-0.10.2-win64\rcon.yaml
cls
echo.
:Title_Loop3I
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3I
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo		    RCON ^& SteamCMD..
echo.
echo		    Downloading RCON................................FINISHED
echo		    Downloading Steam Command Line Tool.............FINISHED
echo		    Extracting files................................FINISHED
echo		    Moving files....................................FINISHED
echo		    Cleaning up files..
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
::Delete Download temp
rmdir /s /q %ServerPath%\Dump
cls
echo.
:Title_Loop3J
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3J
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo.
echo		Remaining Tools....................................NOT FOUND
echo.
echo		    RCON ^& SteamCMD..
echo.
echo		    Downloading RCON................................FINISHED
echo		    Downloading Steam Command Line Tool.............FINISHED
echo		    Extracting files................................FINISHED
echo		    Moving files....................................FINISHED
echo		    Cleaning up files...............................FINISHED
echo		    Prepare RCON for easy use..
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
goto PrepRcon
::Scripts used for unpacking files
:UnZipFile1 <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>>%vbs% echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
goto UnZipFile1Go

:UnZipFile2 <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>>%vbs% echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
goto UnZipFile2Go

:UnZipFile3 <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>>%vbs% echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
goto UnZipFile3Go

:PrepRcon
::Prepare RCON config file
:: _________________________________________________________
::Update rcon.yaml with user input data
mkdir %ServerPath%\logs\Watchdog_Logs\RconLog
pushd "%WatchdogLoc%"
set ipandport=%serverip%:%reconport%
for /f "tokens=* delims=" %%a in (rcon.yaml) do (
    set str1=%%a
    call :morph
    echo !str2!>>rcon_new.yaml
    echo !str2!
)
del rcon.yaml
ren rcon_new.yaml rcon.yaml
TIMEOUT 1 > nul
cls
%ColorGreen%
echo.
:Title_Loop4B
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo.
echo		    RCON ^& SteamCMD................................FINISHED
echo.
echo		    Downloading RCON................................FINISHED
echo		    Downloading Steam Command Line Tool.............FINISHED
echo		    Extracting files................................FINISHED
echo		    Moving files....................................FINISHED
echo		    Cleaning up files...............................FINISHED
echo		    Prepare RCON for easy use.......................FINISHED
echo.
echo.
echo.
echo.
echo.
timeout 4 > nul

goto AddRules
::Scripts used for updating recon config file
:morph
    set str2=
:morph1
    if not "x!str1!"=="x" (
        if "!str1:~0,9!"=="address: " (
            set str2=!str2!address: "!ipandport!"
            set str1=!str1:~60!
            goto :morph1
        )
        if "!str1:~0,5!"=="word:" (
            set str2=!str2!word: "!reconpass!"
            set str1=!str1:~20!
            goto :morph1
        )
        if "!str1:~0,6!"=="type: " (
            set str2=!str2!type: "!rcontype!"
            set str1=!str1:~50!
            goto :morph1       
		)
        set str2=!str2!!str1:~0,1!
        set str1=!str1:~1!
        goto :morph1
    )
    goto :eof

:AddRules
::Import Firewall Rules
:: _________________________________________________________
cls
%BaseColor%
echo.
:Title_Loop5
if not "!!STR[5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop5
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[5]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo.
echo		Adding the firewall rules..
TIMEOUT 2 > nul
echo.
echo  Please Accept UAC prompt for elevated permissions to add FW Rules
echo.
Timeout 4 > nul
pushd %temp%
>"%temp%\getadmin.vbs" echo Set UAC = CreateObject^("Shell.Application"^) 
set params = %*:"=""
>>"%temp%\getadmin.vbs" echo UAC.ShellExecute "cmd.exe", "/c ""%temp%\AddRules.bat"" %params%", "", "runas", 1 
>"%temp%\AddRules.bat" echo.Pushd "%%cd%%"
>>"%temp%\AddRules.bat" echo.cd /D "%%~dp0"
>>"%temp%\AddRules.bat" echo.netsh advfirewall firewall add rule name="PZServer_%Serverport%_UDP" dir=in action=allow protocol=UDP localport=%Serverport%
>>"%temp%\AddRules.bat" echo.netsh advfirewall firewall add rule name="PZServer_%Serverport%-%Serverport1%_TCP" dir=in action=allow protocol=TCP localport="%Serverport%-%Serverport1%"
>>"%temp%\AddRules.bat" echo.netsh advfirewall firewall add rule name="PZSteam_%SteamPort1%-%SteamPort2%_UDP" dir=in action=allow protocol=UDP localport="%SteamPort1%,%SteamPort1%"
>>"%temp%\AddRules.bat" echo.netsh advfirewall firewall add rule name="PZSteam_FORMODS_SteamCMD" dir=in action=allow program="%ServerPath%\steamcmd\steamcmd.exe"
>>"%temp%\AddRules.bat" echo.netsh advfirewall firewall add rule name="PZrecon_%reconport%_TCP" dir=in action=allow protocol=TCP localport=%reconport%
cscript "getadmin.vbs"
timeout 4 > nul
del "%temp%\getadmin.vbs"
del "%temp%\AddRules.bat"
echo.
Echo	If Admin-rights are accepted it will:
echo.
Timeout 5 > nul
Echo	Add "PZServer_%Serverport%_UDP"/Direction=IN/Protocol=UDP/localport=%Serverport% 
echo	Port used for Project Zomboid Basic Server communiction.
echo.
TIMEOUT 1 > nul
Echo	Add "PZServer_%Serverport%-%Serverport1%_TCP"/Direction=IN/Protocol=TCP/localport="%Serverport%-%Serverport1%
echo	Ports used for Project Zomboid Server Player Count.
echo.
TIMEOUT 1 > nul
Echo	Add "PZSteam_%SteamPort1%-%SteamPort2%_UDP"/Direction=IN/Protocol=UDP/localport="%SteamPort1%,%SteamPort1%
echo	Ports used by steam to make the Server visible in Client games.
echo.
TIMEOUT 1 > nul
Echo	Add "PZSteam_FORMODS_SteamCMD"/Direction=IN/action=allow/program="%ServerPath%\steamcmd\steamcmd.exe"
echo	Program added to allow update of game and mods.
echo.
TIMEOUT 1 > nul
Echo	Add "PZrecon_%reconport%_TCP"/Direction=IN/Protocol=UDP/localport=%reconport% 
echo	Port used for remote access of server but still need rcon password.
echo.
TIMEOUT 10 > nul
goto AddRulesDone

:AddRulesDone
cls
echo.
:Title_Loop5B
if not "!!STR[5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop5B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[5]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo.
echo		Adding the firewall rules...........................FINISHED
echo.
TIMEOUT 5 > nul
ECHO		Steam Installation starting..
TIMEOUT 2 > nul
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto SteamUpdate

:SteamUpdate

If "%AutoDownloadMods%"=="No" goto SteamUpdateANNO2de
If "%AutoDownloadMods%"=="Yes" goto SteamUpdateUSER

:SteamUpdateUSER
:: // Check for any game or mod updates
:: _________________________________________________________
cls
echo.
:Title_Loop3B1
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
TIMEOUT 1 > nul
ECHO		Steam Installation..
echo.
TIMEOUT 1 > nul
echo PZ Mods     : %ServerPath%
echo SteamCMD Dir: %steampath%
echo PZ Client   : %WORKSPACE1%
echo Branch      : %PZClientBRANCH%
echo SteamUser   : %SteamUser%
echo SteamPass   : %SteamPassword%
echo.
echo.
echo.
echo.
TIMEOUT 8 > nul

:Title_Loop3B2
cls
echo.
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B2
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
TIMEOUT 1 > nul
ECHO		Steam Installation..
echo.
echo		    Installing Project Zomboid Mods..
echo		    BranchMods  : %WorkShopIDSteam%
echo		    ModID       : %ModID%
Timeout 3 > nul
echo		    This can take some time
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 6 > nul

:Title_Loop3B3
cls
echo.
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B3
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
ECHO		Steam Installation..
echo.
echo		    Installing Project Zomboid Mods..
echo		    BranchMods  : %WorkShopIDSteam%
echo		    ModID       : %ModID%
echo		    This can take some time
echo.
Timeout 1 > nul
echo		IF STEAM-GUARD IS ENABLED INPUT CODE MANUALLY
echo.
echo.
echo.
echo.
echo.
TIMEOUT 1 > nul
set /a counter5=%counter5%+1
if %counter5% equ 18 goto SteamUpdateUSERLoop
goto Title_Loop3B3

:SteamUpdateUSERLoop
IF NOT EXIST %PZModsLoc% (
Mkdir %PZModsLoc%
)
IF NOT EXIST %WORKSPACE1% (
Mkdir %WORKSPACE1%
)
TIMEOUT 5 > nul
%ColorBlue%
%STEAMPATH%\steamcmd.exe +force_install_dir %WORKSPACE1% +login %SteamLoginFULL% +"app_update %PZClientBRANCH%" validate +quit
pushd %ServerPath%\Watchdog
for /F "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26 delims=;" %%a in ("%WorkshopID%") do (
   echo %%a >WorkshopIDs.txt
   echo %%b >>WorkshopIDs.txt
   echo %%c >>WorkshopIDs.txt
   echo %%d >>WorkshopIDs.txt
   echo %%e >>WorkshopIDs.txt
   echo %%f >>WorkshopIDs.txt
   echo %%g >>WorkshopIDs.txt
   echo %%h >>WorkshopIDs.txt
   echo %%i >>WorkshopIDs.txt
   echo %%j >>WorkshopIDs.txt
   echo %%k >>WorkshopIDs.txt
   echo %%l >>WorkshopIDs.txt
   echo %%m >>WorkshopIDs.txt
   echo %%n >>WorkshopIDs.txt
   echo %%o >>WorkshopIDs.txt
   echo %%p >>WorkshopIDs.txt
   echo %%q >>WorkshopIDs.txt
   echo %%r >>WorkshopIDs.txt
   echo %%s >>WorkshopIDs.txt
   echo %%t >>WorkshopIDs.txt
   echo %%u >>WorkshopIDs.txt
   echo %%w >>WorkshopIDs.txt
   echo %%v >>WorkshopIDs.txt
   echo %%x >>WorkshopIDs.txt
   echo %%y >>WorkshopIDs.txt
   echo %%z >>WorkshopIDs.txt
)
for /F %%G IN (WorkshopIDs.txt) do (robocopy %workspace1%\steamapps\workshop\content\108600\%%G\Mods %PZModsLoc% /e /COPY:DAT /NFL /NDL /NJH /NJS /nc /ns /np >nul)
del WorkshopIDs.txt

:Title_Loop3B4
cls
%BaseColor%
echo.
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B4
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
TIMEOUT 1 > nul
ECHO		Steam Installation..
echo.
echo		    Installing Project Zomboid Mods.................FINISHED
echo.
Timeout 1 > nul
echo Mods Located in: '%PZModsLoc%'
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 7 > nul
goto SteamUpdateANNO

:SteamUpdateANNO
::Install Game
:: _________________________________________________________
cls
echo.
:Title_Loop6
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
ECHO		Steam Installation..
echo.
echo		    Installing Project Zomboid Mods.................FINISHED
echo		    Installing Project Zomboid Server..
echo.
TIMEOUT 1 > nul
echo			Dir        : %ServerPath%
echo			Steam Dir  : %steampath%
echo			Branch     : %PZserverBRANCH%
echo.
echo.
echo.
echo.
timeout 8 > nul
cls
%ColorBlue%
%steampath%\steamcmd.exe +force_install_dir %ServerPath% +login %steamlogin% +"app_update %PZserverBRANCH%" validate +quit
%BaseColor%
cls
echo.
:Title_Loop6A
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
ECHO		Steam Installation..................................FINISHED
echo.
echo		    Installing Project Zomboid Mods.................FINISHED
TIMEOUT 1 > nul
echo		    Installing Project Zomboid Server...............FINISHED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
timeout 7 > nul
cls
goto PREChangeConfig

:SteamUpdateANNO2de
::Install Game
:: _________________________________________________________
cls
echo.
:Title_Loop6B
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
ECHO		Steam Installation..
echo.
echo		    Installing Project Zomboid Server..
echo.
TIMEOUT 1 > nul
echo			Dir        : %ServerPath%
echo			Steam Dir  : %steampath%
echo			Branch     : %PZserverBRANCH%
echo.
echo.
echo.
echo.
echo.
timeout 7 > nul
cls
%ColorBlue%
%steampath%\steamcmd.exe +force_install_dir %ServerPath% +login %steamlogin% +"app_update %PZserverBRANCH%" validate +quit
%BaseColor%
cls
echo.
:Title_Loop6C
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo.
ECHO		Steam Installation..................................FINISHED
echo.
TIMEOUT 1 > nul
echo		    Installing Project Zomboid Server...............FINISHED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
timeout 6 > nul
cls
goto PREChangeConfig

:PREChangeConfig
::Pre-Configure Server startup file
:: _________________________________________________________
cls
echo.
:Title_Loop7
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo.
echo		Configuring Pre-Auto Change Config values..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
cls
echo.
:Title_Loop7A
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo.
echo		Configuring Pre-Auto Change Config values..
echo.
echo		    Progress 20/100 - Creating 'quit.bat' file.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
::Creating Quit.bat File
if exist "%WatchdogLoc%\quit.bat" (goto PREChangeConfigProcessed) else (goto PREChangeConfigProcess)
:PREChangeConfigProcess
pushd %WatchdogLoc%
echo.@echo off>>quit.bat
echo.cls>>quit.bat
echo.:: \\ Function:>>quit.bat
echo.:: \\ Used to send a Quit Command to Server>>quit.bat
echo.:: \\^<-Edit these Settings to match your server configuration>>quit.bat
echo.:: \\ Configure location of rcon-cli tool: >>quit.bat
echo.set WatchdogLoc=%WatchdogLoc%>>quit.bat
echo REM ------------------------------------------------------------------------------- >>quit.bat
echo :: ^<-DO not edit below this line^^! >>quit.bat
echo Pushd ^%%WatchdogLoc^%% >>quit.bat
echo echo. >>quit.bat
echo echo. >>quit.bat
echo echo Sending shutdown command in 5 seconds >>quit.bat
echo TIMEOUT /T 5 >>quit.bat
echo rcon -c rcon.yaml "quit" >>quit.bat
echo exit >>quit.bat
echo :: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License^^! >> quit.bat
echo :: \\ Created by Dimens - https://github.com/Dimens101/PG-Installerscript >> quit.bat
:PREChangeConfigProcessed
cls
echo.
:Title_Loop7B
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo.
echo		Configuring Pre-Auto Change Config values..
echo.
echo		    Progress 40/100 - Updating PZ_Watchdog with User input.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
pushd %WatchdogLoc%
copy PZ_Watchdog.bat temp101.txt
echo.goto StartFullScript>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: ^<- Do NOT edit below here or the script might fail.>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.REM ------------------------------------------------------------------------------->PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: ^<- EDIT Above >PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  \\====================================================================================================//>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set MemorySize=^%MemorySize%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  MemorySize=you will need to multiply 500MB per player you have on your server, plus a base 2GB.Choose-^>2-4-8-16-32-64>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  ^|^|^<StartServer64.bat^> These settings will be automatically configured and can later be changed>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  //============================[ Custom Server settings ]==============================================\\>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  \\====================================================================================================//>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set SteamPort2=%SteamPort2%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  SteamPort2=Can leave default.Default=8767>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set SteamPort1=%SteamPort1%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  SteamPort1=Can leave default, used for steam. Default=8766>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set reconpass=%reconpass%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  reconpass=Change this password^!^! >PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set reconport=%reconport%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  reconport=Can leave default, used for sending remote commands.>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.Set WorkshopID=%WorkshopID%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  Example: WorkshopID=2392709985;2282429356;2702055974>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.Set Maps=%Maps%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  Example: Map=BedfordFalls;North;South;West;Muldraugh, KY>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.Set ModID=%ModID%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  Example: ModID=BedfordFalls;tsarslib;autotsartrailers;SkillTapes>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set ServerPass=%ServerPass%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  ServerPass=Lock Server with password and make it not accessible to Public>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set ServerPath=%ServerPath%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  ServerPath= Choose where to install the Project Zomboid Server^?>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
>PZ_Watchdog.bat echo.set MaxPlayers=%MaxPlayers%
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  MaxPlayers=Set max amount of players that can logon Default=32>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set PublicDesc=%PublicDesc%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  PublicDesc=For Public Description of your server, make new line with \n >PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set fullservername=%fullservername%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  fullservername=For Public server name in steam Host search pick anything>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set servername=%servername%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  servername=For Basic server name pick something small without spaces.>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set serverport=%serverport%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  serverport= Change this if you already have a server on the same network. Default=162621>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set SteamPublic=%SteamPublic%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  Show up in Steam Public Server lists>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set PVP=%PVP%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  Set to 'false' for PVE / Set to 'true' for PVP Default=true>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  ^|^|^<Servername.ini^> These settings will be automatically configured and can later be changed>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  //============================[ Custom Server settings ]==============================================\\>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  \\====================================================================================================//>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set SteamPassword=%SteamPassword%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.set SteamUser=%SteamUser%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: 	Annonymous logon is not allowed for downloading MODS -If no mods are used Login data is not required.>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.Set AutoDownloadMods=%AutoDownloadMods%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: 	Set to Yes if you want to autodownload mods to ^<Server^>\Mods>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.Set OpenFolders=%OpenFolders%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: 	Set to true if you want to open the Console Folders Minimized when watchdog starts..>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.Set AutoUpdateConfig=%AutoUpdateConfig%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: 	Set to Yes if you want to Auto Update the Server.ini file with below settings (Needed ^for AutoDownloadMods)>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.Set AdminTool=%AdminTool%>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::	Set to Yes if you want to use Zomboid RCON Admin Tool, set to NO if you don't want ot use it. If Yes it will auto download and install .NET Runtime 6.0.6 ^(https://github.com/kwmx/ZomboidRCON^)>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::  //============================[ Custom Scritpt settings ]=============================================\\>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::   ^|^| Make Sure this file PZ_Watchdog.bat is placed inside the directory given below: '^<folder^>\rcon' or it will fail.>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::   ^|^| Do not change any lines starting with ::, only change text after '='symbol ^(Do not use ^^,^&,^<,^>,^|,^\,^= chars^)>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::   ^|^| Project Zomboid Watchdog Config Settings:>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.::>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: ^<- EDIT Below>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.REM ------------------------------------------------------------------------------->PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:: ^<- Do NOT edit above here or the script might fail.>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.@cd /d "%%~dp0">PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.:ResetScript>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.setlocal enableextensions enabledelayedexpansion>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt
copy PZ_Watchdog.bat temp101.txt
echo.@echo off>PZ_Watchdog.bat
type temp101.txt >>PZ_Watchdog.bat
del temp101.txt

cls
echo.
:Title_Loop7C
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo.
echo		Configuring Pre-Auto Change Config values..
echo.
echo		    Progress 60/100 - Adding startup safety to 'StartServer64.bat'.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
::Deprecated Function
cls
echo.
:Title_Loop7D
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo.
echo		Configuring Pre-Auto Change Config values..
echo.
echo		    Progress 80/100 - Re-Creating 'StartServer64.bat' with User input.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
::ReCreate StartServer64.cmd file
TIMEOUT 5 > nul
pushd %ServerPath%
echo.@ECHO off>StartServer64.bat
echo.@setlocal enableextensions>>StartServer64.bat
echo.@cd /d "%%~dp0">>StartServer64.bat
echo.color 0A>>StartServer64.bat
echo.cls>>StartServer64.bat
echo.title Project_Zomboid_Server_%servername%_%serverip%_%serverport% Watchdog>>StartServer64.bat
echo.tasklist /fi "imagename eq java.exe" /FO TABLE ^| find /i "java.exe">>StartServer64.bat
echo.if "%%ERRORLEVEL%%"=="0" goto PZClose>>StartServer64.bat
echo.if "%%ERRORLEVEL%%"=="1" goto StartServer>>StartServer64.bat
echo.:PZClose>>StartServer64.bat
echo.color 0C>>StartServer64.bat
echo.^echo JAVA.EXE ALREADY RUNNING>>StartServer64.bat
echo.pause>>StartServer64.bat
echo.exit>>StartServer64.bat
echo.:StartServer>>StartServer64.bat
echo.echo.Started at %%date%% %%time%%^>Started>>StartServer64.bat
echo.SET PZ_CLASSPATH=java/istack-commons-runtime.jar;java/jassimp.jar;java/javacord-2.0.17-shaded.jar;java/javax.activation-api.jar;java/jaxb-api.jar;java/jaxb-runtime.jar;java/lwjgl.jar;java/lwjgl-natives-windows.jar;java/lwjgl-glfw.jar;java/lwjgl-glfw-natives-windows.jar;java/lwjgl-jemalloc.jar;java/lwjgl-jemalloc-natives-windows.jar;java/lwjgl-opengl.jar;java/lwjgl-opengl-natives-windows.jar;java/lwjgl_util.jar;java/sqlite-jdbc-3.27.2.1.jar;java/trove-3.0.3.jar;java/uncommons-maths-1.2.3.jar;java/commons-compress-1.18.jar;java/>>StartServer64.bat
echo.".\jre64\bin\java.exe" -Djava.awt.headless=true -Dzomboid.steam=1 -Dzomboid.znetlog=1 -XX:+UseG1GC -XX:-CreateCoredumpOnCrash -XX:-OmitStackTraceInFastThrow -Xms%MemorySize%g -Xmx%MemorySize%g -Djava.library.path=natives/;natives/win64/;. -cp ^%%PZ_CLASSPATH^%% zombie.network.GameServer -port %serverport% -servername %servername% -statistic 0 ^%%1 ^%%2>>StartServer64.bat
echo.del /q started>>StartServer64.bat
echo.exit>>StartServer64.bat
goto FindReplace2Done


:FindReplace2Done
cls
echo.
:Title_Loop7E
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo.
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo.
echo		    Progress 100/100 - Finished.
echo.
TIMEOUT 5 > nul
echo		Proceeding to Start the Staging-Server..
echo.
echo		This is not the final PZ server^!
echo			- Move the Server Window so script is still visible.
echo			 ^* Read the instructions from the script.
echo.
echo.
TIMEOUT 14
cls
goto StartServer

:StartServer
::Opening new window to start PZ server script
cls
echo.
:Title_Loop8
if not "!!STR[8]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop8
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[8]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
echo		Proceeding to Start the Staging-Server..NOW^!
echo.
echo		This is not the final PZ server^!
echo			- Move the Server Window so script is still visible.
echo			 ^* Read the instructions from the script.
echo.
echo.
pushd %ServerPath%
start  "Project_Zomboid_Server_%servername%_%serverip%_%serverport%" /High /I StartServer64.bat
TIMEOUT 6 > nul
cls
echo.
:Title_Loop8A
if not "!!STR[8]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop8A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[8]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		    Staging Server starting..
echo.
TIMEOUT 1 > nul
echo.
echo.
echo.
echo		Watch the second window and input your 'Server Password'
TIMEOUT 2 > nul
echo				""REMEMBER THIS PASSWORD""
echo.
TIMEOUT 10 > nul
echo		'Zomboid Server is VAC Secure' means server = done loading.	
TIMEOUT 2 > nul				
echo		      Type 'quit' once the server fully started.
TIMEOUT 2 > nul
echo.
echo		                  DO NOT CLOSE THIS WINDOW
echo.
TIMEOUT 5 > nul
echo		Checking if the server is down..
echo.
echo.
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
if "%ERRORLEVEL%"=="0" goto ShutdownServer
if "%ERRORLEVEL%"=="1" goto JAVADOWN
goto ShutdownServer
:ShutdownServer
cls
:Title_Loop9A
if not "!!STR[9]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop9A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[9]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Project_Zomboid_%serverip%_%serverport% starting.
echo.
echo.
echo.
echo.
echo		Watch the second window and input your 'Server Password'
echo				""REMEMBER THIS PASSWORD""
echo.
echo		'Zomboid Server is VAC Secure' means server = done loading.	
echo		      Type 'quit' once the server fully started.
echo.
echo		                 DO NOT CLOSE THIS WINDOW
echo.
TIMEOUT 1 > nul
echo		Checking if the server is down: ONLINE
echo.
echo.
echo.
TIMEOUT 4 > nul
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
if "%ERRORLEVEL%"=="0" goto ShutdownServer
if "%ERRORLEVEL%"=="1" goto JAVADOWN
cls
goto ShutdownServer2
:ShutdownServer2
cls
:Title_Loop9A
if not "!!STR[9]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop9A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[9]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Project_Zomboid_%serverip%_%serverport% starting.
echo.
echo.
echo.
echo.
echo		Watch the second window and input your 'Server Password'
echo				""REMEMBER THIS PASSWORD""
echo.
echo		'Zomboid Server is VAC Secure' means server = done loading.	
echo		      Type 'quit' once the server fully started.
echo.
echo		                 DO NOT CLOSE THIS WINDOW
echo.
TIMEOUT 1 > nul
echo		Checking if the server is down:
echo.
echo.
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
if "%ERRORLEVEL%"=="0" goto ShutdownServer
if "%ERRORLEVEL%"=="1" goto JAVADOWN

:JAVADOWN
:: When Java is down
cls
echo.
:Title_Loop9E
if not "!!STR[9]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop9E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[9]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Project_Zomboid_%serverip%_%serverport% starting.
echo.
echo.
echo.
echo.
echo		Watch the second window and input your 'Server Password'
echo				""REMEMBER THIS PASSWORD""
echo.
echo		Once server is fully started type 'quit' to stop the server.
echo		Or the server might crash which is oke.. Just hang in there..
echo		                  DO NOT CLOSE THIS WINDOW
echo.
echo		Checking if the server is down: OFFLINE
echo.
TIMEOUT 4 > nul
echo		Proceeding to Post-Auto Change Config values 
echo.
echo.
echo.
TIMEOUT 5 > nul
goto PostChangeConfig

:PostChangeConfig
::Pre-Configure Server startup file
cls
echo.
:Title_LoopA1
if not "!!STR[A1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo.
echo		Configuring Post-Auto Change Config values..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
::Scripts to update the server.ini file
pushd %ServerConfig%\Server
SET "file1=%servername%.ini"
SET /a Line#ToSearch=2
SET "Replacement=PVP=%PVP%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file1%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file1%.new"
TYPE %file1%.new
del %file1% 
ren %file1%.new %file1%
TIMEOUT 1 > nul
SET "file2=%servername%.ini"
SET /a Line#ToSearch=46
SET "Replacement=DefaultPort=%serverport%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file2%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file2%.new"
TYPE %file2%.new
del %file2% 
ren %file2%.new %file2%
TIMEOUT 1 > nul
SET "file3=%servername%.ini"
SET /a Line#ToSearch=52
SET "Replacement=Mods=%ModID%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file3%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file3%.new"
TYPE %file3%.new
del %file3% 
ren %file3%.new %file3%
TIMEOUT 1 > nul
SET "file4=%servername%.ini"
SET /a Line#ToSearch=55
SET "Replacement=Map=%Maps%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file4%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file4%.new"
TYPE %file4%.new
del %file4% 
ren %file4%.new %file4%
TIMEOUT 1 > nul
SET "file15=%servername%.ini"
SET /a Line#ToSearch=63
SET "Replacement=Public=%SteamPublic%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file15%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file15%.new"
TYPE %file15%.new
del %file15% 
ren %file15%.new %file15%
TIMEOUT 1 > nul
SET "file9=%servername%.ini"
SET /a Line#ToSearch=66
SET "Replacement=PublicName=%fullservername%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file9%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file9%.new"
TYPE %file9%.new
del %file9% 
ren %file9%.new %file9%
TIMEOUT 1 > nul
SET "file11=%servername%.ini"
SET /a Line#ToSearch=69
SET "Replacement=PublicDescription=%PublicDesc%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file11%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file11%.new"
TYPE %file11%.new
del %file11% 
ren %file11%.new %file11%
TIMEOUT 1 > nul
SET "file12=%servername%.ini"
SET /a Line#ToSearch=73
SET "Replacement=MaxPlayers=%MaxPlayers%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file12%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file12%.new"
TYPE %file12%.new
del %file12% 
ren %file12%.new %file12%
TIMEOUT 1 > nul
SET "file13=%servername%.ini"
SET /a Line#ToSearch=141
SET "Replacement=RCONPort=%reconport%"

(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file13%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file13%.new"
TYPE %file13%.new
del %file13% 
ren %file13%.new %file13%
TIMEOUT 1 > nul
SET "file5=%servername%.ini"
SET /a Line#ToSearch=144
SET "Replacement=RCONPassword=%reconpass%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file5%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file5%.new"
TYPE %file5%.new
del %file5% 
ren %file5%.new %file5%
TIMEOUT 1 > nul
SET "file6=%servername%.ini"
SET /a Line#ToSearch=159
SET "Replacement=Password=%ServerPass%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file6%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file6%.new"
TYPE %file6%.new
del %file6% 
ren %file6%.new %file6%
TIMEOUT 1 > nul
SET "file7=%servername%.ini"
SET /a Line#ToSearch=170
SET "Replacement=SteamPort1=%SteamPort1%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file7%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file7%.new"
TYPE %file7%.new
del %file7% 
ren %file7%.new %file7%
TIMEOUT 1 > nul
SET "file8=%servername%.ini"
SET /a Line#ToSearch=172
SET "Replacement=SteamPort2=%SteamPort2%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file8%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file8%.new"
TYPE %file8%.new
del %file8% 
ren %file8%.new %file8%
TIMEOUT 1 > nul
SET "file16=%servername%.ini"
SET /a Line#ToSearch=175
SET "Replacement=WorkshopID=%WorkshopID%"
(FOR /f "tokens=1*delims=:" %%a IN ('findstr /n "^" "%file16%"') DO (
    SET "Line=%%b"
    IF %%a equ %Line#ToSearch% SET "Line=%Replacement%"
    SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO(!Line!
    ENDLOCAL
))>"%file16%.new"
TYPE %file16%.new
del %file16% 
ren %file16%.new %file16%
TIMEOUT 3 > nul
cls
echo.
:Title_LoopA1A
if not "!!STR[A1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA1A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo.
echo		Configuring Post-Auto Change Config values..........FINISHED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
Goto ConfigureBatches
:ConfigureBatches
::Add scheduled task at startup, requires elevated promppt for some reason
cls
echo.
:Title_LoopA2A
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo.
echo 		Creating Schedule Task..
echo		to Launch Watchdog at windows user LOGON
echo.
Timeout 3 > nul
echo      Please Accept UAC prompt for elevated permissions to add the Task
echo.
echo.
echo.
echo.
TIMEOUT 5
pushd %temp%
>"%temp%\getadmin.vbs" echo Set UAC = CreateObject^("Shell.Application"^) 
set params = %*:"=""
>>"%temp%\getadmin.vbs" echo UAC.ShellExecute "cmd.exe", "/c ""%temp%\RunTask.bat"" %params%", "", "runas", 1 
>"%temp%\RunTask.bat" echo.Pushd "%%cd%%"
>>"%temp%\RunTask.bat" echo.cd /D "%%~dp0"
>>"%temp%\RunTask.bat" echo.schtasks /Create /TR %WatchdogLoc%\PZ_Watchdog.bat /RU %USERNAME% /TN Launch_Watchdog_At_Logon /SC ONLOGON /DELAY 0000:15 /IT /RL HIGHEST
cscript "getadmin.vbs"
timeout 4 > nul
del "%temp%\getadmin.vbs"
del "%temp%\RunTask.bat"

cls
echo.
:Title_LoopA2B
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo.
echo		Creating Schedule Task..............................FINISHED
echo.
echo.
TIMEOUT 1 > nul
echo		Proceeding to Setup Scheduled Messages Options....
echo.
echo.
echo.
echo.
Timeout 5 > nul
Goto MSGChoice

:MSGChoice
::Show descriptions for the options in the menu
cls
echo.
:Title_LoopA2C
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
TIMEOUT 1 > nul
echo.
echo		1. Create Welcome Message File
echo.
echo.
echo.
echo.
echo.
echo.
echo		   Details:
Timeout 1 > nul
echo		1 -Create file called WelcomeMSG.bat used to
echo		   send custom welcome messages.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
cls
echo.
:Title_LoopA2D
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File
TIMEOUT 1 > nul
echo		2. Create Welcome Message File	^& Schedule it
echo.
echo.
echo.
echo.
echo.
echo		   Details:
Timeout 1 > nul
echo		2 -Create file called WelcomeMSG.bat used to
echo		   schedule and send custom welcome messages
echo		   daily every Two Hours.
echo.
echo.
echo.
TIMEOUT 8 > nul
cls
echo.
:Title_LoopA2E
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File
echo		2. Create Welcome Message File	^& Schedule it
TIMEOUT 1 > nul
echo		3. Create Auto-restart File
echo.
echo.
echo.
echo.
echo		   Details:
Timeout 1 > nul
echo		3 -Create file called AutoRestart2h.bat used to
echo		   send shutdown cmd ^& logoff warning MSG to players.
echo.
echo		   ^*Restart will close server, rotate logs and update game files,
echo		   Watchdog will detect it is down and restart the server.
echo.
TIMEOUT 10 > nul
cls
echo.
:Title_LoopA2F
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2F
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File
echo		2. Create Welcome Message File	^& Schedule it
echo		3. Create Auto-restart File
TIMEOUT 1 > nul
echo		4. Create Auto-restart File 	^& Schedule it
echo.
echo.
echo.
echo		   Details:
Timeout 1 > nul
echo		4 -Create file called AutoRestart2h.bat used to
echo		   send shutdown CMD ^& logoff warning MSG to players
echo		   once a day at Two in the morning 
echo.
echo.
echo.
TIMEOUT 8 > nul
cls
echo.
:Title_LoopA2G
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2G
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File
echo		2. Create Welcome Message File	^& Schedule it
echo		3. Create Auto-restart File
echo		4. Create Auto-restart File 	^& Schedule it
TIMEOUT 1 > nul
echo		5. Choose 2 And 4
echo.
echo.
echo		   Details:
Timeout 1 > nul
echo		5 -Create scheduled WelcomeMSG.bat to send custom welcome messages  
echo		   daily two hour intervals.
echo		  -Create scheduled AutoRestart2h.bat to send warning messages and
echo		  shut down the server at two in the morning.
echo.
echo.
TIMEOUT 10 > nul
cls
echo.
:Title_LoopA2H
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2H
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File
echo		2. Create Welcome Message File	^& Schedule it
echo		3. Create Auto-restart File
echo		4. Create Auto-restart File 	^& Schedule it
echo		5. Choose 2 And 4
TIMEOUT 1 > nul
echo		6. Create no extra Files.
echo.
echo		   Details:
Timeout 1 > nul
echo		6 -Create no extra files and Finish.
echo.
echo.	
echo.
echo.
echo.
TIMEOUT 3 > nul
goto MSGChoiceMENU
:MSGChoiceMENU
::Menu to add autorestart and welcome message scripts and also schedule them
cls
echo.
:Title_LoopA2I
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2I
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File
echo		2. Create Welcome Message File	^& Schedule it
echo		3. Create Auto-restart File
echo		4. Create Auto-restart File 	^& Schedule it
echo		5. Choose 2 And 4
echo		6. Create no extra Files.
echo		7. Show Details again.
Timeout 1 > nul
echo.
echo.
echo	If no # is given in 30sec option 5 is accepted.
echo.
choice /C:1234567 /N /T:30 /D:5 /M:"		Input your answer: "
echo.
echo.
echo.
echo.
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :MSGloop1
if %ERRORLEVEL%==2 call :MSGloop2
if %ERRORLEVEL%==3 call :MSGloop3
if %ERRORLEVEL%==4 call :MSGloop4
if %ERRORLEVEL%==5 call :MSGloop5
if %ERRORLEVEL%==6 call :MSGloop6
if %ERRORLEVEL%==7 call :MSGChoice
goto MSGChoice
TIMEOUT 7 > nul
:MSGloop1
cls
echo.
:Title_LoopA2J
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2J
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-11-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File......................ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
if exist "%WatchdogLoc%\WelcomeMSG.bat"\ (goto MSGloop1Processed) else (goto MSGloop1Process)
:MSGloop1Process
::Creating WelcomeMSG.bat script
pushd %WatchdogLoc%
echo.@echo off>WelcomeMSG.bat
echo.cls>>WelcomeMSG.bat
echo.:: \\ Function:>>WelcomeMSG.bat
echo.:: \\ Used to send a Custom message you can edit>>WelcomeMSG.bat
echo.:: \\^<-Edit these Settings to match your server configuration>>WelcomeMSG.bat
echo.:: \\ Configure location of rcon-cli tool: >>WelcomeMSG.bat
echo.set WatchdogLoc=%WatchdogLoc%>>WelcomeMSG.bat
echo set WelcomMSG="Welcome to my TestServer" >> WelcomeMSG.bat
echo set DiscordMSG="https://discord.gg/BKqWjKEK" >> WelcomeMSG.bat
echo REM ------------------------------------------------------------------------------- >> WelcomeMSG.bat
echo :: ^<-DO not edit below this line^^! >> WelcomeMSG.bat
echo Pushd ^%%WatchdogLoc^%% >> WelcomeMSG.bat
echo echo. >> WelcomeMSG.bat
echo echo. >> WelcomeMSG.bat
echo echo Sending welcome msg >> WelcomeMSG.bat
echo rcon -c rcon.yaml "servermsg \%%WelcomMSG%%" >> WelcomeMSG.bat
echo TIMEOUT /T 2 >> WelcomeMSG.bat
echo echo Sending discord Channel >> WelcomeMSG.bat
echo rcon -c rcon.yaml "servermsg \%%DiscordMSG%%" >> WelcomeMSG.bat
echo TIMEOUT /T 2 >> WelcomeMSG.bat
echo exit >> WelcomeMSG.bat
echo :: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License^^! >> WelcomeMSG.bat
echo :: \\ Created by Dimens - https://github.com/Dimens101/PG-Installerscript >> WelcomeMSG.bat
:MSGloop1Processed
cls
echo.
:Title_LoopA2K
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2K
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo		1. Create Welcome Message File......................ACCEPTED
echo.
echo WelcomeMSG.bat created in %WatchdogLoc%
TIMEOUT 2 > nul
echo.
echo			Proceeding to Finish Script.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
goto EndofScript
:MSGloop2
cls
echo.
:Title_LoopA2L
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2L
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo		2. Create Welcome Message File	^& Schedule it......ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
if exist "%WatchdogLoc%\WelcomeMSG.bat"\ (goto MSGloop1Processed) else (goto MSGloop1Process)
:MSGloop1Process
::Creating WelcomeMSG.bat script
pushd %WatchdogLoc%
echo.@echo off>WelcomeMSG.bat
echo.cls>>WelcomeMSG.bat
echo.:: \\ Function:>>WelcomeMSG.bat
echo.:: \\ Used to send a Custom message you can edit>>WelcomeMSG.bat
echo.:: \\^<-Edit these Settings to match your server configuration>>WelcomeMSG.bat
echo.:: \\ Configure location of rcon-cli tool: >>WelcomeMSG.bat
echo.set WatchdogLoc=%WatchdogLoc%>>WelcomeMSG.bat
echo set WelcomMSG="Welcome to my TestServer" >> WelcomeMSG.bat
echo set DiscordMSG="https://discord.gg/BKqWjKEK" >> WelcomeMSG.bat
echo REM ------------------------------------------------------------------------------- >> WelcomeMSG.bat
echo :: ^<-DO not edit below this line^^! >> WelcomeMSG.bat
echo Pushd ^%%WatchdogLoc^%% >> WelcomeMSG.bat
echo echo. >> WelcomeMSG.bat
echo echo. >> WelcomeMSG.bat
echo echo Sending welcome msg >> WelcomeMSG.bat
echo rcon -c rcon.yaml "servermsg \%%WelcomMSG%%" >> WelcomeMSG.bat
echo TIMEOUT /T 2 >> WelcomeMSG.bat
echo echo Sending discord Channel >> WelcomeMSG.bat
echo rcon -c rcon.yaml "servermsg \%%DiscordMSG%%" >> WelcomeMSG.bat
echo TIMEOUT /T 2 >> WelcomeMSG.bat
echo exit >> WelcomeMSG.bat
echo :: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License^^! >> WelcomeMSG.bat
echo :: \\ Created by Dimens - https://github.com/Dimens101/PG-Installerscript >> WelcomeMSG.bat
:MSGloop1Processed
schtasks /Create /TR %WatchdogLoc%\WelcomeMSG.bat /RU %USERNAME% /TN Launch_WelcomeMSG_2H /SC HOURLY /MO 2 /IT
cls
echo.
:Title_LoopA2M
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2M
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo		2. Create Welcome Message File	^& Schedule it......ACCEPTED
echo.
echo			WelcomeMSG.bat created ^& Scheduled
TIMEOUT 2 > nul
echo.
echo			Proceeding to Finish Script.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
goto EndofScript
:MSGloop3
cls
echo.
:Title_LoopA2N
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2N
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo		3. Create Auto-restart File.........................ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
if exist "%WatchdogLoc%\AutoRestart2h.bat"\ (goto MSGloop3Processed) else (goto MSGloop3Process)
:MSGloop3Process
pushd %WatchdogLoc%
::Creating Autorestart2h.bat script
echo.@echo off>AutoRestart2h.bat
echo.cls>>AutoRestart2h.bat
echo.:: \\ Function:>>AutoRestart2h.bat
echo.:: \\ To send warning message 2h,1h,30m,15m,2m,1m before server shutdown>>AutoRestart2h.bat
echo.:: \\^<-Edit these Settings to match your server configuration>>AutoRestart2h.bat
echo.:: \\ Configure location of rcon-cli tool: >>AutoRestart2h.bat
echo.set WatchdogLoc=%WatchdogLoc%>>AutoRestart2h.bat
echo REM ------------------------------------------------------------------------------- >>AutoRestart2h.bat
echo :: ^<-DO not edit below this line^^! >>AutoRestart2h.bat
echo Pushd ^%%WatchdogLoc^%% >>AutoRestart2h.bat
echo echo. >>AutoRestart2h.bat
echo echo. >>AutoRestart2h.bat
echo echo 2 hours till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 2 Hours\"">>AutoRestart2h.bat
echo timeout /t 3600>>AutoRestart2h.bat
echo echo 1 hour till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 1 Hours\"">>AutoRestart2h.bat
echo timeout /t 1800>>AutoRestart2h.bat
echo echo 30 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 30 Minutes\"">>AutoRestart2h.bat
echo timeout /t 900>>AutoRestart2h.bat
echo echo 15 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 15 Minutes\"">>AutoRestart2h.bat
echo timeout /t 780>>AutoRestart2h.bat
echo echo 2 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 2 Minutes\"">>AutoRestart2h.bat
echo timeout /t 60>>AutoRestart2h.bat
echo echo 1 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 1 Minutes\"">>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Logout now or you risk file corruption^^!\"">>AutoRestart2h.bat
echo timeout /t 55>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server Restarting NOW^^!\"">>AutoRestart2h.bat
echo timeout /t 5>>AutoRestart2h.bat
echo rcon -c rcon.yaml "quit">>AutoRestart2h.bat
echo :: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License^^! >> AutoRestart2h.bat
echo :: \\ Created by Dimens - https://github.com/Dimens101/PG-Installerscript >> AutoRestart2h.bat
:MSGloop3Processed
cls
echo.
:Title_LoopA2O
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2O
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo		3. Create Auto-restart File.........................ACCEPTED
echo.
echo AutoRestart2h.bat created in %WatchdogLoc%
TIMEOUT 2 > nul
echo.
echo			Proceeding to Finish Script.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
goto EndofScript
:MSGloop4
cls
echo.
:Title_LoopA2P
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2P
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo.
echo		4. Create Auto-restart File 	^& Schedule it......ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 2 > nul
::Creating Autorestart2h.bat script
pushd %WatchdogLoc%
if exist "%WatchdogLoc%\AutoRestart2h.bat"\ (goto MSGloop3Processed) else (goto MSGloop3Process)
echo.@echo off>AutoRestart2h.bat
echo.cls>>AutoRestart2h.bat
echo.:: \\ Function:>>AutoRestart2h.bat
echo.:: \\ To send warning message 2h,1h,30m,15m,2m,1m before server shutdown>>AutoRestart2h.bat
echo.:: \\^<-Edit these Settings to match your server configuration>>AutoRestart2h.bat
echo.:: \\ Configure location of rcon-cli tool: >>AutoRestart2h.bat
echo.set WatchdogLoc=%WatchdogLoc%>>AutoRestart2h.bat
echo REM ------------------------------------------------------------------------------- >>AutoRestart2h.bat
echo :: ^<-DO not edit below this line^^! >>AutoRestart2h.bat
echo Pushd ^%%WatchdogLoc^%% >>AutoRestart2h.bat
echo echo. >>AutoRestart2h.bat
echo echo. >>AutoRestart2h.bat
echo echo 2 hours till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 2 Hours\"">>AutoRestart2h.bat
echo timeout /t 3600>>AutoRestart2h.bat
echo echo 1 hour till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 1 Hours\"">>AutoRestart2h.bat
echo timeout /t 1800>>AutoRestart2h.bat
echo echo 30 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 30 Minutes\"">>AutoRestart2h.bat
echo timeout /t 900>>AutoRestart2h.bat
echo echo 15 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 15 Minutes\"">>AutoRestart2h.bat
echo timeout /t 780>>AutoRestart2h.bat
echo echo 2 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 2 Minutes\"">>AutoRestart2h.bat
echo timeout /t 60>>AutoRestart2h.bat
echo echo 1 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 1 Minutes\"">>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Logout now or you risk file corruption^^!\"">>AutoRestart2h.bat
echo timeout /t 55>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server Restarting NOW^^!\"">>AutoRestart2h.bat
echo timeout /t 5>>AutoRestart2h.bat
echo rcon -c rcon.yaml "quit">>AutoRestart2h.bat
echo :: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License^^! >> AutoRestart2h.bat
echo :: \\ Created by Dimens - https://github.com/Dimens101/PG-Installerscript >> AutoRestart2h.bat
schtasks /Create /TR %WatchdogLoc%\AutoRestart2h.bat /RU %USERNAME% /TN Restart_at_0200 /SC DAILY /ST 02:00 /IT
cls
echo.
:Title_LoopA2Q
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2Q
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo.
echo		4. Create Auto-restart File 	^& Schedule it......ACCEPTED
echo.
echo		AutoRestart2h.bat created Scheduled
TIMEOUT 2 > nul
echo.
echo			Proceeding to Finish Script.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
goto EndofScript
:MSGloop5
cls
echo.
:Title_LoopA2R
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2R
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo.
echo.
echo		5. Choose 2 And 4...................................ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 2 > nul
pushd %WatchdogLoc%
if exist "%WatchdogLoc%\WelcomeMSG.bat"\ (goto MSGloop5Processed) else (goto MSGloop5Process)
:MSGloop5Process
::Creating WelcomeMSG.bat script
echo.@echo off>WelcomeMSG.bat
echo.cls>>WelcomeMSG.bat
echo.:: \\ Function:>>WelcomeMSG.bat
echo.:: \\ Used to send a Custom message you can edit>>WelcomeMSG.bat
echo.:: \\^<-Edit these Settings to match your server configuration>>WelcomeMSG.bat
echo.:: \\ Configure location of rcon-cli tool: >>WelcomeMSG.bat
echo.set WatchdogLoc=%WatchdogLoc%>>WelcomeMSG.bat
echo set WelcomMSG="Welcome to my TestServer">> WelcomeMSG.bat
echo set DiscordMSG="https://discord.gg/BKqWjKEK">> WelcomeMSG.bat
echo REM ------------------------------------------------------------------------------- >> WelcomeMSG.bat
echo :: ^<-DO not edit below this line^^! >> WelcomeMSG.bat
echo Pushd ^%%WatchdogLoc^%% >> WelcomeMSG.bat
echo echo. >> WelcomeMSG.bat
echo echo. >> WelcomeMSG.bat
echo echo Sending welcome msg >> WelcomeMSG.bat
echo rcon -c rcon.yaml "servermsg \%%WelcomMSG%%" >> WelcomeMSG.bat
echo TIMEOUT /T 2 >> WelcomeMSG.bat
echo echo Sending discord Channel >> WelcomeMSG.bat
echo rcon -c rcon.yaml "servermsg \%%DiscordMSG%%" >> WelcomeMSG.bat
echo TIMEOUT /T 2 >> WelcomeMSG.bat
echo exit >> WelcomeMSG.bat
echo :: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License^^! >> WelcomeMSG.bat
echo :: \\ Created by Dimens101 - https://github.com/Dimens101/PG-Installerscript >> WelcomeMSG.bat
:MSGloop5Processed
TIMEOUT 2 > nul
if exist "%WatchdogLoc%\AutoRestart2h.bat"\ (goto MSGloop5Processed2) else (goto MSGloop5Process2)
:MSGloop5Process2
::Creating Autorestart2h.bat script
pushd %WatchdogLoc%
echo.@echo off>AutoRestart2h.bat
echo.cls>>AutoRestart2h.bat
echo.:: \\ Function:>>AutoRestart2h.bat
echo.:: \\ To send warning message 2h,1h,30m,15m,2m,1m before server shutdown>>AutoRestart2h.bat
echo.:: \\^<-Edit these Settings to match your server configuration>>AutoRestart2h.bat
echo.:: \\ Configure location of rcon-cli tool: >>AutoRestart2h.bat
echo.set WatchdogLoc=%WatchdogLoc%>>AutoRestart2h.bat
echo REM ------------------------------------------------------------------------------- >>AutoRestart2h.bat
echo :: ^<-DO not edit below this line^^! >>AutoRestart2h.bat
echo Pushd ^%%WatchdogLoc^%% >>AutoRestart2h.bat
echo echo. >>AutoRestart2h.bat
echo echo. >>AutoRestart2h.bat
echo echo 2 hours till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 2 Hours\"">>AutoRestart2h.bat
echo timeout /t 3600>>AutoRestart2h.bat
echo echo 1 hour till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 1 Hours\"">>AutoRestart2h.bat
echo timeout /t 1800>>AutoRestart2h.bat
echo echo 30 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 30 Minutes\"">>AutoRestart2h.bat
echo timeout /t 900>>AutoRestart2h.bat
echo echo 15 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 15 Minutes\"">>AutoRestart2h.bat
echo timeout /t 780>>AutoRestart2h.bat
echo echo 2 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 2 Minutes\"">>AutoRestart2h.bat
echo timeout /t 60>>AutoRestart2h.bat
echo echo 1 minutes till restarting of servers...>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server will restart in 1 Minutes\"">>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Logout now or risk file corruption^^!\"">>AutoRestart2h.bat
echo timeout /t 55>>AutoRestart2h.bat
echo rcon -c rcon.yaml "servermsg \"Server Restarting NOW^^!\"">>AutoRestart2h.bat
echo timeout /t 5>>AutoRestart2h.bat
echo rcon -c rcon.yaml "quit">>AutoRestart2h.bat
echo :: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License^^! >> AutoRestart2h.bat
echo :: \\ Created by Dimens101 - https://github.com/Dimens101/PG-Installerscript >> AutoRestart2h.bat
:MSGloop5Processed2
cls
echo.
:Title_LoopA2S
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2S
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo.
echo.
echo		5. Choose 2 And 4...................................ACCEPTED
echo.
echo		   Finished creating files in %WatchdogLoc%
echo.
echo.
echo.
echo.
echo.
echo.
echo.	
TIMEOUT 5 > nul
schtasks /Create /TR %WatchdogLoc%\WelcomeMSG.bat /RU %USERNAME% /TN Launch_WelcomeMSG_2H /SC HOURLY /MO 2 /IT
TIMEOUT 1 > nul
schtasks /Create /TR %WatchdogLoc%\AutoRestart2h.bat /RU %USERNAME% /TN Restart_at_0200 /SC DAILY /ST 02:00 /IT
TIMEOUT 2 > nul
cls
echo.
:Title_LoopA2T
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2T
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-2"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--21-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo.
echo.
echo		5. Choose 2 And 4...................................ACCEPTED
echo.
echo		   Finished creating files in %WatchdogLoc%
echo		   Finished scheduling files
TIMEOUT 2 > nul
echo.
echo		   Proceeding to Finish Script.	
echo.
echo.
echo.
TIMEOUT 5 > nul
goto EndofScript
:MSGloop6
cls
echo.
:Title_LoopA2U
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA2U
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Setup options Scheduled Messages:
echo.
echo.
echo.
echo.
echo.
echo.
echo		6. Create no extra Files............................ACCEPTED
TIMEOUT 2 > nul
echo.
echo			Proceeding to Finish Script.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 7 > nul
goto EndofScript

:EndofScript

If "%AdminTool%"=="No" goto EndofScriptFinal
If "%AdminTool%"=="Yes" goto InstallZomboidAdmin

:InstallZomboidAdmin
::Download and installation of Zomboid Admin Tool
%BaseColor%
echo		Use Admintools Option 	= Yes
echo.
if exist "C:\Games\PZServer\Watchdog\ZomboidRCON" (goto DownloadTools) else (goto InstallZomboidAdminStart)
:InstallZomboidAdminStart
cls
%ColorRed%
echo.
:Title_Loop83
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo		Creating Schedule Tasks.............................FINISHED
echo		Setup Scheduled Messages............................FINISHED
echo.
echo		Zomboid Admin Tools Installation...................NOT FOUND
echo.
TIMEOUT 7 > nul
%BaseColor%
echo			Create Download temp..
echo.
echo.
echo.
timeout 2 > nul
::Create Download temp

IF NOT EXIST %ServerPath%\Dump (
Mkdir %ServerPath%\Dump
)
Set WORKSPACE=%ServerPath%\Dump
IF NOT EXIST %WatchdogLoc%\ZomboidRCON (
Mkdir %WatchdogLoc%\ZomboidRCON
)
cls
echo.
:Title_Loop83A
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo		Creating Schedule Tasks.............................FINISHED
echo		Setup Scheduled Messages............................FINISHED
echo.
echo		Zomboid Admin Tools Installation...................NOT FOUND
echo.
echo		    Create Download temp............................FINISHED
TIMEOUT 1 > nul
echo			Downloading..
echo.
echo.
timeout 2 > nul
::Download program
%ColorBlue%
bitsadmin.exe /transfer replica /priority FOREGROUND "https://github.com/kwmx/ZomboidRCON/releases/download/v1.0.3/ZomboidRCON.zip" %WORKSPACE%\dump_data2.zip
TIMEOUT 1 > nul
bitsadmin.exe /transfer replica /priority FOREGROUND "https://download.visualstudio.microsoft.com/download/pr/bf058765-6f71-4971-aee1-15229d8bfb3e/c3366e6b74bec066487cd643f915274d/windowsdesktop-runtime-6.0.1-win-x64.exe" %WORKSPACE%\windowsdesktop-runtime-6.0.1-win-x64.exe
cls
%BaseColor%
echo.
:Title_Loop83B
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo		Creating Schedule Tasks.............................FINISHED
echo		Setup Scheduled Messages............................FINISHED
echo.
echo		Zomboid Admin Tools Installation...................NOT FOUND
echo.
echo		    Create Download temp............................FINISHED
echo		    Downloading.....................................FINISHED
TIMEOUT 1 > nul
echo		    Extracting and Installing.. 
echo			Please Accept Elevated Prompt for .NET Runtime Install
timeout 4 > nul
::Extract program
Call %WORKSPACE%\windowsdesktop-runtime-6.0.1-win-x64.exe /install /quiet /norestart
TIMEOUT 1 > nul
Call :UnZipFile3 "%WatchdogLoc%\ZomboidRCON" "%WORKSPACE%\dump_data2.zip"
:UnZipFile3Go
:Title_Loop83F
cls
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83F
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo		Creating Schedule Tasks.............................FINISHED
echo		Setup Scheduled Messages............................FINISHED
echo.
echo		Zomboid Admin Tools Installation.......................FOUND
echo.
echo		    Create Download temp............................FINISHED
echo		    Downloading.....................................FINISHED
echo		    Extracting and Installing.......................FINISHED
echo		    Cleaning up files..
TIMEOUT 2 > nul
::Cleanup Files
rmdir /s /q %ServerPath%\Dump

:Title_Loop83G
cls
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83G
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo		Creating Schedule Tasks.............................FINISHED
echo		Setup Scheduled Messages............................FINISHED
echo.
echo		Zomboid Admin Tools Installation.......................FOUND
echo.
echo		    Create Download temp............................FINISHED
echo		    Downloading.....................................FINISHED
echo		    Extracting and Installing.......................FINISHED
echo		    Cleaning up files...............................FINISHED
TIMEOUT 5 > nul
goto EndofScriptFinal

:EndofScriptFinal
::Give proper exit list
if exist "%WatchdogLoc%\ZomboidRCON" (goto EndofScriptZOM) else (goto EndofScriptNOZOM)

:EndofScriptZOM
::End of Script and warning it will auto-start PZ_Watchdog.bat after which it will close itself.
:Title_LoopA5B
cls
echo.
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo		Creating Schedule Tasks.............................FINISHED
echo		Setup Scheduled Messages............................FINISHED
echo		Zomboid Admin Tools Installation.......................FOUND
echo.
echo		Finished installing the PG Server
echo.
echo		Script will now open 'PZ_Watchdog.bat' in a new window..
Timeout 1 > nul
echo		This Window Will now Close Automatically.
TIMEOUT 1 > nul
set /a counter1=%counter1%+1
if %counter1% equ 18 goto EndofScriptcredit
goto EndofScriptZOM

:EndofScriptNOZOM
::End of Script and warning it will auto-start PZ_Watchdog.bat after which it will close itself.
cls
echo.
:Title_LoopA5A
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo		Java Installation......................................FOUND
echo		Remaining Tools........................................FOUND
echo		Adding the firewall rules...........................FINISHED
echo		Steam Installation..................................FINISHED
echo		Configuring Pre-Auto Change Config values...........FINISHED
echo		Staging Server starting.............................FINISHED
echo		Configuring Post-Auto Change Config values..........FINISHED
echo 		Creating Schedule Tasks.............................FINISHED
echo		Setup Scheduled Messages............................FINISHED
echo.
echo		Finished installing the PG Server
echo.
echo		Script will now open 'PZ_Watchdog.bat' in a new window..
Timeout 1 > nul
echo		This Window Will now Close Automatically.
echo.
echo.
TIMEOUT 7 > nul
set /a counter2=%counter2%+1
if %counter2% equ 18 goto EndofScriptcredit
goto EndofScriptNOZOM

:EndofScriptcredit
::End Credits
cls
%ColorYellow%
echo.
:Title_LoopA5B
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo.
echo.
echo     Thank you for using Project Zomboid Installscript^!
echo     https://steamcommunity.com/profiles/76561198020468907/
echo.
TIMEOUT 1 > nul
echo		%lineA4%
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
Pushd %WatchdogLoc%
start "Project_Zomboid_%servername%_Watchdog" /High /I PZ_Watchdog.bat 
endlocal
exit

:ERRORENC
cls
%ColorRed%
:Title_LoopA5C
cls
echo.
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		PZ_Installscript.bat......................NOT FOUND 
echo.
echo		- Installer closing
echo.
echo.
Timeout 1 > nul
echo		Please put the file 'PZ_Installscript.bat' 
echo		in the %WatchdogLoc% folder
echo		and start it again.
echo.
echo.
echo.
Timeout 2 > nul
set /a counter3=%counter3%+1
if %counter3% equ 18 goto EndofScriptClean
goto Title_LoopA5C

:ERRORENC1
cls
%ColorRed%
:Title_LoopA5D
cls
echo.
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		PZ_Watchdog.bat...........................NOT FOUND 
echo.
echo		- Installer closing
echo.
echo.
Timeout 1 > nul
echo		Please put the file 'PZ_Watchdog.bat' 
echo		in the %WatchdogLoc% folder
echo		and start it again.
echo.
echo.
echo.
Timeout 2 > nul
set /a counter4=%counter4%+1
if %counter4% equ 18 goto EndofScriptClean
goto Title_LoopA5D

:EndofScriptClean
cls
%ColorYellow%
echo.
:Title_LoopA5B
cls
%ColorYellow%
echo.
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo.
echo.
echo     Thank you for using Project Zomboid Installscript^!
echo     https://steamcommunity.com/profiles/76561198020468907/
echo.
TIMEOUT 1 > nul
echo		%lineA4%
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
endlocal
exit

:: \\ Big Thanks to kwmx from https://github.com/kwmx/ZomboidRCON for the ZomboidRCON tool under MIT License!
:: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License!

:: \\ Created by Dimens - https://github.com/Dimens101/PG-Installerscript
:: \\ https://steamcommunity.com/profiles/76561198020468907/ 


