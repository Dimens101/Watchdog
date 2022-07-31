set Counter69=10
:NOTYET
cls
@ECHO OFF
color 0C
echo.
echo.
echo.
echo.
Timeout 1 > nul
echo			Please run PZ_Installscript.bat first^!
TIMEOUT 1 > nul
set /a counter69=%counter69%+1
if %counter69% equ 15 goto :EOF:
goto NOTYET

:StartFullScript
set ServerConfig=%userprofile%\Zomboid
set LogPath=%ServerPath%\logs
set WatchdogLoc=%ServerPath%\Watchdog
set logfile=%logPath%\rcon-default.log
set ZATPath="%WatchdogLoc%\ZomboidRCON\"
set filePZini=%ServerConfig%\Server\%servername%.ini
set rcontype=rcon
set PZModsLoc=%ServerConfig%\mods
set workspace=%ServerPath%\Dump
set workspace1=%ServerPath%\PZClient
:: // Firewall Rules adjusting for 30 players
set /A Serverport1=%serverport%+30
:: // Steam Install Details
set steamlogin=anonymous
set PZserverBRANCH=380870
set steampath=%ServerPath%\Steamcmd
:: // Not USED Items
set steamlogin=anonymous
set SteamLoginFULL=%SteamUser% %SteamPassword%
set PZserverBRANCH=380870
set PZClientBRANCH=108600
set steampath=%ServerPath%\Steamcmd
set WorkShopIDSteam=%WorkshopID:;= %
::  Import IP address automatically or can remove '%ip:~1%' and input ip manually
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set serverip=%ip:~1%
:: // Configure Text color (set to 0F for white text) using 08 here to distinguish from other cmd windows.
set BaseColor=color 0F
:: Errors
Set ColorRed=color 0C
Set ColorDRed=color 04
:: Effects
set ColorWhit=color 07
set ColorGray=color 08
:: Download
set ColorLBlue=color 09
:: FileRemoval
set ColorLPurple=color 0D
:: Fixxed Errors
Set ColorGreen=color 0A
:: Log Rotation
set ColorAqua=Color 0B
:: End of Script
Set ColorYellow=color 0E
:: // Counter for warnings
set counter=15
:: // Configure Names for Projects
set "spaces=                              "
set "STR[1]=^> PZ Watchdog"
set "STR[2]=^> Log rotation"
set "STR[3]=^> Steam Update"
set "STR[4]=^> Start Project Zomboid"
set "STR[5]=^> Start Zomboid Admin Tool"
set "STR[6]=^> PZ Monitor"
set "STR[6A]=^> PZ Optionmenu"
set "STR[7]=^> PZ Stop^/restart"
set "STR[9]=^Server Info"
set "STR[A2]=^> Download RCON-CLI"
set "STR[A5]=^> Download Zomboid Admin Tool"
set "STR[A3]=^> Close Server"
set "STR[A4]=Dimens"
set "TGB[A6]=Protecting Server: [ %servername% ] from crashes"
set "line=%spaces%"
set "line2=%line:~0,22%- %STR[2]%"
set "line3=%line:~0,22%- %STR[3]%"
set "line4=%line:~0,22%- %STR[4]%"
set "line5=%line:~0,22%- %STR[5]%"
set "line6=%line:~0,22%- %STR[6]%"
set "line6A=%line:~0,22%- %STR[6A]%"
set "line7=%line:~0,22%- %STR[7]%"
set "line9=%line:~0,22%- %STR[9]%"
set "lineA2=%line:~0,22%- %STR[A2]%"
set "lineA3=%line:~0,22%- %STR[A3]%"
set "lineA4=%line:~0,20% %STR[A4]%"
set "lineA5=%line:~0,21% %TGB[A5]%"
set "lineA6=%line:~0,12% %TGB[A6]%"
set "SIZE=70"
set "SIZE2=-75"
set "SIZE3=30"
set "LEN=0"
set "LEN1=0"
:: Declare how date / time should be handled.
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
	set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
	set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
	set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%" & set "fullstamp=%YYYY%-%MM%-%DD%_%HH%%Min%-%Sec%" & set "timestampMIN=%HH%:%Min%"
:: // Set CMD Window Title
Title Project Zomboid Watchdog ^for %servername% Online

goto RunWatchdog

:RunWatchdog
cls
%BaseColor%
echo.
:Title_Loop1A
if not "!!STR[1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop1A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.					
echo %line2%		   	   Timestamp:
echo %line3%
echo %line4%		    Date=
echo %line5%	    YYYYMMDD
echo %line6%
echo %line6A%		    	    Time=
echo %line7%		    HHMMSS
echo.	
echo %line9%
echo.
echo		 Edit Server Settings in = %ServerConfig%\Server
echo		    View console logs in = %ServerConfig%\Logs
TIMEOUT 8 > nul
::Cleanup Installscript file
pushd %WatchdogLoc%
Del /q PZ_Installscript.bat
If "%OpenFolders%"=="Yes" goto OpenLogDir
If "%OpenFolders%"=="No" goto RunWatchdogList
:OpenLogDir
echo			Opening LOGS now Minimized...
echo.
Start /MIN %SystemRoot%\explorer.exe "%ServerConfig%\Server"
Start /MIN %SystemRoot%\explorer.exe "%ServerConfig%\Logs"
echo.
echo.
timeout 2 > nul
:RunWatchdogList
::List with operations script will cycle trough 
cls
%BaseColor%
echo.
:Title_Loop1A
if not "!!STR[1]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop1A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[1]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.					
echo			1 - Start Log Backup (Clean up logs)
echo.
echo			2 - Run Program Checks
echo.
echo			3 - Start Steam Mod Update    (Default=No)
echo			    Start Steam Server Update (Default=No)
echo.
echo			4 - Update Game config and startup files
echo.
echo			5 - Start Server
echo			    Start Zomboid Admin tool  (Optional)
echo.
echo			6 - Start Watchdog monitor
echo.
echo			^* - Server OFFLINE detected = loop to Step 1
echo.
Timeout 10 > nul
goto logrotation

:SteamUpdateCheck
::Check if Quit file is present
if exist "%WatchdogLoc%\quit.bat" (goto SteamUpdateCheck1) else (goto DLandINSTquit3)
:SteamUpdateCheck1
::Check if SteamCMD.exe file is present
if exist "%steampath%\steamcmd.exe" (goto SteamUpdateCheck2) else (goto SteamUpdateAnnoCMD)
:SteamUpdateCheck2
::Check if JAVA process is running
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
if "%ERRORLEVEL%"=="0" goto AdmintoolsCheck
if "%ERRORLEVEL%"=="1" goto SteamUpdate
:SteamUpdateAnnoCMD
CLS
%ColorRed%
echo.
:Title_Loop3C1
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3C1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Steam Command Line Tool..............................NOT FOUND
TIMEOUT 2 > nul
echo.
echo		Downloading now..
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
echo.
::Create Program directory
IF NOT EXIST %ServerPath%\steamcmd (
Mkdir %ServerPath%\steamcmd
)
::Create Dump directory
IF NOT EXIST %ServerPath%\Dump (
Mkdir %ServerPath%\Dump
)
Set WORKSPACE=%ServerPath%\Dump
TIMEOUT 1 > nul
%ColorLBlue%
::Download SteamCMD
bitsadmin.exe /transfer replica /priority FOREGROUND "http://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip" %WORKSPACE%\dump_data1.zip
%ColorRed%
TIMEOUT 1 > nul
::Extract files
Call :UnZipFile "%steampath%" "%WORKSPACE%\dump_data1.zip"
TIMEOUT 1 > nul
::Cleanup Dump directory
rmdir /s /q %ServerPath%\Dump
Timeout 3 > nul
:Title_Loop3C2
CLS
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3C2
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Steam Command Line Tool..............................NOT FOUND
TIMEOUT 2 > nul
echo.
echo		Downloading now.......................................FINISHED
Timeout 1 > nul
echo.
echo 		Checking if JAVA process is running..
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
::Check if Java is running 
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
if "%ERRORLEVEL%"=="0" goto WatchdogCheckloop1
if "%ERRORLEVEL%"=="1" goto SteamUpdate
goto SteamUpdate

WatchdogCheckloop1
:Title_Loop3C3
CLS
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3C3
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Steam Command Line Tool..............................NOT FOUND
TIMEOUT 2 > nul
echo.
echo		Downloading now.......................................FINISHED
Timeout 1 > nul
echo.
echo 		Checking if JAVA process is running......................FOUND
echo.
TIMEOUT 1 > nul
echo		Proceeding to Watchdog Monitor..
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
goto PZloop

WatchdogCheckloop2
:Title_Loop3C4
CLS
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3C4
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Steam Command Line Tool..............................NOT FOUND
TIMEOUT 2 > nul
echo.
echo		Downloading now.......................................FINISHED
Timeout 1 > nul
echo.
echo 		Checking if JAVA process is running..................NOT FOUND
echo.
TIMEOUT 1 > nul
echo		Proceeding to Steam update..
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
goto SteamUpdate


:SteamUpdate
::Check if AutoDownloadMods option is enabled or not 
If "%AutoDownloadMods%"=="No" goto SteamUpdateANNO
If "%AutoDownloadMods%"=="Yes" goto SteamUpdateUSER
:: // Check for any game or mod updates
:: _________________________________________________________
:SteamUpdateANNO
cls
%BaseColor%
echo.
:Title_Loop3x
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3x
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo Dir        : %ServerPath%
echo Steam Dir  : %steampath%
echo Branch     : %PZserverBRANCH%
echo.
echo			Project Zomboid server Update
echo.
echo			Do you want to update now?
echo.
echo	USING STEAM UPDATE WILL OVERWRITE ANY CHANGES IN 'options.ini'
echo.
choice /C YN /N /T:5 /D:N /M "[Y]es / [N]o (default)"
if %errorlevel%==1 goto SteamUpdateANNOSTART
if %errorlevel%==2 goto UpdateLists
goto DetailsINC
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
cls
:SteamUpdateANNOSTART
:Title_Loop3
cls
%BaseColor%
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo Dir        : %ServerPath%
echo Steam Dir  : %steampath%
echo Branch     : %PZserverBRANCH%
echo.
echo			Project Zomboid server Updating...
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
cls
%ColorLBlue%
::Update Server Files
%steampath%\steamcmd.exe +force_install_dir %ServerPath% +login %steamlogin% +"app_update %PZserverBRANCH%" validate +quit
cls
%BaseColor%
echo.
:Title_Loop3A
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo Dir        : %ServerPath%
echo Steam Dir  : %steampath%
echo Branch     : %PZserverBRANCH%
echo.
echo		Project Zomboid server Updating.......................FINISHED
echo.
TIMEOUT 2 > nul
echo		Updating %servername%.ini..
echo		Updating StartServer64.bat..
echo		Updating StartServer64_nosteam.bat...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul
goto UpdateLists

:UpdateLists
cls
%BaseColor%
echo.
:Title_Loop3A1x
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3A1x
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo.
echo.
echo		Project Zomboid server Config Updating..
echo.
TIMEOUT 2 > nul
echo		Updating %servername%.ini..
echo		Updating StartServer64.bat..
echo		Updating StartServer64_nosteam.bat...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5 > nul

:: Check if RCON exist, if so update config
if exist "%WatchdogLoc%\rcon.exe" (goto UpdatedRCONCFG) else (goto UpdateRCONCFG)
:UpdatedRCONCFG
::Updating Server.ini file with Mods if any new mods are added.
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
goto UpdateStartServerFile

:UpdateStartServerFile
cls
echo.
:Title_Loop3C
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo.
echo.
echo.
echo		Project Zomboid server Config Updating..
echo.
echo		Updating %servername%.ini.............................FINISHED
echo		Updating StartServer64.bat..
echo		Updating StartServer64_nosteam.bat..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set serverip=%ip:~1%
TIMEOUT 1 > nul
::Setup StartServer64.cmd file
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
echo.TIMEOUT 5 > nul>>StartServer64.bat
echo.pause>>StartServer64.bat
echo.exit>>StartServer64.bat
echo.:StartServer>>StartServer64.bat
echo.echo.Started at %%date%% %%time%%^>Started>>StartServer64.bat
echo.SET PZ_CLASSPATH=java/istack-commons-runtime.jar;java/jassimp.jar;java/javacord-2.0.17-shaded.jar;java/javax.activation-api.jar;java/jaxb-api.jar;java/jaxb-runtime.jar;java/lwjgl.jar;java/lwjgl-natives-windows.jar;java/lwjgl-glfw.jar;java/lwjgl-glfw-natives-windows.jar;java/lwjgl-jemalloc.jar;java/lwjgl-jemalloc-natives-windows.jar;java/lwjgl-opengl.jar;java/lwjgl-opengl-natives-windows.jar;java/lwjgl_util.jar;java/sqlite-jdbc-3.27.2.1.jar;java/trove-3.0.3.jar;java/uncommons-maths-1.2.3.jar;java/commons-compress-1.18.jar;java/>>StartServer64.bat
echo.".\jre64\bin\java.exe" -Djava.awt.headless=true -Dzomboid.steam=1 -Dzomboid.znetlog=1 -XX:+UseG1GC -XX:-CreateCoredumpOnCrash -XX:-OmitStackTraceInFastThrow -Xms%MemorySize%g -Xmx%MemorySize%g -Djava.library.path=natives/;natives/win64/;. -cp ^%%PZ_CLASSPATH^%% zombie.network.GameServer -port %serverport% -servername %servername% -statistic 0 ^%%1 ^%%2>>StartServer64.bat
echo.del /q started>>StartServer64.bat
echo.exit>>StartServer64.bat

echo.@ECHO off>StartServer64_nosteam.bat
echo.@setlocal enableextensions>>StartServer64_nosteam.bat
echo.@cd /d "%%~dp0">>StartServer64_nosteam.bat
echo.color 0A>>StartServer64_nosteam.bat
echo.cls>>StartServer64_nosteam.bat
echo.title Project_Zomboid_Server_%servername%_%serverip%_%serverport% Watchdog>>StartServer64_nosteam.bat
echo.tasklist /fi "imagename eq java.exe" /FO TABLE ^| find /i "java.exe">>StartServer64_nosteam.bat
echo.if "%%ERRORLEVEL%%"=="0" goto PZClose>>StartServer64_nosteam.bat
echo.if "%%ERRORLEVEL%%"=="1" goto StartServer>>StartServer64_nosteam.bat
echo.:PZClose>>StartServer64_nosteam.bat
echo.color 0C>>StartServer64_nosteam.bat
echo.^echo JAVA.EXE ALREADY RUNNING>>StartServer64_nosteam.bat
echo.TIMEOUT 5 > nul>>StartServer64_nosteam.bat
echo.pause>>StartServer64_nosteam.bat
echo.exit>>StartServer64_nosteam.bat
echo.:StartServer>>StartServer64_nosteam.bat
echo.echo.Started at %%date%% %%time%%^>Started>>StartServer64_nosteam.bat
echo.SET PZ_CLASSPATH=java/istack-commons-runtime.jar;java/jassimp.jar;java/javacord-2.0.17-shaded.jar;java/javax.activation-api.jar;java/jaxb-api.jar;java/jaxb-runtime.jar;java/lwjgl.jar;java/lwjgl-natives-windows.jar;java/lwjgl-glfw.jar;java/lwjgl-glfw-natives-windows.jar;java/lwjgl-jemalloc.jar;java/lwjgl-jemalloc-natives-windows.jar;java/lwjgl-opengl.jar;java/lwjgl-opengl-natives-windows.jar;java/lwjgl_util.jar;java/commons-compress-1.18.jar;java/sqlite-jdbc-3.27.2.1.jar;java/trove-3.0.3.jar;java/uncommons-maths-1.2.3.jar;java/>>StartServer64_nosteam.bat
>>StartServer64_nosteam.bat echo.".\jre64\bin\java.exe" -Djava.awt.headless=true -Dzomboid.steam=0 -Dzomboid.znetlog=1 -XX:+UseG1GC -XX:-CreateCoredumpOnCrash -XX:-OmitStackTraceInFastThrow -Xms%MemorySize%g -Xmx%MemorySize%g -Djava.library.path=natives/;natives/win64/;. -cp ^%%PZ_CLASSPATH^%% zombie.network.GameServer -port %serverport% -servername %servername% -statistic 0
echo.del /q started>>StartServer64_nosteam.bat
echo.exit>>StartServer64_nosteam.bat
goto SteamUpdateEND


:SteamUpdateEND
cls
echo.
:Title_Loop3C
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo.
echo.
echo.
echo		Project Zomboid server Config Updating................FINISHED
echo.
echo		Updating %servername%.ini.............................FINISHED
echo		Updating StartServer64.bat............................FINISHED
echo		Updating StartServer64_nosteam.bat....................FINISHED
echo.
TIMEOUT 4 > nul
echo		Proceeding to Start Project Zomboid Server %servername%
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
goto StartServer

:SteamUpdateUSER

:Title_Loop3B1x
cls
%BaseColor%
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B1x
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6% 
echo.
echo PZ Mods     : %ServerPath%
echo SteamCMD Dir: %steampath%
echo PZ Client   : %WORKSPACE1%
echo Branch      : %PZClientBRANCH%
echo SteamUser   : %SteamUser%
echo SteamPass   : %SteamPassword%
echo BranchMods  : %WorkShopIDSteam%
echo.
echo			Project Zomboid Mods Updating...
echo.
echo			Do you want to update now?
echo.
choice /C YN /N /T:10 /D:N /M "[Y]es / [N]o (default)"
if %errorlevel%==1 goto SteamUpdateUSERSTART
if %errorlevel%==2 goto SteamUpdateANNO
goto SteamUpdateANNO
:: // Check for any game or mod updates
:: _________________________________________________________
:SteamUpdateUSERSTART
:Title_Loop3B1
cls
%BaseColor%
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo PZ Mods     : %ServerPath%
echo SteamCMD Dir: %steampath%
echo PZ Client   : %WORKSPACE1%
echo Branch      : %PZClientBRANCH%
echo SteamUser   : %SteamUser%
echo SteamPass   : %SteamPassword%
echo BranchMods  : %WorkShopIDSteam%
echo.
echo			Project Zomboid Mods Updating...
echo.
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 7 > nul
cls
IF NOT EXIST %ServerConfig%\mods (
Mkdir %ServerConfig%\mods
)
IF NOT EXIST %WORKSPACE1% (
Mkdir %WORKSPACE1%
)
TIMEOUT 5 > nul
%ColorLBlue%
::Update Mods Files (it will download FULL client and move mods from client to Server directory)
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

:Title_Loop3B2
cls
%BaseColor%
echo.
if not "!!STR[3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop3B2
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-2-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo PZ Mods     : %ServerPath%
echo SteamCMD Dir: %steampath%
echo PZ Client   : %WORKSPACE1%
echo Branch      : %PZClientBRANCH%
echo SteamUser   : %SteamUser%
echo SteamPass   : %SteamPassword%
echo BranchMods  : %WorkShopIDSteam%
echo.
echo			Project Zomboid Mods Updating............FINISHED
echo.
TIMEOUT 1 > nul
echo Mods Located in: '%PZModsLoc%'
echo.
echo.
echo.
echo.
echo.
TIMEOUT 7 > nul
goto SteamUpdateANNO

:StartServer
cls
%ColorWhit%
echo.
:Title_Loop4A1
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4A1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo				Which version to start:
echo.
echo			1. Start Project Zomboid (Steam Version)   - Default
echo			2. Start Project Zomboid (NO Steam Version)
echo.
:: Change /D:1 to /D:2 if you want Project Zomboid (NO Steam Version) as Default option..
choice /C:12 /N /T:10 /D:1 /M:"		Type your answer: "
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :StartServerSteam
if %ERRORLEVEL%==2 call :StartServerNoSteam
goto PZloop

:StartServerSteam
:: // Opening new window to start PZ server script
:: _________________________________________________________
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set serverip=%ip:~1%
cls
%BaseColor%
echo.
:Title_Loop4A2
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4A2
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting...
pushd %ServerPath%
start "Project_Zomboid_Server_%servername%_%serverip%_%serverport%" /D %ServerPath% /High /I StartServer64.bat 
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
TIMEOUT 2 > nul
Goto StartServerFinish

:StartServerNoSteam
:: // Opening new window to start PZ server script
:: _________________________________________________________
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set serverip=%ip:~1%
cls
%BaseColor%
echo.
:Title_Loop4A3
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4A3
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting...
pushd %ServerPath%
start "Project_Zomboid_SRV_NOSTEAM_%servername%_%serverip%_%serverport%" /D %ServerPath% /High /I StartServer64_nosteam.bat
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
TIMEOUT 2 > nul
Goto StartServerFinish

:StartServerFinish
cls
%ColorWhit%
echo.
:Title_Loop4A
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting..
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
TIMEOUT 2 > nul
cls
%ColorGray%
echo.
:Title_Loop4B
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting...
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
TIMEOUT 2 > nul
cls
%ColorWhit%
echo.
:Title_Loop4C
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting..
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
TIMEOUT 2 > nul
cls
%ColorGray%
echo.
:Title_Loop4D
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting...
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
TIMEOUT 2 > nul
cls
%ColorWhit%
echo.
:Title_Loop4E
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting..
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
TIMEOUT 2 > nul
cls
%ColorGray%
echo.
:Title_Loop4F
if not "!!STR[4]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop4F
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[4]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		Project_Zomboid_Server_%servername%_%serverip%_%serverport%
echo.
echo		starting...
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



REM //-------------------------------------------------------------------\\
::									STARTUP TIMER

:: !!! Can reduce this timer to make the watchdog start faster if your JAVA Server bootup is quick !!!

TIMEOUT /T 30

REM \\-------------------------------------------------------------------//

 
:: // Check if Zomboid RCON Admin Tool status
:: _________________________________________________________
goto AdmintoolsCheck

:AdmintoolsCheck
::Check if AdminTool option is enabled (If so it will See if ZAT is present if not download it.
If "%AdminTool%"=="No" goto PZloop
If "%AdminTool%"=="Yes" goto CheckZat

:CheckZat
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
echo.
echo		(%datestamp%) (%timestamp%) Waiting for Project Zomboid Server to start.
echo.
TIMEOUT 2 > nul
echo		Starting Zomboid Admin Tool..
echo.
TIMEOUT 1 > nul
if exist "%WatchdogLoc%\ZomboidRCON\ZomboidRCON.exe" (goto CheckZatProcess) else (goto DLandINSTzomboidrcon)
:CheckZatProcess
echo		Program Directory........................................FOUND
echo.
TIMEOUT 3 > nul
:: Check if Zomboid Admin Tool is running to kill it
tasklist /fi "imagename eq ZomboidRCON.exe" /FO TABLE | find /i "ZomboidRCON.exe"
if "%ERRORLEVEL%"=="0" goto KillZAT
if "%ERRORLEVEL%"=="1" goto StartZAT
TIMEOUT > 1 nul
Goto CheckZat

:KillZAT
%ColorRed%
cls
echo.
:Title_Loop5A
if not "!!STR[5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop5A
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
echo.
echo		(%datestamp%) (%timestamp%) Waiting for Project Zomboid Server to start.
echo.
echo		Starting Zomboid Admin Tool..
echo.
echo		Program Directory........................................FOUND
TIMEOUT 1 > nul
echo.
echo		Program already running...............................DETECTED
echo.
echo		Closing ZAT..
echo.
TIMEOUT 4 > nul
:: Kill Zomboid Admin tool if it is running
START /wait taskkill /f /im ZomboidRCON.exe
goto CheckZat

:StartZAT
cls
%BaseColor%
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
echo.
echo		(%datestamp%) (%timestamp%) Waiting for Project Zomboid Server to start.
echo.
echo		Starting Zomboid Admin Tool..
echo.
echo		Program Directory........................................FOUND
TIMEOUT 4 > nul
start "Zomboid Admin Tool Starting" /D %ZATPath% ZomboidRCON.exe
echo.
echo		Program Starting......................................FINISHED
echo.
echo		Login data:
echo.
echo		IP:       %serverip%
echo		Port:     %reconport%
echo		Password: %reconpass%
echo.
echo			Proceeding to start Watchdog montior..
TIMEOUT 30 > nul
goto PZloop

:PZloop
:: // Project Zomboid Watchdog loop
:: _________________________________________________________
:: Declare how date / time should be handled.
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
	set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
	set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
	set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%" & set "fullstamp=%YYYY%-%MM%-%DD%_%HH%%Min%-%Sec%" & set "timestampMIN=%HH%:%Min%"
cls
%BaseColor%
echo.
:Title_Loop6
if not "!!STR[6]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-10"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%--13-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid Status: Watchdog Active (%timestampMIN%)
echo.
echo         %servername%- %Serverip% - %serverport%
echo.
::Checking if Java is still running
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions
:PZloopOptions
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo			1. Shutdown Server                    ^|
echo			2. Shutdown Server And Close Watchdog ^|-----[RCON login]-------
echo			3. Send Message                       ^| IP:       %serverip%
echo			4. Reset Time (Water^&Power)           ^| Port:     %reconport%
echo			5. Create or Restore Backup           ^| Password: %reconpass%
echo			6. Logs ^& Server Settings             ^|------------------------
echo			7. Remove Game                        ^| 
echo.
choice /C:12345678 /N /T:10 /D:8 /M:"        Type your answer: "
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :PZloop1
if %ERRORLEVEL%==2 call :PZloop2
if %ERRORLEVEL%==3 call :PZloop3
if %ERRORLEVEL%==4 call :PZloop4
if %ERRORLEVEL%==5 call :PZloop5
if %ERRORLEVEL%==6 call :PZloop6
if %ERRORLEVEL%==7 call :PZloop7
if %ERRORLEVEL%==8 call :PZloop
goto PZloop
:PZloopq
goto PZloop

:PZloop1
::Quit the server option menu
cls
echo.
:Title_Loop6a
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6a
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
Pushd %WatchdogLoc%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions1
:PZloopOptions1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo			1. Quit Server....................................ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo			1. Shutdown Clean (Send Shutdown Signal with RCON)-default
echo			2. Shutdown Dirty (Kill Java Process)
echo			3. Go back..
echo.
choice /C:123 /N /T:15 /D:3 /M:"		Type your answer: "
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :PZloop1Process
if %ERRORLEVEL%==2 call :PZloop1Process2
if %ERRORLEVEL%==3 call :PZloop
goto PZloop
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop1Process) else (goto DLandINSTrcon)
:PZloop1Process
::Stop the server Clean with no risk of corruption
echo			rcon-cli FOUND
echo.
echo			Sending shutdown command..
TIMEOUT 2 > nul
echo Server:
rcon -c rcon.yaml "quit"
echo.
echo			Server is Shutting down
echo.
echo			Watchdog will Detect and restart......
START /wait taskkill /f /im ZomboidRCON.exe
TIMEOUT 5 > nul
goto PZloop
:PZloop1Process2
::Stop the server Dirty with risk of corruption
echo			Terminating Java Process..
echo.
START /wait taskkill /f /im Java.exe
TIMEOUT 1 > nul
echo.
echo			Java Process Terminated
echo.
echo			Watchdog will Detect and restart......
START /wait taskkill /f /im ZomboidRCON.exe
TIMEOUT 5 > nul
goto PZloop
:PZloop2
cls
echo.
:Title_Loop6b
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6b
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
Pushd %WatchdogLoc%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions2
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions2
:PZloopOptions2
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo			2. Quit Server And Watchdog.......................ACCEPTED
echo.
echo.
echo			   Are you Sure^?
echo			1. Yes
echo			2. No
echo.
choice /C:12 /N /T:10 /D:2 /M:"		Type your answer: "
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :PZloopOptions2a
if %ERRORLEVEL%==2 call :PZloop
goto PZloop
:PZloopOptions2a
::Check if Rcon tool was removed or we cannot clean exit
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop2Process) else (goto DLandINSTrcon)
:PZloop2Process
echo			rcon-cli FOUND
echo.
echo			Sending shutdown command in 5 seconds
TIMEOUT 5 > nul
echo Server:
rcon -c rcon.yaml "quit"
echo.
TIMEOUT 1 > nul
echo			Server is Shutting down
echo.
echo.
echo.
::Close Zomboid admin tool
START /wait taskkill /f /im ZomboidRCON.exe
TIMEOUT 5 > nul
:Title_Loop6ba
cls
echo.
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6ba
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
Pushd %WatchdogLoc%
echo.
echo.
echo			Watchdog will now close...
echo.
echo			      Server Status:
echo.
Timeout 1 > nul
echo			         Online
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 3 > nul
if exist "%ServerPath%\Started" (goto Title_Loop6ba) else (goto Title_Loop6b)
:Title_Loop6b
cls
echo.
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6b
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
Pushd %WatchdogLoc%
echo.
echo.
echo			Watchdog will now close...
echo.
echo			      Server Status:
echo.
Timeout 1 > nul
echo			         Offline
echo.
echo.
echo.
echo.
echo.
echo.
TIMEOUT 6 > nul
goto CloseWatchdog
:PZloop3
cls
echo.
:Title_Loop6c
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6c
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
Pushd %WatchdogLoc%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions3
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions3
:PZloopOptions3
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo			3. Send Message...................................ACCEPTED
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop3Process) else (goto DLandINSTrcon)
:PZloop3Process
echo.
echo			What would you like to send^?
Set /p MSG="			Send Message: "
rcon -c rcon.yaml "servermsg \"%MSG%""
echo			MSG was Send.
echo.
TIMEOUT 3 > nul
echo			Returning to Watchdog loop
TIMEOUT 3 > nul
goto PZloop

:PZloop4
cls
echo.
:Title_Loop6d
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6d
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions4
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions4
:PZloopOptions4
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop4Process) else (goto DLandINSTrcon)
:PZloop4Process
echo			rcon-cli FOUND
echo.
echo			4. Reset Time (Water^&Power)......................ACCEPTED
echo.
echo.
echo			Deleting Time File
echo.
echo			1. Yes delete them
echo			2. No..
echo.
choice /C:12Q /N /T:10 /D:Q /M:"		Type your answer: "
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :PZloop4Yes
if %ERRORLEVEL%==2 call :PZloop
goto PZloop

:PZloop4Yes
cls
echo.
:Title_Loop6e
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6e
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions5
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions5
:PZloopOptions5
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
echo			4. Reset Time (Water^&Power)......................ACCEPTED
echo.
echo.
echo			Deleting Time File
TIMEOUT 2 > nul
pushd %ServerConfig%\Saves\Multiplayer\%servername%
del /q map_t.bin
echo.
echo			File Deleted.
TIMEOUT 2 > nul
echo.
echo			Sending shutdown command in 5 seconds
TIMEOUT 5 > nul
Pushd %WatchdogLoc%
echo Server:
rcon -c rcon.yaml "quit"
echo.
echo			Server is Shutting down
echo.
echo			Watchdog will Detect and restart...
::Close Zomboid admin tool
START /wait taskkill /f /im ZomboidRCON.exe
TIMEOUT /T 5
goto PZloop

:PZloop5
cls
echo.
:Title_Loop6f
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6f
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions6
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions6
:PZloopOptions6
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process) else (goto DLandINSTrcon)
:PZloop5Process
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo.
echo			1. Backup Files
echo			2. Backup Files ^& Restart Server
echo			3. Backup Files ^&  Close  Server
echo			4. Restore Files
echo			5. Go back
echo.
choice /C:12345 /N /T:10 /D:5 /M:"		Type your answer: "
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :PZloop5clean
if %ERRORLEVEL%==2 call :PZloop5Yes
if %ERRORLEVEL%==3 call :PZloop5No
if %ERRORLEVEL%==4 call :PZloop5Res
if %ERRORLEVEL%==5 call :PZloop
goto PZloop

:PZloop5clean
cls
%BaseColor%
echo.
:Title_Loop6gxx1
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6gxx1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions7a
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions7a
:PZloopOptions7a
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process2a) else (goto DLandINSTrcon)
:PZloop5Process2a
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo.
echo			1. Backup Files...................................ACCEPTED
echo.
echo			Creating Copy of Server Data
echo		Backups Location: %LogPath%\Watchdog_FullBackup\
echo options.ini =%datestamp%-%timestamp%
echo Database to =%datestamp%-%timestamp%\Database\db
echo Settings to =%datestamp%-%timestamp%\ServerSettings\Config
echo Savesdatato =%datestamp%-%timestamp%\Savesdata\Saves\Multiplayer\%servername%
TIMEOUT 5 > nul
robocopy "%ServerConfig%\server" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\ServerSettings\Config" /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%\Saves\Multiplayer\%servername%" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\Saves\Multiplayer\%servername%" /e /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%\db" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\db" %servername%.db /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%" options.ini /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop6gxx1a
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6gxx1a
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions7a1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions7a1
:PZloopOptions7a1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process2a1) else (goto DLandINSTrcon)
:PZloop5Process2a1
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo.
echo			1. Backup Files...................................ACCEPTED
echo.
echo			Copy Finished
echo			                             (Date-Time)
echo			Unique backup restore ID: %datestamp%-%timestamp%
echo.
TIMEOUT 3 > nul
echo.
echo			Proceeding to Watchdog Loop
Timeout 10
goto PZloop

:PZloop5Yes
cls
%BaseColor%
echo.
:Title_Loop6gxx2
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6gxx2
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions7b
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions7b
:PZloopOptions7b
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process2b) else (goto DLandINSTrcon)
:PZloop5Process2b
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo.
echo.
echo			2. Backup Files ^& Restart Server.................ACCEPTED
echo.
echo			Creating Copy of Server Data
echo		Backups Location: %LogPath%\Watchdog_FullBackup\
echo options.ini =%datestamp%-%timestamp%
echo Database to =%datestamp%-%timestamp%\Database\db
echo Settings to =%datestamp%-%timestamp%\ServerSettings\Config
echo Savesdatato =%datestamp%-%timestamp%\Savesdata\Saves\Multiplayer\%servername%
TIMEOUT 5 > nul
robocopy "%ServerConfig%\server" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\ServerSettings\Config" /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%\Saves\Multiplayer\%servername%" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\Saves\Multiplayer\%servername%" /e /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%\db" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\db" %servername%.db /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%" options.ini /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop6gxx2a
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6gxx2a
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions7b1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions7b1
:PZloopOptions7b1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process2b1) else (goto DLandINSTrcon)
:PZloop5Process2b1
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo.
echo.
echo			2. Backup Files ^& Restart Server.................ACCEPTED
echo.
echo			Copy Finished
echo.
echo			                             (Date-Time)
echo			Unique backup restore ID: %datestamp%-%timestamp%
echo.
TIMEOUT 3 > nul
Pushd %WatchdogLoc%
echo Server:
rcon -c rcon.yaml "quit"
echo.
echo			Proceeding to Watchdog Loop
::Close Zomboid admin tool
START /wait taskkill /f /im ZomboidRCON.exe
Timeout 10
goto PZloop

:PZloop5No
cls
echo.
:Title_Loop6g1a
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6g1a
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions8a
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions8a
:PZloopOptions8a
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process3) else (goto DLandINSTrcon)
:PZloop5Process3
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo.
echo.
echo.
echo			3. Backup Files ^&  Close  Server.................ACCEPTED
echo.
echo			Creating Copy of Server Data
echo		Backups Location: %LogPath%\Watchdog_FullBackup\
echo options.ini =%datestamp%-%timestamp%
echo Database to =%datestamp%-%timestamp%\Database\db
echo Settings to =%datestamp%-%timestamp%\ServerSettings\Config
echo Savesdatato =%datestamp%-%timestamp%\Savesdata\Saves\Multiplayer\%servername%
TIMEOUT 5 > nul
robocopy "%ServerConfig%\server" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\ServerSettings\Config" /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%\Saves\Multiplayer\%servername%" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\Saves\Multiplayer\%servername%" /e /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%\db" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%\db" %servername%.db /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
robocopy "%ServerConfig%" "%LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%" options.ini /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop6g1a1
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6g1a1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions8a1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions8a1
:PZloopOptions8a1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process3a1) else (goto DLandINSTrcon)
:PZloop5Process3a1
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo			  
echo.
echo.
echo			3. Backup Files ^&  Close  Server.................ACCEPTED
echo.
echo			Copy Finished
echo.
echo			                             (Date-Time)
echo			Unique backup restore ID: %datestamp%-%timestamp%
echo.
TIMEOUT 3 > nul
%BaseColor%
Pushd %WatchdogLoc%
echo Server:
rcon -c rcon.yaml "quit"
echo.
echo			Server is Shutting down and closing Watchdog.
::Close Zomboid admin tool
START /wait taskkill /f /im ZomboidRCON.exe
echo.
TIMEOUT 10
goto CloseWatchdog

:PZloop5Res
cls
echo.
:Title_Loop6g1b
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop6g1b
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions8b
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions8b
:PZloopOptions8b
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo				Quick Functions:
echo.
echo.
echo.
echo.
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop5Process3a) else (goto DLandINSTrcon)
:PZloop5Process3a
echo			rcon-cli FOUND
echo.
echo			5. Create or Restore Backup.......................ACCEPTED
echo.
echo			Backup Server Files (Map files ^& Database)
echo.
echo.
echo.
echo.
echo			4. Restore Files..................................ACCEPTED
echo.
TIMEOUT 1 > nul
echo			Shutdown the server so we can restore files..
echo.
%BaseColor%
Pushd %WatchdogLoc%
echo Server:
rcon -c rcon.yaml "quit"
echo.
echo			Server is Shutting down now..
echo.
::Close Zomboid admin tool
START /wait taskkill /f /im ZomboidRCON.exe
timeout 2 > nul
echo			List of Backups to choose from: (Format = ^Date-^Time)
echo.
pushd %LogPath%\Watchdog_FullBackup\
set count=0
set "choice_Folder="
for /F "delims=" %%A in ('dir /b /A:D %LogPath%\Watchdog_FullBackup') do (
    ::Increment %count% here so that it doesn't get incremented later
    set /a count+=1

    ::Add the file name to the options array
    set "Folder[!count!]=%%A"

    ::Add the new option to the list of existing options
    set choice_Folder=!choice_Folder!!count!
)
for /L %%A in (1,1,!count!) do echo   [%%A]. !Folder[%%A]!
echo   [Q]. Go back..
echo.
choice /c:Q!choice_Folder! /n /t:15 /d:Q /m "Enter your selection: "
if '%ERRORLEVEL%'=='1' goto PZloop
echo !Folder[%errorlevel%]!>FolderID.txt
echo.
echo                          Restored:
for /F %%G IN (FolderID.txt) do (robocopy "%LogPath%\Watchdog_FullBackup\%%G\ServerSettings\Config" "%ServerConfig%\server" /copy:dat /IT /NFL /NJH /NJS)
for /F %%G IN (FolderID.txt) do (robocopy "%LogPath%\Watchdog_FullBackup\%%G\Saves\Multiplayer\%servername%" "%ServerConfig%\Saves\Multiplayer\%servername%" /e /copy:dat /IT /NFL /NJH /NJS)
for /F %%G IN (FolderID.txt) do (robocopy "%LogPath%\Watchdog_FullBackup\%%G\db" "%ServerConfig%\db" %servername%.db /copy:dat /IT /NFL /NJH /NJS)
for /F %%G IN (FolderID.txt) do (robocopy "%LogPath%\Watchdog_FullBackup\%%G" "%ServerConfig%" options.ini /copy:dat /IT /NFL /NJH /NJS)
del FolderID.txt
timeout 1 > nul
echo.
echo Restore From = %LogPath%\Watchdog_FullBackup\%datestamp%-%timestamp%
echo Restore To   = %ServerConfig%
echo.
echo			Files Restored. 
Timeout 2 > nul
echo.
echo			Remember to also update the Watchdog settings if changed after this backup
echo			or the Watchdog will auto-update them again when it fully reloads.
echo			For now it will only Start the server again and not update configs..!
echo.
timeout 1 > nul
echo			Returning to Watchdog loop..
TIMEOUT 20
goto StartServer

:PZloop6
cls
echo.
:Title_Loop60A
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions9
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions9
:PZloopOptions9
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo			1. Edit PZ_Watchdog.bat file (Add Mods)
echo			2. Edit Server.ini settings
echo			3. Edit options.ini settings
echo			4. Open Server-Console Log file
echo			5. Open Server Logs directory
echo			6. View RCON login
echo			7. Restart Zomboid Admin Tool
echo			8. Go Back
echo.
choice /C:12345678 /N /T:10 /D:8 /M:"		Type your answer: "
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :PZloop6Process1
if %ERRORLEVEL%==2 call :PZloop6Process2
if %ERRORLEVEL%==3 call :PZloop6Process3
if %ERRORLEVEL%==4 call :PZloop6Process4
if %ERRORLEVEL%==5 call :PZloop6Process5
if %ERRORLEVEL%==6 call :PZloop6Process6
if %ERRORLEVEL%==7 call :PZloop6Process7
if %ERRORLEVEL%==8 call :PZloop
goto PZloop

:PZloop6Process1
cls
echo.
:Title_Loop60B
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions10
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions10
:PZloopOptions10
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo			1. Edit PZ_Watchdog.bat file (Add Mods)...........ACCEPTED
echo.
echo.
echo	      RESTART SERVER AFTER EDITING TO IMPLEMENT YOUR CHANGES
TIMEOUT 2 > nul
echo.
cls
echo.
:Title_Loop60Ba
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Ba
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions102
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions102
:PZloopOptions102
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo			1. Edit PZ_Watchdog.bat file (Add Mods)...........ACCEPTED
echo.
echo.
echo.
echo.
TIMEOUT 1 > nul
cls
echo.
:Title_Loop60Bb
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Bb
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions103
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions103
:PZloopOptions103
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo			1. Edit PZ_Watchdog.bat file (Add Mods)...........ACCEPTED
echo.
echo.
echo	      RESTART SERVER AFTER EDITING TO IMPLEMENT YOUR CHANGES
echo	   DO NOT EDIT Server.ini MANUALLY OR WATCHDOG WILL OVERWRITE IT
echo.
TIMEOUT 3 > nul
Start notepad.exe %WatchdogLoc%\PZ_Watchdog.bat
TIMEOUT 15 > nul
goto PZloop

:PZloop6Process2
cls
echo.
:Title_Loop60Bx1
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Bx1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions10x1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions10x1
:PZloopOptions10x1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo			2. Edit Server.ini settings (Add Mods)............ACCEPTED
echo.
echo.
echo		RESTART SERVER AFTER EDITING TO IMPLEMENT YOUR CHANGES
TIMEOUT 2 > nul
echo.
echo.
cls
echo.
:Title_Loop60Bax1
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Bax1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions102x1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions102x1
:PZloopOptions102x1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo			2. Edit Server.ini settings (Add Mods)............ACCEPTED
echo.
echo.
echo.
echo.
echo.
TIMEOUT 1 > nul
cls
echo.
:Title_Loop60Bbx1
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Bbx1
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions103x1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions103x1
:PZloopOptions103x1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo			2. Edit Server.ini settings (Add Mods)............ACCEPTED
echo.
echo.
TIMEOUT 1 > nul
echo		  RESTART SERVER AFTER EDITING TO IMPLEMENT YOUR CHANGES
echo		    DO NOT EDIT Server.ini unless AutoUpdateConfig=NO
echo.
TIMEOUT 3 > nul
Start notepad.exe %filePZini%
TIMEOUT 15 > nul
goto PZloop

:PZloop6Process3
cls
echo.
:Title_Loop60C
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions11
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions11
:PZloopOptions11
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo.
echo			3. Edit options.ini settings......................ACCEPTED
echo.
TIMEOUT 1 > nul
echo	          RESTART SERVER AFTER EDITING TO IMPLEMENT YOUR CHANGES
echo	      USING STEAM UPDATE WILL OVERWRITE ANY CHANGES IN 'options.ini'
echo		               USE BACKUPS TO RESTORE SETTINGS
echo.
TIMEOUT 10 > nul
Start notepad.exe "%ServerConfig%\options.ini"
TIMEOUT /t 13
goto PZloop

:PZloop6Process4
cls
echo.
:Title_Loop60D
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions12
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions12
:PZloopOptions12
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo.
echo.
echo			4. Open Server-Console Log file...................ACCEPTED
echo.
echo.
TIMEOUT 2 > nul
Start notepad.exe "%ServerConfig%\server-console.txt"
goto PZloop

:PZloop6Process5
:Title_Loop60E
cls
echo.
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions13
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions13
:PZloopOptions13
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo			5. Open Server Logs directory.....................ACCEPTED
echo.
TIMEOUT 2 > nul
Start %SystemRoot%\explorer.exe "%ServerConfig%\Logs"
goto PZloop

:PZloop6Process6
cls
echo.
:Title_Loop60Az
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Az
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions9z
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions9z
:PZloopOptions9z
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo			   IP:       %serverip%
echo			   Port:     %reconport%
echo			   Password: %reconpass%
echo.
echo			6. View RCON login................................ACCEPTED
echo.
TIMEOUT /T 20
goto PZloop

:PZloop6Process7
cls
echo.
:Title_Loop60Az12
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Az12
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions9za1
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions9za1
:PZloopOptions9za1
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo			7. Restart Zomboid Admin Tool.....................ACCEPTED
echo.
echo.
TIMEOUT 1 > nul
if exist "%WatchdogLoc%\ZomboidRCON\ZomboidRCON.exe" (goto CheckZatProcessx1) else (goto DLandINSTzomboidrcon)
:CheckZatProcessx1
echo			   Program Directory.................................FOUND
echo.
TIMEOUT 1 > nul
:: Check if Zomboid Admin Tool is running to kill it
tasklist /fi "imagename eq ZomboidRCON.exe" /FO TABLE | find /i "ZomboidRCON.exe"
if "%ERRORLEVEL%"=="0" goto KillZATx1
if "%ERRORLEVEL%"=="1" goto StartZATx1
TIMEOUT > 1 nul
Goto PZloop6Process7
:KillZATx1
%ColorRed%
echo.
echo			   Program already running........................DETECTED
echo.
echo			   Closing ZAT..
echo.
TIMEOUT 2 > nul
:: Kill Zomboid Admin tool if it is running
START /wait taskkill /f /im ZomboidRCON.exe
goto PZloop6Process7

:StartZATx1
cls
%BaseColor%
echo.
:Title_Loop60Azax
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop60Azax
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions9zabx
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions9zabx
:PZloopOptions9zabx
echo.
Pushd %WatchdogLoc%
echo Scanning for Active Players:
rcon -c rcon.yaml "Players"
echo.
echo			6. Logs ^& Server Settings........................ACCEPTED
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo			7. Restart Zomboid Admin Tool.....................ACCEPTED
echo.
echo.
echo.
echo			   Program Directory.................................FOUND
::Start Zomboid admin tool
start /D %ZATPath% "Zomboid Admin Tool Starting" ZomboidRCON.exe
echo.
echo			   Program Started
TIMEOUT 1 > nul
echo.
echo			   Login data:
echo.
echo			   IP:       %serverip%
echo			   Port:     %reconport%
echo			   Password: %reconpass%
echo.
echo			Proceeding to start Watchdog montior..
TIMEOUT /t 10
goto PZloop

:PZloop7
cls
echo.
:Title_Loop70
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop70
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
Pushd %WatchdogLoc%
echo.
echo	Project Zomboid Server Status:	Watchdog Loop Stopped
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions14
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions14
:PZloopOptions14
echo.
echo.
echo				Quick Functions:
echo.
echo.
echo			Removes all Files created by this script.
echo.
echo.
echo.
echo.
echo			7. Remove Game....................................ACCEPTED
echo.
TIMEOUT 2 > nul
echo			1. Yes, delete it all
echo			2. No
echo.
choice /C:12Q /N /T:10 /D:Q /M:"		Type your answer: "
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if %ERRORLEVEL%==1 call :PZloop7Go
if %ERRORLEVEL%==2 call :PZloop
goto PZloop
:PZloop7Go
cls
echo.
:Title_Loop70ff
if not "!!STR[6A]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop70ff
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[6A]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
Pushd %WatchdogLoc%
echo.
echo	Project Zomboid Server Status:	Watchdog Loop Stopped
echo.
tasklist /fi "imagename eq java.exe" /FO TABLE | find /i "java.exe"
echo Online			      PID				 MemoryUsage
if "%ERRORLEVEL%"=="0" goto PZloopOptions14
if "%ERRORLEVEL%"=="1" goto PZcrashed
goto PZLoopOptions14
:PZloopOptions14
echo.
echo.
echo				Quick Functions:
echo.
echo.
echo			Removes all Files created by this script.
echo.
echo.
echo.
echo.
echo			7. Remove Game....................................ACCEPTED
echo.
echo			1. Yes, delete it all.............................ACCEPTED
echo			2. No
echo.
TIMEOUT 2 > nul
echo.
:PZloop7Process1
if exist "%WatchdogLoc%\rcon.exe" (goto PZloop7Process2) else (goto DLandINSTrcon)
:PZloop7Process2
%ColorLPurple%
echo			rcon-cli FOUND
echo.
echo			Sending shutdown command in 5 seconds
TIMEOUT 5 > nul
echo Server:
rcon -c rcon.yaml "quit"
echo.
echo			Server is Shutting down, give it some time.
echo.
TIMEOUT 1 > nul
echo			Press spacebar if server is already shutdown..
TIMEOUT 20 > nul
echo			Removing ALL server files......
echo.
TIMEOUT 1 > nul
echo			Deleting started..
TIMEOUT 2 > nul
::Stop Zomboid Admin tool
START /wait taskkill /f /im ZomboidRCON.exe
::Delete all records of Project Zomboid
FOR /d %%a IN ("%ServerPath%\*") DO IF /i NOT "%%~nxa"=="Watchdog" RD /S /Q "%%a"
FOR %%a IN ("%ServerPath%\*") DO IF /i NOT "%%~nxa"=="PZ_Watchdog.bat" DEL "%%a"
del /f /q %ServerConfig%\server-console
rmdir /s /q %ServerConfig%\backups
rmdir /s /q %ServerConfig%\db
rmdir /s /q %ServerConfig%\logs
rmdir /s /q %ServerConfig%\Mods
rmdir /s /q %ServerConfig%\messaging
rmdir /s /q %ServerConfig%\Saves\Multiplayer\servertest
rmdir /s /q %ServerConfig%\Saves\Multiplayer\%servername%
rmdir /s /q %ServerConfig%\Server
rmdir /s /q %ServerConfig%\Statistic
echo.
echo			Deleting Project Zomboid Server finished^^!
echo.
echo			Deleting Scheduled Tasks..
TIMEOUT 3 > nul
::Delete Scheduled Tasks
echo.
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c ""%temp%\DeleteTasks.bat"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
echo.schtasks /delete /tn Launch_Watchdog_At_Logon /f>"%temp%\DeleteTasks.bat"
echo.schtasks /delete /tn Launch_WelcomeMSG_2H /f>>"%temp%\DeleteTasks.bat"
echo.schtasks /delete /tn Restart_at_0200 /f>>"%temp%\DeleteTasks.bat"
cscript "%temp%\getadmin.vbs"
timeout 8 > nul
del "%temp%\getadmin.vbs"
del "%temp%\AddRules.bat"
echo.
echo.
echo			Deleting Scheduled Tasks finished
TIMEOUT 3 > nul
echo			Deleting Firewall Rules..
TIMEOUT 3 > nul
echo.
::Delete Firewall Rules and need elevated prompt to do it
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c ""%temp%\DelRules.bat"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
echo.netsh advfirewall firewall delete rule name="PZServer_%Serverport%_UDP">"%temp%\DelRules.bat"
echo.netsh advfirewall firewall delete rule name="PZServer_%Serverport%-%Serverport1%_TCP">>"%temp%\DelRules.bat"
echo.netsh advfirewall firewall delete rule name="PZSteam_%SteamPort1%-%SteamPort2%_UDP">>"%temp%\DelRules.bat"
echo.netsh advfirewall firewall delete rule name="PZSteam_FORMODS_SteamCMD">>"%temp%\DelRules.bat"
echo.netsh advfirewall firewall delete rule name="PZrecon_%reconport%_TCP">>"%temp%\DelRules.bat"
cscript "%temp%\getadmin.vbs"
timeout 8 > nul
del "%temp%\getadmin.vbs"
del "%temp%\DelRules.bat"
echo.

echo.
echo			Deleting Firewall Rules finished
echo.
pushd %temp%
echo.@echo off>Cleanup.bat
echo.set serverpath=%ServerPath%>>Cleanup.bat
echo.Timeout 12 ^> nul>>Cleanup.bat
echo.rmdir /s /q %serverpath%>>Cleanup.bat
echo.(goto) 2^>nul ^& del "%%~f0" ^& exit>>Cleanup.bat
start /MIN /I %temp%\Cleanup.bat
echo.
echo.
echo 	Finished Removing ALL Files.
TIMEOUT 5 > nul
%BaseColor%
goto CloseWatchdogFinal

:PZcrashed
:: // Java is not running, log crash and start log backup 
:: _________________________________________________________
cls
echo.
%ColorRed%
:Title_Loop7A
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-2"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-0-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
echo java.exe
echo OFFLINE		      PID				 MemoryUsage
echo.
TIMEOUT 1 > nul
echo		(%datestamp%) (%timestamp%) ATTENTION: PZ closed or crashed
echo.
echo.
TIMEOUT 1 > nul
cls
echo.
%ColorDRed%
:Title_Loop7B
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-2"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-0-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
echo java.exe
echo OFFLINE		      PID				 MemoryUsage
echo.
TIMEOUT 1 > nul
echo		(%datestamp%) (%timestamp%) ATTENTION: PZ closed or crashed
echo.
echo.
TIMEOUT 1 > nul
cls
echo.
%ColorRed%
:Title_Loop7C
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-2"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-0-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
echo java.exe
echo OFFLINE		      PID				 MemoryUsage
echo.
TIMEOUT 1 > nul
echo		(%datestamp%) (%timestamp%) ATTENTION: PZ closed or crashed
TIMEOUT 1 > nul
cls
echo.
%ColorDRed%
:Title_Loop7D
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-2"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-0-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
echo java.exe
echo OFFLINE		      PID				 MemoryUsage
echo.
TIMEOUT 1 > nul
echo		(%datestamp%) (%timestamp%) ATTENTION: PZ closed or crashed
echo.
echo.
TIMEOUT 1 > nul
cls
echo.
%ColorRed%
:Title_Loop7H
if not "!!STR[7]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop7H
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-2"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-0-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[7]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo      Project Zomboid %servername% Status: Watchdog Active - (%timestampMIN%)
echo.
echo java.exe
echo OFFLINE		      PID				 MemoryUsage
echo.
TIMEOUT 1 > nul
echo		(%datestamp%) (%timestamp%) ATTENTION: PZ closed or crashed
TIMEOUT 1 > nul
echo		(%datestamp%) (%timestamp%) ATTENTION: PZ closed or crashed > %LogPath%\Watchdog_Logs\%fullstamp%_Crash.txt
echo.
TIMEOUT 1 > nul
echo		(%datestamp%) (%timestamp%) Proceeding to Backup log and restart server..
TIMEOUT 4 > nul
goto logrotation

:DLandINSTrcon
CLS
%ColorRed%
echo			rcon-cli NOT FOUND
echo.
echo			Downloading now..
timeout 4 > nul
cls
%BaseColor%
echo.
:Title_Loop82
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Create Download temp..
timeout 3 > nul
::Create Download temp
IF NOT EXIST %ServerPath%\Dump (
Mkdir %ServerPath%\Dump
)
Set WORKSPACE=%ServerPath%\Dump

cls
echo.
:Title_Loop82A
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Downloading..
timeout 3 > nul
::Download program
%ColorLBlue%
bitsadmin.exe /transfer replica /priority FOREGROUND "http://github.com/gorcon/rcon-cli/releases/download/v0.10.2/rcon-0.10.2-win64.zip" %WORKSPACE%\dump_data.zip
cls
%BaseColor%
echo.
:Title_Loop82B
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Extracting..
timeout 3 > nul
::Extract program
Call :UnZipFile "%WORKSPACE%" "%WORKSPACE%\dump_data.zip"
cls
echo.
:Title_Loop82C
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Moving..
timeout 3 > nul
::Move program
pushd %WatchdogLoc%
move %WORKSPACE%\rcon-0.10.2-win64\rcon.exe
move %WORKSPACE%\rcon-0.10.2-win64\rcon.yaml
cls
echo.
:Title_Loop82D
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Updating Config..
timeout 3 > nul
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
cls
echo.
:Title_Loop82E
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Cleanup..
timeout 3 > nul
::Delete Download temp
rmdir /s /q %ServerPath%\Dump
%ColorGreen%%
cls
echo.
:Title_Loop82F
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82F
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Downloading RCON-CLI..............................FINISHED
echo.
TIMEOUT 3 > nul
echo			Checking if quit.bat is available
echo.
if exist "%WatchdogLoc%\quit.bat" (goto PZloop) else (goto DLandINSTquit)
:DLandINSTquit
%ColorRed%
echo			'quit.bat'.......................................NOT FOUND
echo
TIMEOUT 1 > nul
echo 			creating now
TIMEOUT 3 > nul
%ColorLBlue%
::Creating quit.bat file
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
cls
%BaseColor%
cls
echo.
:Title_Loop82FA
if not "!!STR[A2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop82FA
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Downloading RCON-CLI..............................FINISHED
echo.
echo			Creating 'quit.bat'...............................FINISHED
echo.
TIMEOUT 2 > nul
echo			Returning to the Watchdog Monitor
echo
%BaseColor%
GOTO PZloop

:UpdateRCONCFG
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
goto UpdatedRCONCFG

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

:DLandINSTzomboidrcon
echo		Program Directory NOT FOUND
echo.
echo			Downloading now..
%ColorRed%
timeout 4 > nul
cls
%BaseColor%
echo.
:Title_Loop83
if not "!!STR[A5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A5]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Create Download temp..
timeout 3 > nul
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
if not "!!STR[A5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A5]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Downloading..
timeout 3 > nul
::Download programs
%ColorLBlue%
bitsadmin.exe /transfer replica /priority FOREGROUND "https://github.com/kwmx/ZomboidRCON/releases/download/v1.0.3/ZomboidRCON.zip" %WORKSPACE%\dump_data2.zip
TIMEOUT 1 > nul
bitsadmin.exe /transfer replica /priority FOREGROUND "https://download.visualstudio.microsoft.com/download/pr/bf058765-6f71-4971-aee1-15229d8bfb3e/c3366e6b74bec066487cd643f915274d/windowsdesktop-runtime-6.0.1-win-x64.exe" %WORKSPACE%\windowsdesktop-runtime-6.0.1-win-x64.exe
cls
%BaseColor%
echo.
:Title_Loop83B
if not "!!STR[A5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A5]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Extracting and Installing.. 
timeout 3 > nul
::Extract program
Call %WORKSPACE%\windowsdesktop-runtime-6.0.1-win-x64.exe /install /quiet /norestart
TIMEOUT 1 > nul
Call :UnZipFile "%WatchdogLoc%\ZomboidRCON" "%WORKSPACE%\dump_data2.zip"
cls
echo.
:Title_Loop83E
if not "!!STR[A5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A5]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Cleanup..
timeout 15 > nul
::Delete Download temp
rmdir /s /q %ServerPath%\Dump
cls
%ColorGreen%
echo.
:Title_Loop83F
if not "!!STR[A5]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop83F
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A5]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo			Finished downlaoding and installing 
Echo			Zomboid Admin Tool and .NET Desktop Runtime 6.0.6
echo.
TIMEOUT 8 > nul
echo			Checking if quit.bat is available
echo.
TIMEOUT 3 > nul
if exist "%WatchdogLoc%\quit.bat" (goto StartZAT) else (goto DLandINSTquit2)
:DLandINSTquit2
%ColorRed%
echo			NOT FOUND, creating now
TIMEOUT 3 > nul
%ColorLBlue%
::Creating quit.bat file
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
cls
echo.
%BaseColor%
GOTO StartZAT

:DLandINSTquit3
cls
%ColorRed%
echo			Quit.bat file NOT FOUND, creating now
TIMEOUT 3 > nul
%ColorLBlue%
::Creating quit.bat file
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
cls
echo.
%BaseColor%
GOTO SteamUpdateCheck






:UnZipFile <ExtractTo> <newzipfile>
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
exit /b

:logrotation
:: // Create Backup of Project Zomboid Log Files
:: _________________________________________________________
:: Declare how date / time should be handled.
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
	set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
	set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
	set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%" & set "fullstamp=%YYYY%-%MM%-%DD%_%HH%%Min%-%Sec%" & set "timestampMIN=%HH%:%Min%"
:: Configuring text color
%ColorAqua%
cls
echo.
:Title_Loop2
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Rotation.
echo.
echo.
echo		Log backup Progress: 00/100
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 1 > nul
IF NOT EXIST %LogPath%\Watchdog_Logs (
Mkdir %LogPath%\Watchdog_Logs
)
:: Check / Copy / Clear Server Logs
:: Will create Backup of All Server log files in the LOG directory under folder Watchdog_Logs under Date then Time
cls
echo.
:Title_Loop2A
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Rotation.
echo.
echo.
echo		Log backup Progress: 20/100 - Backup Server Settings
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	:: Copy Server Settings
	robocopy "%ServerConfig%\server" "%LogPath%\Watchdog_Logs\ServerSettings-%datestamp%\Time-%timestamp%" /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop2B
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Rotation.
echo.
echo.
echo		Log backup Progress: 40/100 - Backup Server Logs
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	::Server Config Logs
	robocopy "%LogPath%" "%LogPath%\Watchdog_Logs\ServerSettings-%datestamp%\Time-%timestamp%" /mov /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop2C
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Rotation.
echo.
echo.
echo		Log backup Progress: 60/100 - Backup Console Logs
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	::Server Config Logs
	robocopy "%ServerConfig%\Logs" "%LogPath%\Watchdog_Logs\ConsoleLogs-%datestamp%\Time-%timestamp%" /e /move /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop2D
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Rotation.
echo.
echo.
echo		Log backup Progress: 80/100 - Backup rcon-cli Log
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	::RCON command Log
	robocopy "%WatchdogLoc%" "%LogPath%\Watchdog_Logs\ConsoleLogs-%datestamp%\Time-%timestamp%" rcon-default.log /mov /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop2E
if not "!!STR[2]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop2E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "pref_len/=2"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[2]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo %lineA6%
echo.
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Rotation.
echo.
echo.
echo		Log backup Progress: 100/100
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
echo.
TIMEOUT 1 > nul
echo		Proceeding to Steam for %servername% server updates..
echo.
echo.
TIMEOUT 2 > nul
%BaseColor%
goto SteamUpdateCheck

:CloseWatchdog
:: Last Log Rotation Before Shutdown.
:: _________________________________________________________
:: Declare how date / time should be handled.
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
	set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
	set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
	set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%" & set "fullstamp=%YYYY%-%MM%-%DD%_%HH%%Min%-%Sec%" & set "timestampMIN=%HH%:%Min%"

%ColorAqua%
cls
echo.
:Title_Loop99
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop99
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Backup.
echo.
echo.
echo.
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
IF NOT EXIST %LogPath%\Watchdog_Logs (
Mkdir %LogPath%\Watchdog_Logs
)
cls
echo.
:Title_Loop99A
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop99A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Backup.
echo.
echo.
echo		Log backup Progress: 20/100 - Backup Server Settings
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	:: Copy Server Settings
	robocopy "%ServerConfig%\server" "%LogPath%\Watchdog_Logs\ServerSettings-%datestamp%\Time-%timestamp%" /copy:dat /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop99B
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop99B
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Backup.
echo.
echo.
echo		Log backup Progress: 40/100 - Backup Server Logs
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	::Server Config Logs
	robocopy "%LogPath%" "%LogPath%\Watchdog_Logs\ServerSettings-%datestamp%\Time-%timestamp%" /mov /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop99C
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop99C
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Backup.
echo.
echo.
echo		Log backup Progress: 60/100 - Backup Console Logs
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	::Server Config Logs
	robocopy "%ServerConfig%\Logs" "%LogPath%\Watchdog_Logs\ConsoleLogs-%datestamp%\Time-%timestamp%" /e /move /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop99D
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop99D
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Backup.
echo.
echo.
echo		Log backup Progress: 80/100 - Backup rcon-cli Log
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
	::RCON command Log
	robocopy "%WatchdogLoc%" "%LogPath%\Watchdog_Logs\ConsoleLogs-%datestamp%\Time-%timestamp%" rcon-default.log /mov /NFL /NDL /NJH /NJS /nc /ns /np
cls
echo.
:Title_Loop99E
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_Loop99E
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo		(%datestamp%) (%timestamp%) Starting Log Backup.
echo.
echo.
echo		Log backup Progress: 100/100
echo.
echo		Log backup location: %LogPath%\Watchdog_Logs
TIMEOUT 2 > nul
cls
%BaseColor%
::End credits
echo.
:Title_LoopA5A
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5A
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo.
echo				Closing Watchdog File
echo.
echo.
TIMEOUT 1 > nul
:Title_LoopA5B
cls
%ColorYellow%
echo.
echo.
echo.
echo.
echo     Thank you for using my Project Zomboid Watchdog^!
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

:CloseWatchdogFinal
cls
%BaseColor%
echo.
:Title_LoopA5Ax
if not "!!STR[A3]:~%LEN%!!"=="" set /A "LEN+=1" & goto :Title_LoopA5Ax
set "stars=****************************************************************************************************"
set "spaces=                                                                                                    "
call echo %%stars:~0,%SIZE%%%
set /a "pref_len=%SIZE%-%LEN%-20"
set /a "suf_len=%SIZE%-%LEN%-1-%pref_len%"
call echo *%%spaces:~0,%pref_len%%%%%STR[A3]%%%%spaces:~0,%suf_len%%%*
call echo %%stars:~0,%SIZE%%%
echo.
echo.
echo				Terminating Watchdog File
echo.
echo.
TIMEOUT 2 > nul
:Title_LoopA5Bx
cls
%ColorYellow%
echo.
echo.
echo.
echo.
echo     Thank you for using my Project Zomboid Watchdog^!
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
TIMEOUT 2 > nul
endlocal
exit

:: \\ Big Thanks to kwmx from https://github.com/kwmx/ZomboidRCON for the ZomboidRCON tool under MIT License!
:: \\ Big Thanks to Gorcon from https://github.com/gorcon/rcon-cli/ for rcon-cli under MIT License!

:: \\ Created by Dimens - https://github.com/Dimens101/PG-Installerscript
:: \\ https://steamcommunity.com/profiles/76561198020468907/
