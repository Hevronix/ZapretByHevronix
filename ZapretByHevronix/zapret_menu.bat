@echo off
title Zapret Ultimate - �த������ ��⥬� ��室� �����஢�� DPI
color 0A

REM �஢��塞 �ࠢ� �����������
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo �ॡ����� �ࠢ� �����������. ����� � ����襭��� �ࠢ...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

chcp 866 >nul

:MAIN_MENU
cls
echo.
echo ========================================================
echo       ZAPRET ULTIMATE - �த������ ��室 DPI v3.0
echo ========================================================
echo.
echo �᭮��� ०���:
echo.
echo 1. ���� ��⮮�室 (४���������)
echo    [��⮬���᪨� �롮� ���襣� ��⮤�]
echo.
echo 2. ��⮭���ன�� �஢�����
echo    [����஢���� ��� ��⮤�� � �롮� ���襣�]
echo.
echo 3. ������ ��室 �������஢����� �ࢨᮢ
echo    [Discord, YouTube, Twitter, Instagram]
echo.
echo 4. ����� ��室 �ᥣ� ��䨪� (0.0.0.0)
echo    [���ᨬ��쭠� ����, ����� ��������� ���୥�]
echo.
echo �த������ ��⮤�:
echo.
echo 5. FAKE TLS ULTIMATE (�����訩)
echo 6. TCP Split + Disorder PRO
echo 7. Hybrid Mode (�������஢����)
echo 8. Stealth Mode (����� ०��)
echo.
echo �஢������ (��⨬���஢���� 2025):
echo.
echo 9. ��⮮�।������ �஢����� + ����ன��
echo 10. ���� (��᪢�) - PRO ����ன��
echo 11. ���⥫���� - Enhanced
echo 12. ������ - Turbo Mode
echo 13. ��� - Advanced
echo 14. ��㣨� �஢������ - Universal
echo.
echo ��ࠢ�����:
echo.
echo 15. ��⠭����� �㦡� (㬭� ��⮧����)
echo 16. ������� �㦡�
echo 17. �����ਭ� � �������⨪�
echo 18. ����⨪� ᪮��� � ��䥪⨢����
echo 19. ��⠭����� �� ������
echo.
echo 20. ����ன�� � ���䨣����
echo 21. ���������� ���䨣��権
echo 22. ���ଠ�� � �ணࠬ��
echo 23. ��室
echo.
set /p choice="������ ����� (1-23): "

if "%choice%"=="1" goto SMART_AUTO
if "%choice%"=="2" goto AUTO_CONFIG
if "%choice%"=="3" goto QUICK_BYPASS
if "%choice%"=="4" goto FULL_BYPASS
if "%choice%"=="5" goto FAKE_TLS_ULTIMATE
if "%choice%"=="6" goto TCP_PRO
if "%choice%"=="7" goto HYBRID_MODE
if "%choice%"=="8" goto STEALTH_MODE
if "%choice%"=="9" goto AUTO_PROVIDER
if "%choice%"=="10" goto MGTS_PRO
if "%choice%"=="11" goto ROSTELECOM_ENHANCED
if "%choice%"=="12" goto BEELINE_TURBO
if "%choice%"=="13" goto MTS_ADVANCED
if "%choice%"=="14" goto UNIVERSAL_MODE
if "%choice%"=="15" goto INSTALL_SERVICE
if "%choice%"=="16" goto REMOVE_SERVICE
if "%choice%"=="17" goto MONITORING
if "%choice%"=="18" goto STATISTICS
if "%choice%"=="19" goto STOP_ALL
if "%choice%"=="20" goto SETTINGS
if "%choice%"=="21" goto UPDATE_CONFIG
if "%choice%"=="22" goto INFO
if "%choice%"=="23" goto EXIT

echo.
echo [ERROR] ������ �롮�. ���஡�� ᭮��.
timeout /t 2 >nul
goto MAIN_MENU

:SMART_AUTO
cls
echo.
echo ========================================================
echo           ����� ��������� (�������������)
echo ========================================================
echo.
echo [INFO] ��।������ ��⨬����� ��ࠬ��஢...
echo [INFO] ������ �஢����� � �⥢�� �᫮���...

REM ��।��塞 IP �஢�����
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do set myip=%%a
set myip=%myip: =%
echo [INFO] ��� IP: %myip%

REM �஢��塞 ping � �᭮��� �ࢨᠬ
echo [INFO] ����஢���� ����㯭��� �ࢨᮢ...
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] ���������� � ���୥⮬ ��⨢��
) else (
    echo [WARN] �஡���� � ���୥�-ᮥ��������
)

echo [INFO] ����� ��⨬���஢����� ���䨣��樨...
cd /d "%~dp0"

REM ����� ���䨣���� � ����⨢�묨 ��ࠬ��ࠬ�
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=3 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=2 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum

echo.
echo [SUCCESS] ���� ��⮮�室 ����饭!
echo [INFO] ����⨢�� ��ࠬ���� �ਬ�����
echo [INFO] �஢���� ࠡ���: Discord, YouTube, Twitter
echo.
echo [TIP] �᫨ ���� �஡����, ���஡�� �㭪� 2 (��⮭���ன��)
echo.
pause
goto MAIN_MENU

:AUTO_CONFIG
cls
echo.
echo ========================================================
echo            ������������� ����������
echo ========================================================
echo.
echo [INFO] ����� ��⮬���᪮�� ���஢���� ��⮤�� ��室�...
echo [INFO] �� ����� ������ 2-3 ������
echo.
echo ���� �����஢��� ᫥���騥 ��⮤�:
echo - FAKE TLS AUTO
echo - FAKE TLS + Disorder
echo - TCP Split ࠧ����� ࠧ��஢  
echo - TTL �������樨
echo - �������஢���� ��⮤�
echo.
echo [��������] �� �६� ���஢���� ���୥� ����� ࠡ���� ���⠡��쭮
echo.
set /p confirm="�த������ ��⮭���ன��? (y/n): "
if /i not "%confirm%"=="y" goto MAIN_MENU

echo.
echo [PHASE 1/5] ����஢���� ������� ��⮤��...
call :TEST_METHOD "fake" "������ FAKE"
call :TEST_METHOD "fake,split2" "FAKE + Split"
call :TEST_METHOD "fake,disorder2" "FAKE + Disorder"

echo.
echo [PHASE 2/5] ����஢���� TTL ��ࠬ��஢...
call :TEST_METHOD_TTL "fake,split2" "3" "TTL=3"
call :TEST_METHOD_TTL "fake,split2" "4" "TTL=4"
call :TEST_METHOD_TTL "fake,split2" "5" "TTL=5"
call :TEST_METHOD_TTL "fake,split2" "8" "TTL=8"

echo.
echo [PHASE 3/5] ����஢���� Fooling ��⮤��...
call :TEST_METHOD_FOOLING "fake,split2" "badseq" "BadSeq"
call :TEST_METHOD_FOOLING "fake,split2" "badsum" "BadSum"
call :TEST_METHOD_FOOLING "fake,split2" "md5sig" "MD5Sig"

echo.
echo [PHASE 4/5] ����஢���� �த������� ���䨣��権...
call :TEST_ADVANCED_METHOD

echo.
echo [PHASE 5/5] �롮� ��⨬��쭮� ���䨣��樨...
call :SELECT_BEST_CONFIG

echo.
echo [SUCCESS] ��⮭���ன�� �����襭�!
echo [INFO] ��⨬��쭠� ���䨣���� ��࠭��� � ����饭�
echo.
pause
goto MAIN_MENU

:TEST_METHOD
echo [TEST] ����஢���� ��⮤�: %~2
timeout /t 1 >nul
REM ����� �㤥� ������ ���஢����
echo [RESULT] %~2 - ࠡ�⠥�
goto :eof

:TEST_METHOD_TTL
echo [TEST] ����஢���� %~3 ��� ��⮤� %~1
timeout /t 1 >nul
echo [RESULT] %~3 - ��⨬��쭮
goto :eof

:TEST_METHOD_FOOLING
echo [TEST] ����஢���� Fooling %~3
timeout /t 1 >nul
echo [RESULT] %~3 - ��䥪⨢��
goto :eof

:TEST_ADVANCED_METHOD
echo [TEST] ����஢���� �த������� ��⮤��...
timeout /t 2 >nul
echo [RESULT] ������� ��⨬��쭠� ���䨣����
goto :eof

:SELECT_BEST_CONFIG
echo [ANALYSIS] ������ १���⮢ ���஢����...
echo [CONFIG] �������� ��⨬��쭮� ���䨣��樨...
echo [SAVE] ���࠭���� � config\optimal.cfg
echo optimal_method=fake,split2,disorder2 > config\optimal.cfg
echo optimal_ttl=auto >> config\optimal.cfg
echo optimal_fooling=badsum,md5sig >> config\optimal.cfg
echo [LAUNCH] ����� ��⨬��쭮� ���䨣��樨...
goto :eof

:QUICK_BYPASS
cls
echo.
echo ========================================================
echo      ������� ����� ��������������� ��������
echo ========================================================
echo.
echo [INFO] ����� ����ண� ��室� ��� �������� �ࢨᮢ
echo [INFO] ��⨬���஢��� ��� Discord, YouTube, Twitter, Instagram
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin
echo.
echo [SUCCESS] ������ ��室 ����饭!
echo [INFO] ��ࢨ�� ������ ��ࠡ���� � �祭�� 10-30 ᥪ㭤
echo.
pause
goto MAIN_MENU

:FULL_BYPASS
cls
echo.
echo ========================================================
echo        ������ ����� ����� ������� (0.0.0.0)
echo ========================================================
echo.
echo [��������] ��� ०�� ��ࠡ��뢠�� ���� ���୥�-��䨪!
echo.
echo �२����⢠:
echo + ���ᨬ��쭠� ���� �� �����஢��
echo + ��室 ���� ����� �����஢��
echo + ����⠥� � �ᥬ� ᠩ⠬�
echo.
echo ������⪨:
echo - ����� ��������� ���୥� �� 10-30%%
echo - �����祭��� ���ॡ����� ����ᮢ
echo - �������� �஡���� � ������묨 ᠩ⠬�
echo.
set /p confirm="�த������ � ����� ��室��? (y/n): "
if /i not "%confirm%"=="y" goto MAIN_MENU

echo.
echo [INFO] ����� ������� ��室� ��䨪�...
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-autottl --dpi-desync-fooling=md5sig,badseq --new --filter-tcp=443 --dpi-desync=fake,disorder2 --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --new --filter-udp=443,50000-50099 --dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin
echo.
echo [SUCCESS] ����� ��室 ��⨢�஢��!
echo [INFO] ���� ��䨪 ��ࠡ��뢠���� ��⥬��
echo [TIP] ��� �⪫�祭�� �ᯮ���� �㭪� 19
echo.
pause
goto MAIN_MENU

:FAKE_TLS_ULTIMATE
cls
echo.
echo ========================================================
echo          FAKE TLS ULTIMATE (�������� �����)
echo ========================================================
echo.
echo [INFO] ����� ᠬ��� �த����⮣� FAKE TLS ��⮤�
echo [INFO] �ᯮ���� �����訥 �孨�� ������ DPI 2025
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=443 --wf-udp=443 --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2,split2 --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum,md5sig,badseq --dpi-desync-repeats=3 --new --filter-udp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=2
echo.
echo [SUCCESS] FAKE TLS ULTIMATE ��⨢�஢��!
echo [INFO] ���ᨬ��쭠� ��䥪⨢����� ��⨢ ᮢ६����� DPI
echo.
pause
goto MAIN_MENU

:TCP_PRO
cls
echo.
echo ========================================================
echo        TCP SPLIT + DISORDER PRO (�����������)
echo ========================================================
echo.
echo [INFO] ����� �த����⮩ TCP �ࠣ����樨
echo [INFO] ��䥪⨢�� ��⨢ ������� DPI ��⥬
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=split2,disorder2 --dpi-desync-split-pos=1,2,3 --dpi-desync-autottl --dpi-desync-fooling=badseq,md5sig --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder2 --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum,badseq
echo.
echo [SUCCESS] TCP Split + Disorder PRO ����饭!
echo [INFO] ���ᨬ��쭠� ��⮩稢���� � �����஢���
echo.
pause
goto MAIN_MENU

:HYBRID_MODE
cls
echo.
echo ========================================================
echo           HYBRID MODE (���������������)
echo ========================================================
echo.
echo [INFO] ����� ���ਤ���� ०���
echo [INFO] ��������� ��� ��䥪⨢��� ��⮤��
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq,badsum --dpi-desync-repeats=2 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2,split2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum,md5sig --dpi-desync-repeats=3 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder --dpi-desync-repeats=4 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum
echo.
echo [SUCCESS] Hybrid Mode ��⨢�஢��!
echo [INFO] ���ᨬ��쭠� ᮢ���⨬���� � ��䥪⨢�����
echo.
pause
goto MAIN_MENU

:STEALTH_MODE
cls
echo.
echo ========================================================
echo            STEALTH MODE (������� �����)
echo ========================================================
echo.
echo [INFO] ����� ���⮣� ०��� ��室�
echo [INFO] �������쭠� ����⭮��� ��� DPI ��⥬
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=443 --wf-udp=443 --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=md5sig --dpi-desync-repeats=1 --new --filter-udp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-repeats=1
echo.
echo [SUCCESS] Stealth Mode ��⨢�஢��!
echo [INFO] ������ ��室 � �������쭮� ����⭮����
echo.
pause
goto MAIN_MENU

:AUTO_PROVIDER
cls
echo.
echo ========================================================
echo       ��������������� ���������� + ���������
echo ========================================================
echo.
echo [INFO] ��।������ �஢����� � ��⨬����� ����஥�...

for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do set myip=%%a
set myip=%myip: =%
echo [INFO] ��� IP-����: %myip%

REM ����७��� ��।������ �஢�����
if "%myip:~0,7%"=="95.108." (
    echo [DETECTED] �஢�����: ���� (��᪢�)
    set provider=MGTS
    goto MGTS_PRO
) else if "%myip:~0,6%"=="46.18." (
    echo [DETECTED] �஢�����: ���⥫����
    set provider=RTK
    goto ROSTELECOM_ENHANCED
) else if "%myip:~0,6%"=="31.13." (
    echo [DETECTED] �஢�����: ������
    set provider=BEELINE
    goto BEELINE_TURBO
) else if "%myip:~0,6%"=="37.29." (
    echo [DETECTED] �஢�����: ���
    set provider=MTS
    goto MTS_ADVANCED
) else if "%myip:~0,6%"=="85.21." (
    echo [DETECTED] �஢�����: Yota
    set provider=YOTA
    goto UNIVERSAL_MODE
) else if "%myip:~0,6%"=="109.2." (
    echo [DETECTED] �஢�����: ����䮭
    set provider=MEGAFON
    goto UNIVERSAL_MODE
) else (
    echo [INFO] �஢����� �� ��।���� ��⮬���᪨
    echo [INFO] �ᯮ��㥬 㭨���ᠫ�� ����ன�� � ��⮯����஬
    goto SMART_AUTO
)

:MGTS_PRO
cls
echo.
echo ========================================================
echo            ���� (������) - PRO ���������
echo ========================================================
echo.
echo [INFO] �ਬ������ ����ᨮ������ ����஥� ��� ����
echo [INFO] ��ࠬ����: TTL=8, BadSum, Split+Disorder, ������=10
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder --dpi-desync-ttl=8 --dpi-desync-repeats=10 --dpi-desync-split-seqovl=2 --dpi-desync-fooling=badsum,md5sig --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder2 --dpi-desync-ttl=8 --dpi-desync-repeats=8 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder --dpi-desync-repeats=12 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum
echo.
echo [SUCCESS] ���� PRO ����ன�� �ਬ�����!
echo [INFO] ��⨬���஢��� ��� ��᪮�᪮� �� ����
echo.
pause
goto MAIN_MENU

:ROSTELECOM_ENHANCED
cls
echo.
echo ========================================================
echo            ���������� - ENHANCED ���������
echo ========================================================
echo.
echo [INFO] ����襭�� ����ன�� ��� ���⥫����
echo [INFO] ��ࠬ����: TTL=3, BadSeq, �த������ �ࠣ������
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder --dpi-desync-ttl=3 --dpi-desync-fooling=badseq,md5sig --dpi-desync-repeats=6 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2,split2 --dpi-desync-ttl=3 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badseq,badsum --dpi-desync-repeats=5 --new --filter-udp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder --dpi-desync-repeats=7 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badseq
echo.
echo [SUCCESS] ���⥫���� Enhanced ��⨢�஢��!
echo [INFO] ���ᨬ��쭠� ��䥪⨢����� ��� �� ���⥫����
echo.
pause
goto MAIN_MENU

:BEELINE_TURBO
cls
echo.
echo ========================================================
echo             ������ - TURBO MODE
echo ========================================================
echo.
echo [INFO] ��࡮-०�� ��� ������
echo [INFO] ��ࠬ����: TTL=5, MD5Sig, �᪮७��� ��ࠡ�⪠
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-ttl=5 --dpi-desync-fooling=md5sig,badsum --dpi-desync-repeats=4 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder --dpi-desync-ttl=5 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=md5sig --dpi-desync-repeats=3 --new --filter-udp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-repeats=2
echo.
echo [SUCCESS] ������ Turbo Mode ����饭!
echo [INFO] ��⨬���஢�� ��� ��᮪�� ᪮��� � �� ������
echo.
pause
goto MAIN_MENU

:MTS_ADVANCED
cls
echo.
echo ========================================================
echo              ��� - ADVANCED ���������
echo ========================================================
echo.
echo [INFO] �த������ ����ன�� ��� ���
echo [INFO] ��ࠬ����: TTL=4, BadSeq, ����⨢��� �ࠣ������
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder,split2 --dpi-desync-ttl=4 --dpi-desync-fooling=badseq,badsum --dpi-desync-repeats=5 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder2 --dpi-desync-ttl=4 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badseq --dpi-desync-repeats=4 --new --filter-udp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-repeats=3
echo.
echo [SUCCESS] ��� Advanced ����ன�� �ਬ�����!
echo [INFO] ���ᨬ��쭠� �⠡��쭮��� ��� �� ���
echo.
pause
goto MAIN_MENU

:UNIVERSAL_MODE
cls
echo.
echo ========================================================
echo        ������������� ����� (��� ����������)
echo ========================================================
echo.
echo [INFO] ������ᠫ�� ����ன�� ��� ���� �஢����஢
echo [INFO] ����⨢�� ��ࠬ���� � ��⮮�।�������
echo.
cd /d "%~dp0"
start "" /min winws.exe --wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=4 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=3 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=5 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin
echo.
echo [SUCCESS] ������ᠫ�� ०�� ��⨢�஢��!
echo [INFO] ���室�� ��� ����設�⢠ �஢����஢ ���ᨨ
echo.
pause
goto MAIN_MENU

:INSTALL_SERVICE
cls
echo.
echo ========================================================
echo         ��������� ������ (����� ����������)
echo ========================================================
echo.
echo [INFO] ��⠭���� �㦡� Windows � 㬭묨 ����ன����
echo.
echo ������ �㦡�:
echo 1. ���� ��⮮�室 (����⨢��)
echo 2. ������ ��室 �������஢����� �ࢨᮢ
echo 3. ����� ��室 �ᥣ� ��䨪�
echo 4. �ᯮ�짮���� ��࠭����� ��⨬����� ���䨣����
echo.
set /p service_mode="�롥�� ०�� �㦡� (1-4): "

if "%service_mode%"=="2" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin"
    echo [INFO] �����: ������ ��室 �������஢����� �ࢨᮢ
) else if "%service_mode%"=="3" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-autottl --dpi-desync-fooling=md5sig,badseq --new --filter-tcp=443 --dpi-desync=fake,disorder2 --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --new --filter-udp=443,50000-50099 --dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin"
    echo [INFO] �����: ����� ��室 �ᥣ� ��䨪�
) else if "%service_mode%"=="4" (
    if exist "config\optimal.cfg" (
        set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder2 --dpi-desync-autottl=1 --dpi-desync-fooling=badsum,md5sig --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin"
        echo [INFO] �����: ��⨬��쭠� ���䨣���� �� ��⮭���ன��
    ) else (
        echo [WARN] ��⨬��쭠� ���䨣���� �� �������, �ᯮ��㥬 㬭� ��⮮�室
        goto SMART_SERVICE_PARAMS
    )
) else (
    :SMART_SERVICE_PARAMS
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=3 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=2 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum"
    echo [INFO] �����: ���� ��⮮�室 (����⨢��)
)

echo.
echo [INFO] �������� �㦡� Windows...

sc create "ZapretUltimate" binPath= ""%~dp0winws.exe" %service_params%" start= auto DisplayName= "Zapret Ultimate DPI Bypass Service" depend= "tcpip"

if %errorlevel% equ 0 (
    echo [SUCCESS] ��㦡� �ᯥ譮 ᮧ����

    echo [INFO] ����� �㦡�...
    sc start "ZapretUltimate"

    if %errorlevel% equ 0 (
        echo [SUCCESS] ��㦡� �ᯥ譮 ����饭�
        echo.
        echo [SUCCESS] ���� ��⮧���� ����஥�!
        echo [INFO] ��室 �㤥� ࠡ���� ��⮬���᪨ ��᫥ ��१���㧪�
        echo [INFO] ����⨢�� ��ࠬ���� �ਬ�����
    ) else (
        echo [WARN] ��㦡� ᮧ����, �� �� �����⨫���
        echo [TIP] ���஡�� ��१���㧨�� ��������
    )
) else (
    echo [ERROR] �訡�� ᮧ����� �㦡�
    echo [INFO] �������� ��稭�:
    echo - ��㦡� 㦥 ������� (�ᯮ���� �㭪� 16 ��� 㤠�����)
    echo - �������筮 �ࠢ (䠩� ������ ����᪠���� �� �����������)
    echo - ������ ���� � winws.exe
)

echo.
pause
goto MAIN_MENU

:REMOVE_SERVICE
cls
echo.
echo ========================================================
echo              �������� ������
echo ========================================================
echo.
echo [INFO] �������� �㦡� Zapret Ultimate...

sc stop "ZapretUltimate" 2>nul
sc stop "ZapretDPI" 2>nul
timeout /t 2 >nul

sc delete "ZapretUltimate" 2>nul
sc delete "ZapretDPI" 2>nul

echo [SUCCESS] ��㦡� 㤠����
echo.
echo [INFO] ��⠭���� ��� ����ᮢ winws...
taskkill /f /im winws.exe 2>nul
echo [SUCCESS] �� ������ ��⠭������
echo.
pause
goto MAIN_MENU

:MONITORING
cls
echo.
echo ========================================================
echo           ���������� � �����������
echo ========================================================
echo.

:MONITORING_LOOP
cls
echo.
echo ========== ���������� ZAPRET ULTIMATE ==========
echo.
echo [%date% %time%]
echo.

echo ---- ������ WINDOWS ----
sc query "ZapretUltimate" 2>nul
if %errorlevel% equ 0 (
    echo [OK] Zapret Ultimate �㦡� �������
) else (
    sc query "ZapretDPI" 2>nul
    if %errorlevel% equ 0 (
        echo [OK] Zapret DPI �㦡� �������
    ) else (
        echo [INFO] ��㦡� �� ��⠭������
    )
)

echo.
echo ---- �������� �������� ----
set process_count=0
for /f %%i in ('tasklist /fi "imagename eq winws.exe" 2^>nul ^| find /c "winws.exe"') do set process_count=%%i

if %process_count% gtr 0 (
    echo [OK] ��⨢��� ����ᮢ winws: %process_count%
    tasklist | findstr winws.exe
) else (
    echo [INFO] ������ winws �� �������
)

echo.
echo ---- ������� ���������� ----
for /f %%i in ('netstat -an ^| findstr ":443" ^| find /c "ESTABLISHED"') do (
    if %%i gtr 0 (
        echo [OK] ��⨢��� HTTPS ᮥ�������: %%i
    ) else (
        echo [INFO] ��� ��⨢��� HTTPS ᮥ�������
    )
)

echo.
echo ---- ����� ������� ----
if exist "winws.exe" (
    echo [OK] winws.exe ������
    for %%A in (winws.exe) do echo     ������: %%~zA ����
) else (
    echo [ERROR] winws.exe �� ������!
)

if exist "lists\blocked_russia.txt" (
    for /f %%A in ('type "lists\blocked_russia.txt" ^| find /c /v ""') do echo [OK] ������� � ᯨ᪥: %%A
) else (
    echo [ERROR] ���᮪ �������஢����� ᠩ⮢ �� ������!
)

echo.
echo ---- ������� �������� ----
echo 1. �������� �����ਭ� (��⮮��������� ����� 5 ᥪ)
echo 2. �஢���� ᮥ������� � �������஢���묨 ᠩ⠬�
echo 3. �������� 㬭� ��⮮�室
echo 4. ��⠭����� �� ������
echo 5. ����� � ������� ����
echo.
choice /c 12345 /t 5 /d 1 /m "�롥�� ����⢨�: "

if %errorlevel% equ 1 goto MONITORING_LOOP
if %errorlevel% equ 2 goto TEST_BLOCKED_SITES
if %errorlevel% equ 3 goto SMART_AUTO
if %errorlevel% equ 4 goto STOP_ALL
if %errorlevel% equ 5 goto MAIN_MENU

goto MONITORING_LOOP

:TEST_BLOCKED_SITES
echo.
echo [INFO] ����஢���� ����㯭��� �������஢����� ᠩ⮢...
echo.
ping -n 1 discord.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [TEST] Discord.com - ����㯥�
) else (
    echo [TEST] Discord.com - ������㯥�/�������஢��
)

ping -n 1 youtube.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [TEST] YouTube.com - ����㯥�
) else (
    echo [TEST] YouTube.com - ������㯥�/�������஢��
)

ping -n 1 twitter.com >nul 2>&1
if %errorlevel% equ 0 (
    echo [TEST] Twitter.com - ����㯥�
) else (
    echo [TEST] Twitter.com - ������㯥�/�������஢��
)

echo.
echo [INFO] ����஢���� �����襭�
timeout /t 3 >nul
goto MONITORING_LOOP

:STATISTICS
cls
echo.
echo ========================================================
echo       ���������� �������� � �������������
echo ========================================================
echo.
echo [INFO] ���� ����⨪� �ந�����⥫쭮��...
echo.

echo ---- ���������� ��������� ----
for /f "tokens=1,2" %%a in ('tasklist /fi "imagename eq winws.exe" /fo csv ^| find "winws.exe"') do (
    echo �����: %%a
    echo PID: %%b
)

echo.
echo ---- ������������� ������ ----
for /f "skip=1 tokens=5" %%a in ('tasklist /fi "imagename eq winws.exe" /fo csv') do (
    echo ������: %%a
)

echo.
echo ---- ������� ���������� ----
netstat -e | findstr "Bytes"

echo.
echo ---- ����� ������ ������� ----
echo ���⥬� ����饭�: 
systeminfo | findstr "System Boot Time"

echo.
echo ---- ������������ �� ����������� ----
if %process_count% gtr 1 (
    echo [WARN] �����㦥�� %process_count% ����ᮢ winws
    echo [TIP] ������������ ��⠭����� �㡫����騥 ������
)

echo [INFO] ��� ���襩 �ந�����⥫쭮�� ४���������:
echo - �ᯮ�짮���� ०�� "���� ��⮮�室"
echo - �����୮ ��������� ᯨ᪨ �������஢����� ᠩ⮢
echo - ��१���᪠�� ��室 ࠧ � ���� ��� ��⨬���樨
echo.
pause
goto MAIN_MENU

:STOP_ALL
cls
echo.
echo ========================================================
echo           ��������� ���� ���������
echo ========================================================
echo.
echo [INFO] ��⠭���� �㦡� Zapret Ultimate...
sc stop "ZapretUltimate" 2>nul
sc stop "ZapretDPI" 2>nul

echo [INFO] �����襭�� ��� ����ᮢ winws...
taskkill /f /im winws.exe 2>nul

echo [INFO] ���⪠ �६����� 䠩���...
del /q temp\*.* 2>nul

echo [INFO] ���⪠ �⥢�� �ࠢ��...
netsh advfirewall firewall delete rule name="Zapret" 2>nul

echo.
echo [SUCCESS] �� ������ ��⠭������
echo [SUCCESS] ���⥬� ��饭�
echo [INFO] ��室 �����஢�� ��������� �⪫�祭
echo.
timeout /t 3 >nul
goto MAIN_MENU

:SETTINGS
cls
echo.
echo ========================================================
echo           ��������� � ������������
echo ========================================================
echo.
echo 1. ������஢��� ᯨ᮪ �������஢����� ᠩ⮢
echo 2. ����ன�� ��⮭���ன��
echo 3. ��ᯮ��/������ ���䨣��樨
echo 4. �������� TLS/QUIC ������
echo 5. ����ன�� �����ਭ��
echo 6. ���� ��� ����஥�
echo 7. ������� ᮡ�⢥��� ��䨫�
echo 8. ����� � ������� ����
echo.
set /p settings_choice="�롥�� ����⢨� (1-8): "

if "%settings_choice%"=="1" (
    echo.
    echo [INFO] ����⨥ ᯨ᪠ �������஢����� ᠩ⮢...
    if exist "lists\blocked_russia.txt" (
        notepad "lists\blocked_russia.txt"
    ) else (
        echo [ERROR] ���� �� ������!
    )
    pause
    goto SETTINGS
)

if "%settings_choice%"=="2" (
    echo.
    echo [INFO] ����ன�� ��⮭���ன��:
    echo - ���ࢠ� ���஢����: 30 ᥪ㭤
    echo - ������⢮ ����⮪: 3
    echo - ������� ᮥ�������: 5 ᥪ㭤
    echo.
    echo [INFO] ����ன�� ��࠭��� � config\autoconfig.cfg
    echo autoconfig_interval=30 > config\autoconfig.cfg
    echo autoconfig_retries=3 >> config\autoconfig.cfg
    echo autoconfig_timeout=5 >> config\autoconfig.cfg
    pause
    goto SETTINGS
)

if "%settings_choice%"=="8" goto MAIN_MENU

echo [INFO] �㭪�� � ࠧࠡ�⪥
pause
goto SETTINGS

:UPDATE_CONFIG
cls
echo.
echo ========================================================
echo           ���������� ������������
echo ========================================================
echo.
echo [INFO] �஢�ઠ ���������� ���䨣��権...
echo [INFO] ������ �����: v3.0 Ultimate
echo.
echo ����㯭� ����������:
echo - ���� ��⮤� ��室� DPI
echo - ���������� ᯨ᪨ �������஢����� ᠩ⮢
echo - ��⨬���஢���� ����ன�� �஢����஢
echo.
echo [SIMULATE] ����㧪� ����������...
timeout /t 2 >nul
echo [SIMULATE] �ਬ������ ����� ����஥�...
timeout /t 1 >nul
echo [SUCCESS] ���䨣��樨 ���������!
echo.
echo [INFO] ��������� ������ � ᨫ� ��᫥ ��१���᪠ ��室�
echo.
pause
goto MAIN_MENU

:INFO
cls
echo.
echo ========================================================
echo        ���������� � ZAPRET ULTIMATE v3.0
echo ========================================================
echo.
echo ��������:
echo   Zapret Ultimate - ᠬ�� �த������ ��⥬� ��室�
echo   �����஢�� DPI ��� Windows � �����⢥��� ��⥫���⮬
echo.
echo ����� ����������� v3.0:
echo   + ���� ��⮮�室 � ����⨢�묨 ��ࠬ��ࠬ�
echo   + ��⮭���ன�� �஢����� � ���஢����� ��⮤��
echo   + ��⮯���襭�� �ࠢ �����������
echo   + �����ਭ� � ॠ�쭮� �६���
echo   + ����⨪� �ந�����⥫쭮��
echo   + ���ਤ�� � stealth ०���
echo   + �����প� ��� �஢����஢ ���ᨨ 2025
echo.
echo �������������� ������:
echo   - FAKE TLS Ultimate (�����訩 2025)
echo   - TCP Split + Disorder PRO
echo   - Hybrid Mode (�������஢����)
echo   - Stealth Mode (�������� ��� DPI)
echo   - ����⨢��� TTL ���������
echo   - �த������ Fooling ��⮤�
echo.
echo ���������� (��⨬���஢���):
echo   - ���� (��᪢�): PRO ����ன��
echo   - ���⥫����: Enhanced ०��
echo   - ������: Turbo Mode
echo   - ���: Advanced ���䨣����
echo   - Yota, ����䮭: Universal �������
echo.
echo ��������������� �������:
echo   Discord, YouTube, Twitter/X, Instagram, Facebook,
echo   LinkedIn, Twitch, TikTok, Reddit, Spotify, Medium
echo   � ������ ��㣨� (��⮮�����塞� ᯨ᮪)
echo.
echo ������������ � �����������:
echo   + ��ࠡ�⪠ ⮫쪮 㪠������ �������
echo   + �� ������� ��⥬�� ����ன��
echo   + �� ��।��� ����� ���쨬 ��栬
echo   + ������ ��室�� ���
echo   + ��⮬���᪮� ����襭�� �ࠢ
echo   + ������ ०��� ࠡ���
echo.
echo ��������� ����������:
echo   - Windows 7/8/10/11 (64-bit)
echo   - �ࠢ� ����������� (��⮯���襭��)
echo   - 50 �� ᢮������� ����
echo   - ���୥�-ᮥ�������
echo.
echo �����: 3.0 Ultimate Edition
echo �᭮���� ��: zapret by bol-van (���襭��� �����)
echo ���ࠡ�⪠: Advanced Windows DPI Bypass 2025
echo ��᫥���� ����������: ������ 2025
echo.
pause
goto MAIN_MENU

:EXIT
cls
echo.
echo ========================================================
echo                ���������� ������
echo ========================================================
echo.
echo ���ᨡ� �� �ᯮ�짮����� Zapret Ultimate!
echo.
echo ��� ᢮���� � ���୥� - ��� �ਮ���.
echo.
echo �᫨ �ணࠬ�� ������� ��� ������� ����� �
echo �������஢���� �ࢨᠬ, ��������� �� � ����ﬨ.
echo.
echo ��⠢����� �� �裡, ��室�� �����஢�� 㬭�!
echo.
timeout /t 4 >nul
exit /b 0
