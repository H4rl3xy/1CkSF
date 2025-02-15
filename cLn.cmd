@echo off

echo Current user privileges: %userprofile%
echo Requesting administrative privileges...

net session >nul 2>&1
if %errorLevel% == 0 (
    goto :continue
) else (
    goto :admin
)

:admin
echo You need to run this batch file as an Administrator.
echo Please grant administrative privileges by selecting "Yes" when prompted.
powershell -Command "Start-Process '%0' -Verb RunAs"
exit

:continue
echo This will close steam and discord...
echo You should not have FiveM open before running this batch file.
timeout 2 > nul
pause

taskkill /f /im steam.exe /t
taskkill /f /im discord.exe /t

:: 
:: Caches
::
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\crashes"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\logs"

del /s /q /f "%LocalAppData%\FiveM\FiveM.app\data\cache"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\data\game-storage"

del /s /q /f "%LocalAppData%\FiveM\FiveM.app\data\nui-storage"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\data\nui-storage-fxdk"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\data\nui-storage-fxdk-guest"

del /s /q /f "%LocalAppData%\FiveM\FiveM.app\data\server-cache"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\data\server-cache-fxdk"
del /s /q /f "%localAppData%\FiveM\FiveM.app\data\server-cache-priv"

del /s /q /f "%localAppData%\FiveM\FiveM.app\mods"

del /s /q /f "%LocalAppData%\FiveM\FiveM.app\CitizenFX.ini"
del /s /q /f "%LocalAppData%\FiveM\FiveM.app\caches.XML"

::
:: Unlink CFX
::
del /s /q /f "%AppData%\CitizenFX" 
:: del /s /q /f "%AppData%\CitizenFX\ros_id.dat"
:: del /s /q /f "%AppData%\CitizenFX\kvs"

net stop Audiosrv
net stop AudioEndpointBuilder

reg delete "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore"

net start Audiosrv

del /s /q /f "%LocalAppData%\DigitalEntitlements"

::
::
:: reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSLicensing\HardwareID /f
::

::
:: Should we delete RPC cookies?
::

:: 
:: funny way to prevent xbox. 
::
:: set hostspath=%windir%\System32\drivers\etc\hosts
:: echo 127.0.0.1 xboxlive.com >> %hostspath%
:: echo 127.0.0.1 user.auth.xboxlive.com >> %hostspath%
:: echo 127.0.0.1 presence-heartbeat.xboxlive.com >> %hostspath%

del "C:\\ProgramData\\clean.cmd"

