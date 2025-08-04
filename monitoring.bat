@echo off
title Zapret Ultimate - �����ਭ� � �������⨪�
color 0B

REM ��⮬���᪮� ����襭�� �ࠢ
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo �ॡ����� �ࠢ� �����������. ����祭�� �ࠢ...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

chcp 866 >nul

:MONITORING_MAIN
cls
echo.
echo ========================================================
echo        ZAPRET ULTIMATE - ���������� v3.0
echo ========================================================
echo.
echo [%date% %time%]
echo.

echo ---- ������ WINDOWS ----
set service_found=0
for %%s in (ZapretUltimate_Smart ZapretUltimate_Quick ZapretUltimate_Full ZapretUltimate_Hybrid ZapretUltimate_Stealth ZapretUltimate ZapretDPI) do (
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OK] ������� �㦡�: %%s
        for /f "tokens=4" %%a in ('sc query "%%s" ^| find "STATE"') do (
            if "%%a"=="RUNNING" (
                echo     �����: �������
            ) else (
                echo     �����: �����������
            )
        )
        set service_found=1
    )
)
if %service_found% equ 0 (
    echo [INFO] ��㦡� Zapret �� ��⠭������
)

echo.
echo ---- �������� �������� ----
set process_count=0
for /f %%i in ('tasklist /fi "imagename eq winws.exe" 2^>nul ^| find /c "winws.exe"') do set process_count=%%i

if %process_count% gtr 0 (
    echo [OK] ��⨢��� ����ᮢ winws: %process_count%
    echo.
    echo ��⠫� ����ᮢ:
    for /f "tokens=1,2,5" %%a in ('tasklist /fi "imagename eq winws.exe" /fo csv 2^>nul ^| find "winws.exe"') do (
        echo     PID: %%b, ������: %%c
    )
) else (
    echo [INFO] ������ winws �� �����㦥��
)

echo.
echo ---- ������� ���������� ----
set https_connections=0
for /f %%i in ('netstat -an ^| findstr ":443" ^| find /c "ESTABLISHED"') do set https_connections=%%i

echo HTTPS ᮥ������� (���� 443): %https_connections%

set http_connections=0  
for /f %%i in ('netstat -an ^| findstr ":80" ^| find /c "ESTABLISHED"') do set http_connections=%%i
echo HTTP ᮥ������� (���� 80): %http_connections%

echo.
echo ---- ���� ����������� ��������������� ������ ----
call :TEST_SITE "discord.com" "Discord"
call :TEST_SITE "youtube.com" "YouTube"
call :TEST_SITE "twitter.com" "Twitter/X"
call :TEST_SITE "instagram.com" "Instagram"

echo.
echo ---- ��������� ���������� ----
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
    set myip=%%a
    call set myip=%%myip: =%%
    echo ��� IP: %%myip%%
    goto :ip_found
)
:ip_found

echo �६� ࠡ��� ��⥬�:
for /f "skip=1 tokens=*" %%a in ('wmic os get lastbootuptime /format:value ^| find "="') do (
    for /f "tokens=2 delims==" %%b in ("%%a") do (
        set boottime=%%b
        call :PARSE_BOOTTIME !boottime!
    )
)

echo.
echo ---- ����� ������� ----
if exist "winws.exe" (
    echo [OK] winws.exe ������
    for %%A in (winws.exe) do echo     ������: %%~zA ����, ���: %%~tA
) else (
    echo [ERROR] winws.exe �� ������!
)

if exist "lists\blocked_russia.txt" (
    for /f %%A in ('type "lists\blocked_russia.txt" ^| find /c /v ""') do echo [OK] ������� � ᯨ᪥: %%A
) else (
    echo [ERROR] ���᮪ �������஢����� ᠩ⮢ �� ������!
)

if exist "bin\tls_clienthello_www_google_com.bin" (
    echo [OK] TLS ����� ������
) else (
    echo [WARN] TLS ����� ��������� (४���������)
)

if exist "bin\quic_initial_www_google_com.bin" (
    echo [OK] QUIC ����� ������  
) else (
    echo [WARN] QUIC ����� ��������� (४���������)
)

echo.
echo ---- ���������� ������������������ ----
if %process_count% gtr 0 (
    for /f "skip=1 tokens=5" %%a in ('tasklist /fi "imagename eq winws.exe" /fo csv 2^>nul') do (
        set mem=%%a
        call set mem=%%mem:"=%%
        call set mem=%%mem:,=%%
        echo �ᯮ�짮����� �����: !mem! KB
        goto :mem_found
    )
    :mem_found
)

echo.
echo ---- ������� �������� ----
echo 1. ��⮮��������� �����ਭ�� (����� 3 ᥪ)
echo 2. ������ �������⨪� ��⥬�
echo 3. ���� ᪮��� ᮥ�������
echo 4. ��१������� ��室 (㬭� ०��)
echo 5. ��⠭����� �� ������
echo 6. ����� � ������� ����
echo.

choice /c 123456 /t 3 /d 1 /m "�롥�� ����⢨� (��⮮��������� �१ 3 ᥪ): "

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
    echo [OK] %name% (%site%) - ����㯥�
) else (
    echo [BLOCKED] %name% (%site%) - �������஢��/������㯥�
)
goto :eof

:PARSE_BOOTTIME
set boottime=%1
set year=%boottime:~0,4%
set month=%boottime:~4,2%
set day=%boottime:~6,2%
set hour=%boottime:~8,2%
set minute=%boottime:~10,2%
echo ��᫥���� ����㧪�: %day%.%month%.%year% %hour%:%minute%
goto :eof

:FULL_DIAGNOSTICS
cls
echo.
echo ========================================================
echo           ������ ����������� �������
echo ========================================================
echo.
echo [INFO] �믮������ ���७��� �������⨪�...
echo.

echo ---- ������ �������� ����� ----
echo [TEST] �஢�ઠ DNS १�������...
nslookup google.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] DNS ࠡ�⠥� ���४⭮
) else (
    echo [WARN] �஡���� � DNS १��������
)

echo [TEST] �஢�ઠ �������� ���୥�-ᮥ�������...
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] ���୥�-ᮥ������� ��⨢��
) else (
    echo [ERROR] ��� ���୥�-ᮥ�������
)

echo.
echo ---- ������ ���������� ----
echo [TEST] ����஢���� ⨯�� �����஢��...

REM ����� ���� ࠧ����� ⨯�� �����஢��
echo [TEST] HTTP �����஢��...
curl -s --connect-timeout 3 http://discord.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] HTTP ᮥ������� ��室��
) else (
    echo [BLOCKED] HTTP ᮥ������� �����஢���
)

echo [TEST] HTTPS �����஢��...
curl -s --connect-timeout 3 https://discord.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] HTTPS ᮥ������� ��室��
) else (
    echo [BLOCKED] HTTPS ᮥ������� ����� ���� �������஢���
)

echo.
echo ---- ������������ �� ����������� ----
if %process_count% equ 0 (
    echo [RECOMMENDATION] ������� ��室 �����஢��
    echo   �ᯮ���� �㭪� 1 ��� 3 � ������� ����
)

if %process_count% gtr 1 (
    echo [RECOMMENDATION] �����㦥�� %process_count% ����ᮢ winws
    echo   ������������ ��⠭����� �㡫����騥 ������ ��� ��⨬���樨
)

if not exist "bin\tls_clienthello_www_google_com.bin" (
    echo [RECOMMENDATION] ��������� TLS �����
    echo   ������� bin\tls_clienthello_www_google_com.bin ��� ���襩 ᮢ���⨬���
)

echo.
echo [INFO] �������⨪� �����襭�
pause
goto MONITORING_MAIN

:SPEED_TEST
cls
echo.
echo ========================================================
echo            ���� �������� ����������
echo ========================================================
echo.
echo [INFO] ����஢���� ᪮��� � ��室�� � ���...
echo.

echo [TEST] Ping � �᭮��� �ࢥࠬ:
ping -n 4 8.8.8.8 | find "Average"
ping -n 4 1.1.1.1 | find "Average"

echo.
echo [TEST] Traceroute � �������஢������ ᠩ��:
tracert -h 10 -w 1000 discord.com

echo.
echo [INFO] ���� ᪮��� �����襭
echo [TIP] ��� ����� ���� १���⮢ �ᯮ���� speedtest.net
pause
goto MONITORING_MAIN

:RESTART_BYPASS
echo.
echo [INFO] ��⠭���� ⥪��� ����ᮢ...
taskkill /f /im winws.exe 2>nul
timeout /t 2 >nul

echo [INFO] ����� 㬭��� ��⮮�室�...
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=3 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=2 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum

echo [SUCCESS] ���� ��⮮�室 ��१���饭!
timeout /t 2 >nul
goto MONITORING_MAIN

:STOP_ALL_MONITORING
echo.
echo [INFO] ��⠭���� ��� �㦡...
for %%s in (ZapretUltimate_Smart ZapretUltimate_Quick ZapretUltimate_Full ZapretUltimate_Hybrid ZapretUltimate_Stealth ZapretUltimate ZapretDPI) do (
    sc stop "%%s" 2>nul
)

echo [INFO] ��⠭���� ��� ����ᮢ...
taskkill /f /im winws.exe 2>nul

echo [SUCCESS] �� ������ ��⠭������
timeout /t 2 >nul
goto MONITORING_MAIN