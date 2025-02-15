@echo off
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore" /f
reg delete "HKLM\SOFTWARE\Microsoft\Cryptography" /v MachineGuid /f
echo sucesso.
del "C:\\ProgramData\\Fivegu4rd_byp3ss.bat"