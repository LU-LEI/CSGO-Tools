@echo off & title VAC�����޸�����
mode con cols=90 lines=18
color a
echo.
echo.
echo                                    ����������������������������������������
echo                                    ��  VAC�����޸����� ��
echo                                    ����������������������������������������
echo. 
echo. 
echo                               �������ϵ��������ʼִ���޸���
echo.
echo.
pause>nul
goto steam

:steam
echo ���ڼ��Steam�Ƿ���......
tasklist | find /I "Steam.exe"
if errorlevel 1 goto steamchina
if not errorlevel 1 goto start

:steamchina
echo ���ڼ������������Ƿ���......
tasklist | find /I "steamchina.exe"
if errorlevel 1 goto stop
if not errorlevel 1 goto start

:stop
echo Steam�͹�����������δ����
goto start

:killsteam
echo Steam�ѿ���
echo ����ǿ�ƹر�
taskkill /F /IM Steam.exe
echo ��ǿ�ƹر�
goto start

:killsteamchina
echo Steam�ѿ���
echo ����ǿ�ƹر�
taskkill /F /IM steamchina.exe
echo ��ǿ�ƹر�
goto start

:start
echo ��ʼ���VAC����

echo ���� Network Connections
sc config Netman start= AUTO
sc start Netman

echo ���� Remote Access Connection Manager
sc config RasMan start= AUTO
sc start RasMan

echo ���� Telephony
sc config TapiSrv start= AUTO
sc start TapiSrv

echo ���� Windows Firewall
sc config MpsSvc start= AUTO
sc start MpsSvc
netsh advfirewall set allprofiles state on

echo �ָ� Data Execution Prevention ��������ΪĬ��ֵ
bcdedit /deletevalue nointegritychecks
bcdedit /deletevalue loadoptions
bcdedit /debug off
bcdedit /deletevalue nx

echo ���ڻ�ȡ���Steam�����������Ŀ¼
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\SOFTWARE\Valve\Steam" ^| find /i "SteamPath"') do set "SteamPath=%%k" 
if "%SteamPath%" NEQ "0x1" (goto Auto) else (goto Manual)

:Auto
echo Steam�����������Ŀ¼Ϊ%SteamPath% 

echo ��ʼ��װSteam Services
cd /d "%SteamPath%\bin"
steamservice  /install
ping -n 3 127.0.0.1>nul
echo ��ʼ�޸�Steam Services
steamservice  /repair
ping -n 3 127.0.0.1>nul
echo .
echo �޸�Steam Services���
echo ����"Steam client service installation complete"�����κ�"Fail"����
echo (��"Add firewall exception failed for steamservice.exe"����)�ſ��Խ�����
echo �����������ķ���ǽ����(�رա����������⡱ѡ��)

echo ����Steam Services����
sc config "Steam Client Service" start= AUTO
sc start "Steam Client Service"

title ���!
echo                              ��ϣ���������������ڣ�
echo                              PS��һ��ֻ�ܻ�ȡSteam�������������Ŀ¼
echo                              ����ǰ����һ�����������������
echo                              ��ݷ�ʽδ�Թ�����������������
echo                              �����н�Steam.exe�޸�Ϊsteamchina.exe
exit
