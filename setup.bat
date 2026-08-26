@echo off

title Setup ^| Proclaimly by S2D Labs

echo __________                      .__         .__        .__         
echo \______   \_______  ____   ____ ^|  ^| _____  ^|__^| _____ ^|  ^| ___.__.
echo  ^|     ___/\_  __ \/  _ \_/ ___^\^|  ^| \__  \ ^|  ^|/     ^\^|  ^|^<   ^|  ^|
echo  ^|    ^|     ^|  ^| \(  ^<_^> )  \___^|  ^|__/ __ \^|  ^|  Y Y  \  ^|_\___  ^|
echo  ^|____^|     ^|__^|   \____/ \___  ^>____(____  /__^|__^|_^|  /____/ ____^|
echo                               \/          \/         \/     \/
echo.
echo A Lyrics Presentation Software By S2D Labs
echo.
echo ----------------------------------------------------------------------------------
echo.
echo This setup will install Proclaimly along with its dependencies on your system. 
echo.
echo Please ensure you have the necessary permissions to install software and a stable Internet connection.  
echo.
echo.
pause
echo.
echo Checking if Python is already installed...
echo.
:: 1. Check if the 'python' command works
python --version >nul 2>&1
if %errorlevel%==0 (
    echo [SUCCESS] Python is accessible via 'python' command.
    echo.
    echo installed version: & python --version
    echo.
    set "pykey=python"
    goto skip_install_python
)

:: 2. Check if the 'py' command works instead
py --version >nul 2>&1
if %errorlevel%==0 (
    echo [SUCCESS] Python is accessible via 'py' command launcher.
    echo.
    echo installed version: & py --version
    echo.
    set "pykey=py"
    goto skip_install_python
)
::Install Python if not found
echo.
echo [INFO] Python is not found. Proceeding to install Python...
echo.
:: Download the latest Python installer (64-bit) from the official source
set "PYTHON_INSTALLER_URL=https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
set "PYTHON_INSTALLER=python_installer.exe"
echo Starting automatic installation...
echo Downloading official Windows installer (please wait)...

:: Download the official 64-bit installer via curl
curl -L -o %PYTHON_INSTALLER% %PYTHON_INSTALLER_URL%

echo Download complete. Running installer in background...
echo This will take a moment...

:: Run installer silently, force path setup, and EXCLUDE the py launcher
start /wait %PYTHON_INSTALLER% /quiet InstallAllUsers=0 PrependPath=1 Include_launcher=0

:: Clean up the installation file
del %PYTHON_INSTALLER%

echo.
echo [SUCCESS] Python installation complete!

:skip_install_python

:: 1. Check if the 'python' command works
python --version >nul 2>&1
if %errorlevel%==0 (
    set "pykey=python"
    goto continue_setup
)

:: 2. Check if the 'py' command works instead
py --version >nul 2>&1
if %errorlevel%==0 (
    set "pykey=py"
    goto continue_setup
)

:continue_setup
echo.
echo [INFO] Creating virtual environment...
%pykey% -m venv .venv
echo.
echo [SUCCESS] Virtual environment created!
echo.

echo [INFO] Activating virtual environment...
call .venv\Scripts\activate.bat
echo.
echo [SUCCESS] Virtual environment activated!
echo.
echo [INFO] Upgrading pip to the latest version...
echo.
%pykey% -m pip install --upgrade pip
echo.
echo [SUCCESS] pip upgrade complete!
echo.
echo [INFO] Installing required dependencies...
echo.
%pykey% -m pip install django
echo [SUCCESS] Dependencies installed!
echo.

echo [INFO] Setting up the migrations and database...
echo.
%pykey% manage.py makemigrations
%pykey% manage.py migrate
echo [SUCCESS] Migrations and database setup complete!
echo.

echo [INFO] Finalizing setup...
call .venv\Scripts\deactivate.bat
echo.
echo [INFO] Proclaimly Setup completed. You can now run the application.
echo.
pause   