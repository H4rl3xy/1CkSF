@echo off

powershell -command "Get-AppxPackage *xbox* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *xboxgameoverlay* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *xboxspeech* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *xboxidentityprovider* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *xboxlive* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *gamingapp* | Remove-AppxPackage"