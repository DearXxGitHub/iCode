@echo off
for /f "delims=" %%i in ('dir ..\Dlls\*.dll /b /s') do regsvr32 /s /u "%%i"&&echo.�ɹ���ע�� %%i
for /f "delims=" %%i in ('dir ..\Dlls\*.ocx /b /s') do regsvr32 /s /u "%%i"&&echo.�ɹ���ע�� %%i