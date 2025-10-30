@echo off
setlocal enabledelayedexpansion

REM Elevation.
powershell "start-process cmd -argumentlist '/c %~f0' -verb runas -wait"
exit /b

echo Uninstalling Microsoft Edge!

REM Remove Edge app.
powershell -Command "Get-AppxPackage -Name Microsoft.MicrosoftEdge | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue"

REM Prevent reinstall on new users.
powershell -Command "Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq 'Microsoft.MicrosoftEdge'} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue"

REM Confirm WebView2 is still present (optional)
powershell -Command "if (Get-AppxPackage -Name Microsoft.WebView2) { echo WebView2 is preserved. } else { echo Warning: WebView2 not found - it may have been removed. }"

echo Uninstallation complete. Please restart your computer (to apply changes).
pause>NUL
exit