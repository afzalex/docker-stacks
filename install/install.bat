@echo off
setlocal

:: Get the repository path (parent directory of install folder)
set "REPO_PATH=%~dp0.."

:: Add docker-stack to PATH through a .cmd wrapper
set "INSTALL_DIR=%USERPROFILE%\docker-stack"
set "CMD_WRAPPER=%INSTALL_DIR%\docker-stack.cmd"

:: Create installation directory if it doesn't exist
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: Create a .cmd wrapper that calls the bash script
echo @echo off > "%CMD_WRAPPER%"
echo bash "%REPO_PATH%\docker-stack" %%* >> "%CMD_WRAPPER%"

:: Add the installation directory to USER PATH if it's not already there
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "USER_PATH=%%b"
if not defined USER_PATH set "USER_PATH="
echo Current USER PATH: %USER_PATH%

if not "%USER_PATH%"=="%USER_PATH:docker-stack=%" (
    echo docker-stack is already in PATH
) else (
    setx PATH "%USER_PATH%;%INSTALL_DIR%"
    echo Added docker-stack to PATH
)

echo Installation completed!
echo Please restart your terminal to use the docker-stack command
pause 