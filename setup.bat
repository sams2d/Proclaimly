@echo off
setlocal

title Setup ^| Proclaimly by S2D Labs

echo.
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
echo Please ensure you have the necessary permissions to install software
echo and a stable Internet connection.
echo.
pause

echo.
echo ----------------------------------------------------------------------------------
echo.
echo [INFO] Checking if Python is already installed...
echo.

:: ============================================================
:: CHECK PYTHON
:: ============================================================

set "PYTHON_CMD="

python --version >nul 2>&1
if %errorlevel%==0 (
    set "PYTHON_CMD=python"
    echo [SUCCESS] Python is accessible via the 'python' command.
    echo.
    python --version
    goto python_found
)

py --version >nul 2>&1
if %errorlevel%==0 (
    set "PYTHON_CMD=py"
    echo [SUCCESS] Python is accessible via the 'py' launcher.
    echo.
    py --version
    goto python_found
)

:: ============================================================
:: INSTALL PYTHON
:: ============================================================

echo [INFO] Python was not found.
echo.
echo [INFO] Proceeding to install Python...
echo.

set "PYTHON_INSTALLER_URL=https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
set "PYTHON_INSTALLER=python_installer.exe"

echo [INFO] Downloading the official Python installer...
echo.

curl -L -o "%PYTHON_INSTALLER%" "%PYTHON_INSTALLER_URL%"

if not exist "%PYTHON_INSTALLER%" (
    echo.
    echo [ERROR] Failed to download the Python installer.
    echo.
    echo Please check your Internet connection and try again.
    goto failed
)

echo.
echo [SUCCESS] Python installer downloaded.
echo.
echo [INFO] Installing Python...
echo [INFO] This may take a few minutes. Please wait...
echo.

start /wait "" "%PYTHON_INSTALLER%" /quiet InstallAllUsers=0 PrependPath=1 Include_launcher=0

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Python installation failed.
    del "%PYTHON_INSTALLER%" >nul 2>&1
    goto failed
)

del "%PYTHON_INSTALLER%" >nul 2>&1

echo.
echo [SUCCESS] Python installation completed.
echo.

:: ============================================================
:: FIND NEW PYTHON
:: ============================================================

echo [INFO] Checking the newly installed Python...
echo.

:: The current CMD session may not have the updated PATH,
:: so check the standard per-user Python installation location.

set "PYTHON_CMD="

python --version >nul 2>&1
if %errorlevel%==0 (
    set "PYTHON_CMD=python"
    goto python_found
)

py --version >nul 2>&1
if %errorlevel%==0 (
    set "PYTHON_CMD=py"
    goto python_found
)

if exist "%LocalAppData%\Programs\Python\Python312\python.exe" (
    set "PYTHON_CMD=%LocalAppData%\Programs\Python\Python312\python.exe"
    goto python_found
)

echo [ERROR] Python was installed but could not be located.
goto failed


:python_found

echo.
echo [SUCCESS] Python is ready.
echo.

:: ============================================================
:: CHECK / CREATE VIRTUAL ENVIRONMENT
:: ============================================================

if exist ".venv\Scripts\python.exe" (
    echo [INFO] Existing virtual environment found.
    echo [INFO] Skipping virtual environment creation.
    echo.
    goto venv_ready
)

echo [INFO] Creating virtual environment...
echo.
echo [INFO] This may take a moment. Please wait...
echo.

"%PYTHON_CMD%" -m venv .venv

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to create the virtual environment.
    goto failed
)

echo.
echo [SUCCESS] Virtual environment created.
echo.


:venv_ready

:: ============================================================
:: VERIFY VIRTUAL ENVIRONMENT
:: ============================================================

if not exist ".venv\Scripts\python.exe" (
    echo.
    echo [ERROR] Virtual environment Python was not found.
    goto failed
)

echo [INFO] Using Proclaimly's virtual environment.
echo.

.venv\Scripts\python.exe --version

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] The virtual environment is not working correctly.
    goto failed
)

echo.
echo [SUCCESS] Virtual environment is ready.
echo.

:: ============================================================
:: UPGRADE PIP
:: ============================================================

echo [INFO] Upgrading pip...
echo.

.venv\Scripts\python.exe -m pip install --upgrade pip

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to upgrade pip.
    goto failed
)

echo.
echo [SUCCESS] pip upgrade complete.
echo.

:: ============================================================
:: INSTALL DEPENDENCIES
:: ============================================================

echo [INFO] Installing required dependencies...
echo.

if exist "requirements.txt" (
    echo [INFO] requirements.txt found.
    echo [INFO] Installing dependencies from requirements.txt...
    echo.

    .venv\Scripts\python.exe -m pip install -r requirements.txt

    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Failed to install required dependencies.
        goto failed
    )
) else (
    echo [INFO] requirements.txt was not found.
    echo [INFO] Installing Django...
    echo.

    .venv\Scripts\python.exe -m pip install django

    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Failed to install Django.
        goto failed
    )
)

echo.
echo [SUCCESS] Dependencies installed.
echo.

:: ============================================================
:: DATABASE / MIGRATIONS
:: ============================================================

echo [INFO] Setting up migrations and database...
echo.

.venv\Scripts\python.exe manage.py makemigrations

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to create migrations.
    goto failed
)

.venv\Scripts\python.exe manage.py migrate

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to apply database migrations.
    goto failed
)

echo.
echo [SUCCESS] Migrations and database setup complete.
echo.

:: ============================================================
:: CREATE ADMIN USER
:: ============================================================

echo [INFO] You need at least one Admin user to access the admin panel.
echo.
echo [INFO] If you already have an Admin user, you can skip this step.
echo.

set /p "create_admin=Do you want to create an Admin user now? (Y/N): "

if /I "%create_admin%"=="Y" (
    echo.
    echo [ALERT] You will now be prompted to create an Admin user.
    echo [INFO] Please follow the instructions shown by Django.
    echo.

    .venv\Scripts\python.exe manage.py createsuperuser

    if %errorlevel% neq 0 (
        echo.
        echo [WARNING] Admin user creation was not completed.
        echo [INFO] You can create one later using the setup again.
        echo.
    ) else (
        echo.
        echo [SUCCESS] Admin user created.
        echo.
    )
) else (
    echo.
    echo [INFO] Skipping Admin user creation.
    echo [INFO] You can create an Admin user later.
    echo.
)

:: ============================================================
:: FINISH
:: ============================================================

echo.
echo ----------------------------------------------------------------------------------
echo.
echo [SUCCESS] Proclaimly Setup completed successfully!
echo.
echo [INFO] You can now run Proclaimly using proclaimly.bat
echo.
echo ----------------------------------------------------------------------------------
echo.

pause
exit /b 0


:: ============================================================
:: ERROR HANDLER
:: ============================================================

:failed

echo.
echo ----------------------------------------------------------------------------------
echo.
echo [ERROR] Proclaimly setup could not be completed.
echo.
echo [Quick Fix] Check your Internet connection and run setup.bat again.
echo.
echo ----------------------------------------------------------------------------------
echo.

pause
exit /b 1
```