@echo off
title Zapret Ultimate - �������� �㦡�
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
echo         �������� ZAPRET ULTIMATE �����
echo ========================================================
echo.
echo [OK] �ࠢ� ����������� ����祭� ��⮬���᪨
echo.
echo [INFO] ���� � ��⠭���� ��� �㦡 Zapret...

REM ���᮪ ��� ��������� �㦡
set services=ZapretDPI ZapretUltimate ZapretUltimate_Smart ZapretUltimate_Quick ZapretUltimate_Full ZapretUltimate_Hybrid ZapretUltimate_Stealth

for %%s in (%services%) do (
    echo [INFO] �஢�ઠ �㦡�: %%s
    sc query "%%s" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [FOUND] ��⠭���� �㦡�: %%s
        sc stop "%%s" 2>nul
        timeout /t 2 >nul
        echo [REMOVE] �������� �㦡�: %%s
        sc delete "%%s" 2>nul
        if !errorlevel! equ 0 (
            echo [SUCCESS] ��㦡� %%s �ᯥ譮 㤠����
        ) else (
            echo [WARN] �஡���� � 㤠������ �㦡� %%s
        )
    ) else (
        echo [INFO] ��㦡� %%s �� �������
    )
    echo.
)

echo [INFO] �ਭ㤨⥫쭠� ��⠭���� ��� ����ᮢ winws...
taskkill /f /im winws.exe 2>nul
if %errorlevel% equ 0 (
    echo [SUCCESS] ������ winws ��⠭������
) else (
    echo [INFO] ������ winws �� �������
)

echo.
echo [INFO] ���⪠ �६����� 䠩���...
if exist "temp\*.*" (
    del /q temp\*.* 2>nul
    echo [SUCCESS] �६���� 䠩�� ��饭�
)

echo [INFO] ���⪠ ��⥬��� �ࠢ��...
netsh advfirewall firewall delete rule name="Zapret" 2>nul
netsh advfirewall firewall delete rule name="ZapretUltimate" 2>nul

echo.
echo ========================================================
echo            �������� ��������� �������!
echo ========================================================
echo.
echo [SUCCESS] �� �㦡� Zapret Ultimate 㤠����
echo [SUCCESS] �� ������ ��⠭������
echo [SUCCESS] ���⥬� ��饭�
echo.
echo [INFO] ��室 �����஢�� ��������� �⪫�祭
echo [INFO] ����� ������᭮ 㤠���� ����� �ணࠬ��
echo.
pause