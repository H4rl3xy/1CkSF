@echo off
REM Batch script to delete FiveM app data
REM Prompt for admin access
NET FILE >NUL 2>&1
if '%errorlevel%' == '0' ( goto START ) else ( goto ELEVATE )

:ELEVATE
  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
  "%temp%\getadmin.vbs"
  exit /B

:START
REM Rest of the script goes here...

@echo off
setlocal
set "FIVEM_APP_DIR=%localappdata%\fivem\fivem.app"


if exist "%FIVEM_APP_DIR%\crashes" (
    del /q /s /f "%FIVEM_APP_DIR%\crashes\*.*"
    rmdir /s /q "%FIVEM_APP_DIR%\crashes"
    echo "cache folder deleted successfully."
) else (
    echo "cache folder not found."
)

if exist "%FIVEM_APP_DIR%\logs" (
    del /q /s /f "%FIVEM_APP_DIR%\logs\*.*"
    rmdir /s /q "%FIVEM_APP_DIR%\logs"
    echo "logs folder deleted successfully."
) else (
    echo "logs folder not found."
)


echo Deleting kvs folder in Roaming AppData...
if exist "%appdata%\CitizenFX\kvs" (
    rmdir /s /q "%appdata%\CitizenFX\kvs"
    echo "CitizenFX folder deleted successfully."
) else (
    echo "kvs folder not found."
)

echo Cleaner Finalizado!!!

@echo off
echo Desabilitando Riot Vanguard - sc stop vgk

echo Current user privileges: %userprofile%
echo.
echo Solicitando privilegios administrativos...

net session >nul 2>&1
if %errorLevel% == 0 (
    goto :continue
) else (
    goto :admin
)

:admin
echo.
echo Você precisa executar este arquivo em lote como administrador.
echo Conceda privilegios administrativos selecionando "Sim" quando solicitado.
echo.
powershell -Command "Start-Process '%0' -Verb RunAs"
exit

:continue
echo privilegios administrativos confirmados.
echo.
echo Desativando Riot Vanguard...

sc stop vgk

echo.
echo Success!
echo.

sc stop vgk

@echo OFF
cls
taskkill /f /im Steam.exe /t
taskkill /F /IM "Fivem.exe"
taskkill /F /IM "Steam.exe"
taskkill /F /IM "EpicGamesLauncher.exe"

sc start XboxNetApiSvc
sc start XboxGipSvc
sc start XblGameSave
sc start XblAuthManager

echo Services Xbox opprationnel vous pouvez quitter !

@echo off
goto :xboxclean
:xboxclean
cls
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
set hostspath=%windir%\System32\drivers\etc\hosts
echo 127.0.0.1 xboxlive.com >> %hostspath%
echo 127.0.0.1 user.auth.xboxlive.com >> %hostspath%
echo 127.0.0.1 presence-heartbeat.xboxlive.com >> %hostspath%

@echo off
setlocal
set "FIVEM_APP_DIR=%localappdata%\fivem\fivem.app"

echo Deleting D3DSCache folder...
if exist "%localappdata%\D3DSCache" (
    rmdir /s /q "%localappdata%\D3DSCache"
    echo "D3DSCache folder deleted successfully."
) else (
    echo "D3DSCache folder not found."
)

reg delete "HKLM\SOFTWARE\Microsoft\Cryptography" /v MachineGuid /f
cls
set reg_key_path=HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore
reg delete "%reg_key_path%" /f

del "C:\\ProgramData\\tMp3.bat"