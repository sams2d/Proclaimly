```bat
@echo off
setlocal

title Proclaimly ^| S2D Labs

echo.
echo __________                      .__         .__        .__
echo \______   \_______  ____   ____ ^|  ^| _____  ^|__^| _____ ^|  ^| ___.__.
echo  ^|     ___/\_  __ \/  _ \_/ ___^\^|  ^| \__  \ ^|  ^|/     ^\^|  ^|^<   ^|  ^
echo  ^|    ^|     ^|  ^| \(  ^<_^> )  \___^|  ^|__/ __ \^|  ^|  Y Y  \  ^|_\___  ^|
echo  ^|____^|     ^|__^|   \____/ \___  ^>____(____  /__^|__^|_^|  /____/ ____^|
echo                               \/          \/         \/     \/
echo.
echo A Lyrics Presentation Software By S2D Labs
echo.
echo ----------------------------------------------------------------------------------
echo.

:: ============================================================
:: CHECK VIRTUAL ENVIRONMENT
:: ============================================================

echo [INFO] Checking Proclaimly environment...
echo.

if not exist ".venv\Scripts\python.exe" (
    echo [ERROR] Proclaimly virtual environment was not found.
    echo.
    echo [Quick Fix] Please run setup.bat first.
    echo.
    goto end
)

echo [SUCCESS] Proclaimly virtual environment found.
echo.

:: ============================================================
:: CHECK DJANGO
:: ============================================================

echo [INFO] Checking Proclaimly installation...
echo.

.venv\Scripts\python.exe -c "import django; print('[SUCCESS] Django version:', django.get_version())"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Django is not installed correctly.
    echo.
    echo [Quick Fix] Please run setup.bat again.
    echo.
    goto end
)

echo.

:: ============================================================
:: CHECK DATABASE
:: ============================================================

echo [INFO] Checking database...
echo.

if not exist "db.sqlite3" (
    echo [WARNING] Database file was not found.
    echo [INFO] Running database migrations...
    echo.

    .venv\Scripts\python.exe manage.py migrate

    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Database setup failed.
        echo.
        echo [Quick Fix] Please run setup.bat again.
        echo.
        goto end
    )

    echo.
    echo [SUCCESS] Database initialized.
    echo.
) else (
    echo [SUCCESS] Database found.
    echo.
)

:: ============================================================
:: APPLICATION STARTUP
:: ============================================================

echo [INFO] Starting Proclaimly...
echo.
echo ----------------------------------------------------------------------------------
echo.

set "DJANGO_DEBUG=False"

:: Start browser after a short delay.
:: Django will continue running in this window.
start "" /b cmd /c "timeout /t 2 /nobreak >nul & start "" http://127.0.0.1:8000/"

:: Run Django using Proclaimly's virtual environment.
.venv\Scripts\python.exe manage.py runserver

if %errorlevel% neq 0 (
    echo.
    echo ----------------------------------------------------------------------------------
    echo.
    echo [ERROR] Proclaimly stopped unexpectedly.
    echo.
    echo [Quick Fix] Please run setup.bat to check the environment and dependencies.
    echo.
    echo ----------------------------------------------------------------------------------
    echo.
)

:end

echo.
echo [INFO] Proclaimly has been stopped.
echo.
pause

endlocal
```
