@echo off
setlocal

:: Get the repository path (parent directory of install folder)
set "REPO_PATH=%~dp0.."

:: Add fzdocker to PATH through a .cmd wrapper
set "INSTALL_DIR=%USERPROFILE%\fzdocker"
set "CMD_WRAPPER=%INSTALL_DIR%\fzdocker.cmd"

:: Create installation directory if it doesn't exist
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: Create a .cmd wrapper that calls the bash script
echo @echo off > "%CMD_WRAPPER%"
echo bash "%REPO_PATH%\fzdocker" %%* >> "%CMD_WRAPPER%"

:: Add the installation directory to USER PATH if it's not already there
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "USER_PATH=%%b"
if not defined USER_PATH set "USER_PATH="
echo Current USER PATH: %USER_PATH%

if not "%USER_PATH%"=="%USER_PATH:fzdocker=%" (
    echo fzdocker is already in PATH
) else (
    setx PATH "%USER_PATH%;%INSTALL_DIR%"
    echo Added fzdocker to PATH
)

echo Installation completed!
echo Please restart your terminal to use the fzdocker command
pause 