@echo off
FOR /F "tokens=* delims=" %%i in (phantom.txt) DO .\phantom-windows.exe -server %%i