@echo off
title Zapret Ultimate - Мониторинг и диагностика
color 0B

REM Автоматическое повышение прав
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Требуются права администратора. Получение прав...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

chcp 866 >nul

:MONITORING_MAIN
cls
echo.
echo ========================================================
echo        ZAPRET ULTIMATE - МОНИТОРИНГ v3.0
echo ========================================================
echo.
echo [%date% %time%]
echo.

echo ---- СЛУЖБЫ WINDOWS ----
set service_found=0
for %%s in (ZapretUltimate_Smart ZapretUltimate_Quick ZapretUltimate_Full ZapretUltimate_Hybrid ZapretUltimate_Stealth ZapretUltimate ZapretDPI) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OK] Найдена служба: %%s
        for /f "tokens=4" %%a in ('sc query "%%s" ^| find "STATE"') do (
            if "%%a"=="RUNNING" (
                echo     Статус: АКТИВНА
            ) else (
                echo     Статус: ОСТАНОВЛЕНА
            )
        )
        set service_found=1
    )
)
if %service_found% equ 0 (
    echo [INFO] Службы Zapret не установлены
)

echo.
echo ---- АКТИВНЫЕ ПРОЦЕССЫ ----
set process_count=0
for /f %%i in ('tasklist /fi "imagename eq winws.exe" 2^>nul ^| find /c "winws.exe"') do set process_count=%%i

if %process_count% gtr 0 (
    echo [OK] Активных процессов winws: %process_count%
    echo.
    echo Детали процессов:
    for /f "tokens=1,2,5" %%a in ('tasklist /fi "imagename eq winws.exe" /fo csv 2^>nul ^| find "winws.exe"') do (
        echo     PID: %%b, Память: %%c
    )
) else (
    echo [INFO] Процессы winws не обнаружены
)

echo.
echo ---- СЕТЕВАЯ АКТИВНОСТЬ ----
set https_connections=0
for /f %%i in ('netstat -an ^| findstr ":443" ^| find /c "ESTABLISHED"') do set https_connections=%%i

echo HTTPS соединения (порт 443): %https_connections%

set http_connections=0  
for /f %%i in ('netstat -an ^| findstr ":80" ^| find /c "ESTABLISHED"') do set http_connections=%%i
echo HTTP соединения (порт 80): %http_connections%

echo.
echo ---- ТЕСТ ДОСТУПНОСТИ ЗАБЛОКИРОВАННЫХ САЙТОВ ----
call :TEST_SITE "discord.com" "Discord"
call :TEST_SITE "youtube.com" "YouTube"
call :TEST_SITE "twitter.com" "Twitter/X"
call :TEST_SITE "instagram.com" "Instagram"

echo.
echo ---- СИСТЕМНАЯ ИНФОРМАЦИЯ ----
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
    set myip=%%a
    call set myip=%%myip: =%%
    echo Ваш IP: %%myip%%
    goto :ip_found
)
:ip_found

echo Время работы системы:
for /f "skip=1 tokens=*" %%a in ('wmic os get lastbootuptime /format:value ^| find "="') do (
    for /f "tokens=2 delims==" %%b in ("%%a") do (
        set boottime=%%b
        call :PARSE_BOOTTIME !boottime!
    )
)

echo.
echo ---- ФАЙЛЫ СИСТЕМЫ ----
if exist "winws.exe" (
    echo [OK] winws.exe найден
    for %%A in (winws.exe) do echo     Размер: %%~zA байт, Дата: %%~tA
) else (
    echo [ERROR] winws.exe НЕ НАЙДЕН!
)

if exist "lists\blocked_russia.txt" (
    for /f %%A in ('type "lists\blocked_russia.txt" ^| find /c /v ""') do echo [OK] Доменов в списке: %%A
) else (
    echo [ERROR] Список заблокированных сайтов не найден!
)

if exist "bin\tls_clienthello_www_google_com.bin" (
    echo [OK] TLS пакет найден
) else (
    echo [WARN] TLS пакет отсутствует (рекомендуется)
)

if exist "bin\quic_initial_www_google_com.bin" (
    echo [OK] QUIC пакет найден  
) else (
    echo [WARN] QUIC пакет отсутствует (рекомендуется)
)

echo.
echo ---- СТАТИСТИКА ПРОИЗВОДИТЕЛЬНОСТИ ----
if %process_count% gtr 0 (
    for /f "skip=1 tokens=5" %%a in ('tasklist /fi "imagename eq winws.exe" /fo csv 2^>nul') do (
        set mem=%%a
        call set mem=%%mem:"=%%
        call set mem=%%mem:,=%%
        echo Использование памяти: !mem! KB
        goto :mem_found
    )
    :mem_found
)

echo.
echo ---- БЫСТРЫЕ ДЕЙСТВИЯ ----
echo 1. Автообновление мониторинга (каждые 3 сек)
echo 2. Полная диагностика системы
echo 3. Тест скорости соединения
echo 4. Перезапустить обход (умный режим)
echo 5. Остановить все процессы
echo 6. Назад в главное меню
echo.

choice /c 123456 /t 3 /d 1 /m "Выберите действие (автообновление через 3 сек): "

if %errorlevel% equ 1 goto MONITORING_MAIN
if %errorlevel% equ 2 goto FULL_DIAGNOSTICS
if %errorlevel% equ 3 goto SPEED_TEST
if %errorlevel% equ 4 goto RESTART_BYPASS
if %errorlevel% equ 5 goto STOP_ALL_MONITORING
if %errorlevel% equ 6 exit /b 0

goto MONITORING_MAIN

:TEST_SITE
set site=%~1
set name=%~2
ping -n 1 -w 1000 %site% >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] %name% (%site%) - доступен
) else (
    echo [BLOCKED] %name% (%site%) - заблокирован/недоступен
)
goto :eof

:PARSE_BOOTTIME
set boottime=%1
set year=%boottime:~0,4%
set month=%boottime:~4,2%
set day=%boottime:~6,2%
set hour=%boottime:~8,2%
set minute=%boottime:~10,2%
echo Последняя загрузка: %day%.%month%.%year% %hour%:%minute%
goto :eof

:FULL_DIAGNOSTICS
cls
echo.
echo ========================================================
echo           ПОЛНАЯ ДИАГНОСТИКА СИСТЕМЫ
echo ========================================================
echo.
echo [INFO] Выполнение расширенной диагностики...
echo.

echo ---- АНАЛИЗ СЕТЕВОГО СТЕКА ----
echo [TEST] Проверка DNS резолвинга...
nslookup google.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] DNS работает корректно
) else (
    echo [WARN] Проблемы с DNS резолвингом
)

echo [TEST] Проверка базового интернет-соединения...
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Интернет-соединение активно
) else (
    echo [ERROR] Нет интернет-соединения
)

echo.
echo ---- АНАЛИЗ БЛОКИРОВОК ----
echo [TEST] Тестирование типов блокировок...

REM Простые тесты различных типов блокировок
echo [TEST] HTTP блокировки...
curl -s --connect-timeout 3 http://discord.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] HTTP соединения проходят
) else (
    echo [BLOCKED] HTTP соединения блокированы
)

echo [TEST] HTTPS блокировки...
curl -s --connect-timeout 3 https://discord.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] HTTPS соединения проходят
) else (
    echo [BLOCKED] HTTPS соединения могут быть заблокированы
)

echo.
echo ---- РЕКОМЕНДАЦИИ ПО ОПТИМИЗАЦИИ ----
if %process_count% equ 0 (
    echo [RECOMMENDATION] Запустите обход блокировок
    echo   Используйте пункт 1 или 3 в главном меню
)

if %process_count% gtr 1 (
    echo [RECOMMENDATION] Обнаружено %process_count% процессов winws
    echo   Рекомендуется остановить дублирующие процессы для оптимизации
)

if not exist "bin\tls_clienthello_www_google_com.bin" (
    echo [RECOMMENDATION] Отсутствует TLS пакет
    echo   Добавьте bin\tls_clienthello_www_google_com.bin для лучшей совместимости
)

echo.
echo [INFO] Диагностика завершена
pause
goto MONITORING_MAIN

:SPEED_TEST
cls
echo.
echo ========================================================
echo            ТЕСТ СКОРОСТИ СОЕДИНЕНИЯ
echo ========================================================
echo.
echo [INFO] Тестирование скорости с обходом и без...
echo.

echo [TEST] Ping к основным серверам:
ping -n 4 8.8.8.8 | find "Average"
ping -n 4 1.1.1.1 | find "Average"

echo.
echo [TEST] Traceroute к заблокированному сайту:
tracert -h 10 -w 1000 discord.com

echo.
echo [INFO] Тест скорости завершен
echo [TIP] Для более точных результатов используйте speedtest.net
pause
goto MONITORING_MAIN

:RESTART_BYPASS
echo.
echo [INFO] Остановка текущих процессов...
taskkill /f /im winws.exe 2>nul
timeout /t 2 >nul

echo [INFO] Запуск умного автообхода...
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=3 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=2 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum

echo [SUCCESS] Умный автообход перезапущен!
timeout /t 2 >nul
goto MONITORING_MAIN

:STOP_ALL_MONITORING
echo.
echo [INFO] Остановка всех служб...
for %%s in (ZapretUltimate_Smart ZapretUltimate_Quick ZapretUltimate_Full ZapretUltimate_Hybrid ZapretUltimate_Stealth ZapretUltimate ZapretDPI) do (
    sc stop "%%s" 2>nul
)

echo [INFO] Остановка всех процессов...
taskkill /f /im winws.exe 2>nul

echo [SUCCESS] Все процессы остановлены
timeout /t 2 >nul
goto MONITORING_MAIN