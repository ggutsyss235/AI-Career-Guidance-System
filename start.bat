@echo off
title AICareer Pro Launcher
color 0a

echo =================================================================
echo                      AICareer Pro Launcher                      
echo =================================================================
echo.

:: Check python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH!
    echo Please install Python 3.9+ and add it to your PATH environment variable.
    pause
    exit /b 1
)

:: Check node is installed
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js / NPM is not installed or not in PATH!
    echo Please install Node.js and add it to your PATH environment variable.
    pause
    exit /b 1
)

:: Setup Backend
echo [1/3] Setting up Python virtual environment...
cd backend
if not exist venv (
    echo Creating virtual environment...
    python -m venv venv
)
echo.

echo [2/3] Installing backend dependencies...
call venv\Scripts\activate.bat
pip install -r requirements.txt
echo.

:: Setup Frontend
echo [3/3] Setting up React frontend...
cd ..\frontend
if not exist node_modules (
    echo node_modules not found, running npm install...
    call npm install
)
echo.

echo =================================================================
echo             Starting AICareer Pro Services...
echo =================================================================
echo.

:: Launch Backend in a separate window
start cmd /k "title AICareer Pro Backend && cd ..\backend && call venv\Scripts\activate.bat && echo Starting Flask Server... && python app.py"

:: Launch Frontend in the current window
echo Launching React Frontend...
set NODE_OPTIONS=--no-deprecation
npm start

pause
