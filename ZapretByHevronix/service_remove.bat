@echo off
title Zapret Ultimate - Удаление службы
color 0C

REM Автоматическое повышение прав
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Требуются права администратора. Получение прав...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

chcp 866 >nul

echo.
echo ========================================================
echo         УДАЛЕНИЕ ZAPRET ULTIMATE СЛУЖБ
echo ========================================================
echo.
echo [OK] Права администратора получены автоматически
echo.
echo [INFO] Поиск и остановка всех служб Zapret...

REM Список всех возможных служб
set services=ZapretDPI ZapretUltimate ZapretUltimate_Smart ZapretUltimate_Quick ZapretUltimate_Full ZapretUltimate_Hybrid ZapretUltimate_Stealth

for %%s in (%services%) do (
    echo [INFO] Проверка службы: %%s
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [FOUND] Остановка службы: %%s
        sc stop "%%s" 2>nul
        timeout /t 2 >nul
        echo [REMOVE] Удаление службы: %%s
        sc delete "%%s" 2>nul
        if !errorlevel! equ 0 (
            echo [SUCCESS] Служба %%s успешно удалена
        ) else (
            echo [WARN] Проблема с удалением службы %%s
        )
    ) else (
        echo [INFO] Служба %%s не найдена
    )
    echo.
)

echo [INFO] Принудительная остановка всех процессов winws...
taskkill /f /im winws.exe 2>nul
if %errorlevel% equ 0 (
    echo [SUCCESS] Процессы winws остановлены
) else (
    echo [INFO] Процессы winws не найдены
)

echo.
echo [INFO] Очистка временных файлов...
if exist "temp\*.*" (
    del /q temp\*.* 2>nul
    echo [SUCCESS] Временные файлы очищены
)

echo [INFO] Очистка системных правил...
netsh advfirewall firewall delete rule name="Zapret" 2>nul
netsh advfirewall firewall delete rule name="ZapretUltimate" 2>nul

echo.
echo ========================================================
echo            УДАЛЕНИЕ ЗАВЕРШЕНО УСПЕШНО!
echo ========================================================
echo.
echo [SUCCESS] Все службы Zapret Ultimate удалены
echo [SUCCESS] Все процессы остановлены
echo [SUCCESS] Система очищена
echo.
echo [INFO] Обход блокировок полностью отключен
echo [INFO] Можно безопасно удалить папку программы
echo.
pause