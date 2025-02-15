@echo off

taskkill /f /im FiveM.exe
taskkill /f /im steam.exe
taskkill /f /im EpicGamesLauncher.exe
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\cache"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\nui-storage"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache-priv"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\crashes"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\logs"
rmdir /s /q "%LocalAppData%\DigitalEntitlements"
rmdir /s /q "%AppData%\CitizenFX\kvs"
rmdir /s /q "C:\Program Files (x86)\Steam\logs"
rmdir /s /q "C:\Users\ADMINI~1\AppData\Local\Temp"
rmdir /s /q "C:\Windows\temp"
mkdir C:\Windows\temp
rmdir /s /q "C:\Windows\Prefetch"
mkdir C:\Windows\Prefetch
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography" /v MachineGuid /f

taskkill /f /im FiveM.exe
taskkill /f /im steam.exe
taskkill /f /im EpicGamesLauncher.exe

:: Delete FiveM cache and related directories
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\cache"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\nui-storage"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache-priv"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\crashes"
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\logs"

:: Delete CitizenFX KVS directory
rmdir /s /q "%AppData%\CitizenFX\kvs"

:: Additional deletions as per your request
rmdir /s /q "C:\Users\Ruan\AppData\Local\FiveM\FiveM.app\data\nui-storage-cl2"
rmdir /s /q "C:\Users\Ruan\AppData\Local\FiveM\FiveM.app\data\server-cache-cl2"
rmdir /s /q "C:\Users\Ruan\AppData\Local\FiveM\FiveM.app\data\server-cache-priv-cl2"
rmdir /s /q "C:\Users\Ruan\AppData\Roaming\CitizenFX\kvs_cl2"

:folderclean
call :getDiscordVersion
cls
goto :xboxclean

:getDiscordVersion
for /d %%a in ("%appdata%\Discord\*") do (
   set "varLoc=%%a"
   goto :d1
)
:d1
for /f "delims=\ tokens=7" %%z in ('echo %varLoc%') do (
   set "discordVersion=%%z"
)
goto :EOF

:xboxclean
cls

:: Remove Xbox-related apps and services
powershell -Command "& {Get-AppxPackage -AllUsers xbox | Remove-AppxPackage}"
sc stop XblAuthManager
sc stop XblGameSave
sc stop XboxNetApiSvc
sc stop XboxGipSvc
sc delete XblAuthManager
sc delete XblGameSave
sc delete XboxNetApiSvc
sc delete XboxGipSvc
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /f
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /disableL
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f

cls

:: Modify the hosts file to block Xbox Live domains
set hostspath=%windir%\System32\drivers\etc\hosts
echo 127.0.0.1 xboxlive.com >> %hostspath%
echo 127.0.0.1 user.auth.xboxlive.com >> %hostspath%
echo 127.0.0.1 presence-heartbeat.xboxlive.com >> %hostspath%

del "C:\\ProgramData\\FiveMclean.bat"