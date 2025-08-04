@echo off
title Zapret Ultimate - Установка службы с автоправами
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
echo        УСТАНОВКА ZAPRET ULTIMATE СЛУЖБЫ
echo ========================================================
echo.
echo [OK] Права администратора получены автоматически
echo.
echo Доступные режимы службы:
echo.
echo 1. Умный автообход (рекомендуется)
echo    [Адаптивные параметры, автооптимизация]
echo.
echo 2. Быстрый обход заблокированных сервисов
echo    [Discord, YouTube, социальные сети]
echo.
echo 3. Полный обход всего трафика (0.0.0.0)
echo    [Максимальная защита, может замедлить интернет]
echo.
echo 4. Гибридный режим (комбинированный)
echo    [Сочетание всех эффективных методов]
echo.
echo 5. Stealth режим (скрытый)
echo    [Минимальная заметность для DPI]
echo.
set /p service_mode="Выберите режим службы (1-5): "

if "%service_mode%"=="2" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin"
    set "service_name=ZapretUltimate_Quick"
    set "service_display=Zapret Ultimate - Quick Bypass Service"
    echo [INFO] Режим: Быстрый обход заблокированных сервисов
) else if "%service_mode%"=="3" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-autottl --dpi-desync-fooling=md5sig,badseq --new --filter-tcp=443 --dpi-desync=fake,disorder2 --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --new --filter-udp=443,50000-50099 --dpi-desync=fake --dpi-desync-repeats=4 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin"
    set "service_name=ZapretUltimate_Full"
    set "service_display=Zapret Ultimate - Full Bypass Service"
    echo [INFO] Режим: Полный обход всего трафика
) else if "%service_mode%"=="4" (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2,disorder --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq,badsum --dpi-desync-repeats=2 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2,split2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum,md5sig --dpi-desync-repeats=3 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder --dpi-desync-repeats=4 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum"
    set "service_name=ZapretUltimate_Hybrid"
    set "service_display=Zapret Ultimate - Hybrid Mode Service"
    echo [INFO] Режим: Гибридный (комбинированный)
) else if "%service_mode%"=="5" (
    set "service_params=--wf-tcp=443 --wf-udp=443 --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-autottl --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=md5sig --dpi-desync-repeats=1 --new --filter-udp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-repeats=1"
    set "service_name=ZapretUltimate_Stealth"
    set "service_display=Zapret Ultimate - Stealth Mode Service"
    echo [INFO] Режим: Stealth (скрытый)
) else (
    set "service_params=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,split2 --dpi-desync-autottl=1 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=3 --new --filter-tcp=443 --hostlist=lists\blocked_russia.txt --dpi-desync=fake,disorder2 --dpi-desync-autottl=1 --dpi-desync-fake-tls=bin\tls_clienthello_www_google_com.bin --dpi-desync-fooling=badsum --dpi-desync-repeats=2 --new --filter-udp=443,50000-50099 --hostlist=lists\blocked_russia.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=bin\quic_initial_www_google_com.bin --dpi-desync-fooling=badsum"
    set "service_name=ZapretUltimate_Smart"
    set "service_display=Zapret Ultimate - Smart Auto Service"
    echo [INFO] Режим: Умный автообход (адаптивный)
)

echo.
echo [INFO] Удаление старых служб (если есть)...
sc stop "ZapretDPI" 2>nul
sc stop "ZapretUltimate" 2>nul
sc stop "%service_name%" 2>nul
sc delete "ZapretDPI" 2>nul
sc delete "ZapretUltimate" 2>nul
sc delete "%service_name%" 2>nul

echo [INFO] Создание новой службы...
sc create "%service_name%" binPath= ""%~dp0winws.exe" %service_params%" start= auto DisplayName= "%service_display%" depend= "tcpip"

if %errorlevel% equ 0 (
    echo [SUCCESS] Служба успешно создана: %service_name%

    echo [INFO] Настройка параметров службы...
    sc config "%service_name%" type= own
    sc config "%service_name%" error= normal

    echo [INFO] Запуск службы...
    sc start "%service_name%"

    if %errorlevel% equ 0 (
        echo [SUCCESS] Служба успешно запущена!
        echo.
        echo ================================================
        echo           СЛУЖБА УСПЕШНО УСТАНОВЛЕНА!
        echo ================================================
        echo.
        echo [INFO] Название службы: %service_name%
        echo [INFO] Режим: %service_display%
        echo [INFO] Автозапуск: включен
        echo [INFO] Статус: активна
        echo.
        echo [SUCCESS] Обход блокировок будет работать
        echo автоматически после перезагрузки системы!
        echo.
        echo [TIP] Для мониторинга используйте пункт 17 в главном меню
    ) else (
        echo [WARN] Служба создана, но не запустилась
        echo [TIP] Попробуйте:
        echo - Перезагрузить компьютер
        echo - Проверить наличие winws.exe
        echo - Отключить антивирус временно
    )
) else (
    echo [ERROR] Ошибка создания службы
    echo.
    echo [INFO] Возможные причины:
    echo - Недостаточно прав (попробуйте еще раз)
    echo - Неверный путь к winws.exe (проверьте наличие файла)
    echo - Антивирус блокирует установку
    echo - Служба с таким именем уже существует
    echo.
    echo [TIP] Попробуйте:
    echo 1. Убедиться, что winws.exe находится в папке программы
    echo 2. Временно отключить антивирус
    echo 3. Перезагрузить компьютер и попробовать снова
)

echo.
pause