@echo off
title Zapret Ultimate - ��⠭���� �㦡� � ��⮯ࠢ���
color 0C

REM ��⮬���᪮� ����襭�� �ࠢ
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo �ॡ����� �ࠢ� �����������. ����祭�� �ࠢ...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

chcp 866 >nul

echo.
echo ========================================================
echo        ��������� ZAPRET ULTIMATE ������
echo ========================================================
echo.
echo [OK] �ࠢ� ����������� ����祭� ��⮬���᪨
echo.
echo ����㯭� ०��� �㦡�:
echo.
echo 1. ���� ��⮮�室 (४���������)
echo    [����⨢�� ��ࠬ����, ��⮮�⨬�����]
echo.
echo 2. ������ ��室 �������஢����� �ࢨᮢ
echo    [Discord, YouTube, �樠��� ��]
echo.
echo 3. ����� ��室 �ᥣ� ��䨪� (0.0.0.0)
echo    [���ᨬ��쭠� ����, ����� ��������� ���୥�]
echo.
echo 4. ���ਤ�� ०�� (�������஢����)
echo    [���⠭�� ��� ��䥪⨢��� ��⮤��]
echo.
echo 5. Stealth ०�� (�����)
echo    [�������쭠� ����⭮��� ��� DPI]
echo.
set /p service_mode="�롥�� ०�� �㦡� (1-5): "

if "%service_mode%"=="2" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin"
    set "service_name=ZapretUltimate_Quick"
    set "service_display=Zapret Ultimate - Quick Bypass Service"
    echo [INFO] �����: ������ ��室 �������஢����� �ࢨᮢ
) else if "%service_mode%"=="3" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-autottl --dpi-desync-fooling=md5sig,badseq --new --filter-tcp=443 --dpi-desync=fake,disorder2 --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --new --filter-udp=443,50000-50099 --dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin"
    set "service_name=ZapretUltimate_Full"
    set "service_display=Zapret Ultimate - Full Bypass Service"
    echo [INFO] �����: ����� ��室 �ᥣ� ��䨪�
) else if "%service_mode%"=="4" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq,badsum --dpi-desync-repeats=2 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2,split2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum,md5sig --dpi-desync-repeats=3 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder --dpi-desync-repeats=4 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum"
    set "service_name=ZapretUltimate_Hybrid"
    set "service_display=Zapret Ultimate - Hybrid Mode Service"
    echo [INFO] �����: ���ਤ�� (�������஢����)
) else if "%service_mode%"=="5" (
    set "service_params=--wf-tcp=443 --wf-udp=443 --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=md5sig --dpi-desync-repeats=1 --new --filter-udp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-repeats=1"
    set "service_name=ZapretUltimate_Stealth"
    set "service_display=Zapret Ultimate - Stealth Mode Service"
    echo [INFO] �����: Stealth (�����)
) else (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=3 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=2 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum"
    set "service_name=ZapretUltimate_Smart"
    set "service_display=Zapret Ultimate - Smart Auto Service"
    echo [INFO] �����: ���� ��⮮�室 (����⨢��)
)

echo.
echo [INFO] �������� ����� �㦡 (�᫨ ����)...
sc stop "ZapretDPI" 2>nul
sc stop "ZapretUltimate" 2>nul
sc stop "%service_name%" 2>nul
sc delete "ZapretDPI" 2>nul
sc delete "ZapretUltimate" 2>nul
sc delete "%service_name%" 2>nul

echo [INFO] �������� ����� �㦡�...
sc create "%service_name%" binPath= ""%~dp0winws.exe" %service_params%" start= auto DisplayName= "%service_display%" depend= "tcpip"

if %errorlevel% equ 0 (
    echo [SUCCESS] ��㦡� �ᯥ譮 ᮧ����: %service_name%

    echo [INFO] ����ன�� ��ࠬ��஢ �㦡�...
    sc config "%service_name%" type= own
    sc config "%service_name%" error= normal

    echo [INFO] ����� �㦡�...
    sc start "%service_name%"

    if %errorlevel% equ 0 (
        echo [SUCCESS] ��㦡� �ᯥ譮 ����饭�!
        echo.
        echo ================================================
        echo           ������ ������� �����������!
        echo ================================================
        echo.
        echo [INFO] �������� �㦡�: %service_name%
        echo [INFO] �����: %service_display%
        echo [INFO] ��⮧����: ����祭
        echo [INFO] �����: ��⨢��
        echo.
        echo [SUCCESS] ��室 �����஢�� �㤥� ࠡ����
        echo ��⮬���᪨ ��᫥ ��१���㧪� ��⥬�!
        echo.
        echo [TIP] ��� �����ਭ�� �ᯮ���� �㭪� 17 � ������� ����
    ) else (
        echo [WARN] ��㦡� ᮧ����, �� �� �����⨫���
        echo [TIP] ���஡��:
        echo - ��१���㧨�� ��������
        echo - �஢���� ����稥 winws.exe
        echo - �⪫���� ��⨢���� �६����
    )
) else (
    echo [ERROR] �訡�� ᮧ����� �㦡�
    echo.
    echo [INFO] �������� ��稭�:
    echo - �������筮 �ࠢ (���஡�� �� ࠧ)
    echo - ������ ���� � winws.exe (�஢���� ����稥 䠩��)
    echo - ��⨢���� �������� ��⠭����
    echo - ��㦡� � ⠪�� ������ 㦥 �������
    echo.
    echo [TIP] ���஡��:
    echo 1. ���������, �� winws.exe ��室���� � ����� �ணࠬ��
    echo 2. �६���� �⪫���� ��⨢����
    echo 3. ��१���㧨�� �������� � ���஡����� ᭮��
)

echo.
pause