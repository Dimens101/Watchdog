
## :::::::::::::::::::::::::[ How to use ]:::::::::::::::::::::::::::::::

 - Create a PZ server folder.
 - Create a folder named 'Watchdog' inside the PZ server folder.
 - Put `PZ_InstallScript.bat` & `PZ_Watchdog.bat` inside the 'Watchdog' folder.
 - Edit the `PZ_InstallScript.bat` with your prefered settings.
 - Start the `PZ_InstallScript.bat`.
 - After the `PZ_InstallerScript.bat` is finished it will start `PZ_Watchdog.bat`.
 - The Watchdog will loop every 10 sec to monitor the PZ server status.
 - If down it will backup the logs and attempt to restart the PZ server.

***
## :::::::::::::::::::[ Scripts Functions Short ]:::::::::::::::::

 - PZ_InstallScript.bat
  	```
    - It will Install the PZ server and prepare the files for use.
	- It will autodownload & install:
	- Java
	- Rcon-cli
	- SteamCMD
	- Zomboid Admin Tool _(Optional)_
    - .Net desktop 6.0 _(For Zomboid Admin)_
	```
 - PZ_Watchdog.bat
 	```
    - It will monitor if the server is down and display Menu options.
    - If the server is down it will restart the server.
    - Changing the port or passwords MUST be done in the watchdog file!
    - Steam will reset the config files and watchdog will update.
	  ```

***
## ::::::::::[ Project Zomboid Installer script ]::::::::::
- Check for Java                _(download and install it if not found)_
- Check for Rcon-cli & SteamCMD _(download and install it if not found)_
- add firewall rules
- Connect to steam
- Download Mods
- Download Server
- reconfigure files with user preferences.
- Start the server once for configuring settings
- Schedule Autostart of Watchdog after restart.
- Will give menu with more task scheduling options
- Check for Zomboid Admin tools _(download and install it if not found)_
***
## :::::::::::::[ Project Zomboid Watchdog script ]::::::::::::::
- Open Log directories for you      _(If selected)_
- Update Mods files                 _(If selected)_
- Update Server files with SteamCMD
- Update Server config
- Start Server                      _(Will Ask if you want steam or non-steam version)_
- Start Zomboid Admin Tool          _(If selected)_
- Start Watchdog monitor
  - Check every 10 SEC if server is up
  - Menu
  - Shutdown Server
  - Send Message to Server _(Players will see it in middle of screen in red letters)_
  - Reset Time _(Water and power is back, but not Radio/TVshows)_
  - Server Backup\Restore
  	- The Script will backup: 
	  ```
		- C:\Users\User1\Zomboid\options.ini
		- C:\Users\User1\Zomboid\Database\db
		- C:\Users\User1\Zomboid\Server
		- C:\Users\User1\Zomboid\Savesdata\Saves\Multiplayer\<servername>
		```
	- The Watchdog will autoupdate Server Settings found in the watchdog config itself
	- Or the user can choose to manually restore a backup after steam update
  - Easy access to Logs and Settings files
  - Full removal of the Server files and Watchdog files


 ![Watchdog Example](https://raw.githubusercontent.com/Dimens101/PG-Installerscript/main/Capture1.JPG)
 
 Example:
***
## ::::::::::::::::::::::::::[  After install:  ]::::::::::::::::::::::::::::::
|Watchdog Folder should look like this:							|-:-
|--								|--
|ZomboidRCON _(optional)_
|AutoRestart2h.bat _(optional)_
|PZ_Watchdog.bat
|quit.bat
|rcon.exe
|rcon.yaml
|rcon-default.txt
|WelcomeMSG.bat _(optional)_
***
## :::::::::::::::::::::::::::::::[ HELP ]:::::::::::::::::::::::::::::::::::::::

- Tested on Windows 2012R2 & Windows 10 (Latest Build)
- Using Windows 10 beware selecting the command window 
  with mouse **WILL FREEZE THE SCRIPT** until a key is pressed.
- To keep mods up to date the script downloads the full client and move the mods 
  from client to server. Client files require a valid steam account with PZ available.
- The Install Script needs a minimum of `10 GB` of free space if mods option is enabled.
- The watchdog script updates both steam/NON-STEAM 64bit files **NOT** the 32bit version.
- The Watchdog script can be used for existing servers.
- The Watchdog will create a folder called WatchdogLOGS inside 
  the `<ServerFolder>\Logs directory` for logs & backup.
- Once Java is installed it will need manual updating from the user.
- Writen entirely in Batchfile to make customization easier.
- Bitsadmin needs 1.2 TLS or it will fail.
