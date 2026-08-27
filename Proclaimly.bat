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
echo [INFO] Attempting to activate the virtual environment...
echo.
call .venv\Scripts\activate.bat
if %errorlevel%==0 (
    echo [INFO] Activating the virtual environment...
    echo.
    echo [SUCCESS] Virtual environment activated!
) else (
    echo.
    echo [ERROR] Failed to activate the virtual environment. Please check for errors above.
    echo.
    echo [Quick Fix] Run the setup to resolve Environment/Dependencies issue.
    echo.
    goto end
)
echo.
echo [INFO] Attempting to launch the application...
echo.
start "" http://127.0.0.1:8000/
%pykey% manage.py runserver
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to launch the application. Please check for errors above.
    echo.
    echo [Quick Fix] Run the setup to resolve Environment/Dependencies issue.
    echo.
)

:end

pause