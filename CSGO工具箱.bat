::������������
@echo off& pushd %~dp0 & title CSGO ������
mode con cols=50 lines=35
color 0f


::::::::::::::::::::Ȩ������ Start::::::::::::::::::::

cls
echo.
echo          *===========================*
echo          #    ����ԱȨ�������У����� #
echo          *===========================*

:init
setlocal disabledelayedexpansion
set cmdinvoke=1
set winsysfolder=system32
set "batchpath=%~0"
for %%k in ( %0 ) do set batchname=%%~nk
set "vbsgetprivileges=%temp%\oegetpriv_%batchname%.vbs"
setlocal enabledelayedexpansion

:checkprivileges
net file 1>nul 2>nul
if '%errorlevel%' == '0' ( goto gotprivileges ) else ( goto getprivileges )

:getprivileges
if '%1'=='elev' ( echo elev & shift /1 & goto gotprivileges)

echo.
echo       $***********************************$
echo       *     ���ڵ��� UAC ����Ȩ������     *
echo       $***********************************$
echo.
echo  �� ��ѡ�� [��] ͬ����������ù���ԱȨ�ޡ�
echo.

echo set uac = createobject^( "shell.application"^ ) > "%vbsgetprivileges%"
echo args = "elev " >> "%vbsgetprivileges%"
echo for each strarg in wscript.arguments >> "%vbsgetprivileges%"
echo args = args ^& strarg ^& " "  >> "%vbsgetprivileges%"
echo next >> "%vbsgetprivileges%"

if '%cmdinvoke%'=='1' goto invokecmd 

echo uac.shellexecute "!batchpath!", args, "", "runas", 1 >> "%vbsgetprivileges%"
goto execelevation

:invokecmd
echo args = "/c """ + "!batchpath!" + """ " + args >> "%vbsgetprivileges%"
echo uac.shellexecute "%systemroot%\%winsysfolder%\cmd.exe", args, "", "runas", 1 >> "%vbsgetprivileges%"

:execelevation
"%systemroot%\%winsysfolder%\wscript.exe" "%vbsgetprivileges%" %*
exit /b

:gotprivileges
setlocal & cd /d %~dp0
if '%1'=='elev' ( del "%vbsgetprivileges%" 1>nul 2>nul & shift /1)
cls

:::::::::::::::::::::Ȩ������ End::::::::::::::::::::


::::::::::::::::::::CSGO·����� Start::::::::::::::::::::

::�����ӳٻ���������չ
setlocal enabledelayedexpansion

::����csgo��Ϸ����
taskkill /f /im csgo.exe >nul 2>nul

::�Զ����CSGO��Ϸ·��
if exist "%cd%\csgo.exe" ( set "csgopath=%cd%" ) else ( echo �����Զ�ʶ��csgo·�������������� & ping -n 2 127.1 >nul & goto autopath )
goto menu

:autopath
echo wscript.echo CreateObject ( "WScript.Shell" ).RegRead ( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 730\InstallLocation" ) > %temp%\csgopath~.vbs & for /f "delims=" %%a in ( 'cscript //nologo %temp%\csgopath~.vbs' ) do set "csgopath=%%a"

:inputpath
if "%csgopath%"=="" ( 
  echo. & set /p a=�Զ����·��ʧ�ܣ����ƶ��ó���CSGOToolbox�ļ�������Ϸ��Ŀ¼�»��ֶ�������Ϸ·�� [�س�]�� & if "!a!"=="" ( 
    echo. & echo ����Ϊ�գ��밴������������롣 & pause >nul & cls & echo. & goto inputpath 
  ) else ( 
    if exist "!a!\csgo.exe" ( 
      set "csgopath=!a!" & goto menu 
    ) else ( 
      echo. & echo CSGO·����������밴������������롣 & pause >nul & cls & echo. & goto inputpath 
      )
    ) 
) else ( 
  goto menu 
  )

::::::::::::::::::::CSGO·����� End::::::::::::::::::::


::::::::::::::::::::��Ҫ���� Start::::::::::::::::::::

:menu
cls
echo.
echo                ��������������=====��������������
echo                ��   CSGO ������   ��
echo                ��������������=====��������������
echo                    �� �� �� ��
echo         ��������������������������������������������������������������������
echo         ��   1.CSGOԭ֭ԭζ [����г]      ��
echo         ��   2.�л����ʷ����ķ���         ��
echo         ��   3.�л����ʷ�Ӣ������         ��
echo         ��   4.[ �ָ� ��������г�� ]      ��
echo         ��                                ��
echo         ��   5.��װ�����״�               ��
echo         ��   6.[ ж�� �����״� ]          ��
echo         ��                                ��
echo         ��   7.��װ�Զ���CFG �����˵���� ��
echo         ��   8.[ж�� �Զ���CFG]           ��
echo         ��                                ��
echo         ��   9.VAC�����޸�����            ��
echo         ��                                ��
echo         ��   0.�鿴 [˵��+������־]       ��
echo         ��                                ��
echo         ��                  �汾��21.5.5  ��
echo         ��������������������������������������������������������������������
echo.
set /p a=������ѡ�� [�س�]��
echo.
ping -n 2 127.1 >nul
if /i "%a%"=="1" goto original_game
if /i "%a%"=="2" goto original_schinese
if /i "%a%"=="3" goto original_voice
if /i "%a%"=="4" goto recover_perfect_world
if /i "%a%"=="5" goto install_simple_radar
if /i "%a%"=="6" goto uninstall_simple_radar
if /i "%a%"=="7" goto install_CFG
if /i "%a%"=="8" goto uninstall_CFG
if /i "%a%"=="9" goto fix_VAC
if /i "%a%"=="0" goto explain
echo.
echo ������Ч��2������������룡
ping -n 2 127.1 >nul
goto menu

:original_game
if exist "%csgopath%\csgo\bak_perfectworld.txt" ( echo ���� [��г����] �ļ������ڻ�ԭ������������ & ping -n 2 127.1 >nul )
ren "%csgopath%\csgo\pakxv_perfectworld_*.jqy" *.vpk >nul 2>nul
del "%csgopath%\csgo\pakxv_perfectworld_*.jqy" >nul 2>nul
del "%csgopath%\csgo\bak_perfectworld.txt" >nul 2>nul
echo ���ڽ��� [����г]������������
ping -n 2 127.1 >nul
if exist "%csgopath%\csgo\pakxv_perfectworld_*.vpk" ( 
  ( 
    dir "%csgopath%\csgo\pakxv_perfectworld_*.vpk" /b > "%csgopath%\csgo\bak_perfectworld.txt" & for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\bak_perfectworld.txt" ) do ( ren "%csgopath%\csgo\%%a" *.jqy >nul 2>nul ) 
  ) & ( 
    echo ����г������ɣ���������ԭ֭ԭζ�� 
  )
) else ( 
  echo δ��⵽�κκ�г�ļ����� [��֤��Ϸ������] �������
  )
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:original_schinese
if not exist "%csgopath%\csgo\resource\csgo_schinese_pw.txt" ( 
  if not exist "%csgopath%\csgo\resource\csgo_schinese_pw.jqy" ( 
    echo ȱ�������������ı����䱸�ݣ��� [��֤��Ϸ������] ������� 
  ) else ( 
    echo ��ǰΪ���ʷ����ķ��룬�����л��� 
    ) 
) else ( 
  del "%csgopath%\csgo\resource\csgo_schinese_pw.jqy" >nul 2>nul & ren "%csgopath%\csgo\resource\csgo_schinese_pw.txt" csgo_schinese_pw.jqy & echo ���ʷ����ķ����л���ɡ� 
  )
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:original_voice
if exist "%csgopath%\csgo\bak_audiochinese.txt" ( echo ���� [��������] �ļ������ڻ�ԭ������������ & ping -n 2 127.1 >nul )
ren "%csgopath%\csgo\pakxv_audiochinese_*.jqy" *.vpk >nul 2>nul
del "%csgopath%\csgo\pakxv_audiochinese_*.jqy" >nul 2>nul
del "%csgopath%\csgo\bak_audiochinese.txt" >nul 2>nul
echo �����л� [Ӣ������]������������
ping -n 2 127.1>nul
if exist "%csgopath%\csgo\pakxv_audiochinese_*.vpk" ( 
  ( 
    dir "%csgopath%\csgo\pakxv_audiochinese_*.vpk" /b > "%csgopath%\csgo\bak_audiochinese.txt" & for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\bak_audiochinese.txt" ) do ( ren "%csgopath%\csgo\%%a" *.jqy >nul 2>nul ) 
  ) & ( 
    echo Ӣ���������л�����������ԭ��������
  )
) else (
  echo δ��⵽���������ļ����� [��֤��Ϸ������] �������
  )
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:recover_perfect_world
echo ���ڻ�ԭ [��������г��]������������
ping -n 2 127.1 >nul
echo.
if exist "%csgopath%\csgo\bak_perfectworld.txt" ( 
  echo ���ڻָ� [��г]������ & ping -n 2 127.1 >nul 
  ) else ( 
    if exist "%csgopath%\csgo\pakxv_perfectworld_*.vpk" ( 
      echo ��ǰΪ [��г�汾]������ָ��� & ping -n 2 127.1 >nul 
      ) else ( 
        echo δ��⵽��г���ݣ���ͨ�� [��֤��Ϸ������] �ָ��� 
        ) 
        )
ren "%csgopath%\csgo\pakxv_perfectworld_*.jqy" *.vpk >nul 2>nul
del "%csgopath%\csgo\pakxv_perfectworld_*.jqy" >nul 2>nul
del "%csgopath%\csgo\bak_perfectworld.txt" >nul 2>nul
if exist "%csgopath%\csgo\resource\csgo_schinese_pw.jqy" (
  if exist "%csgopath%\csgo\resource\csgo_schinese_pw.txt" (
    echo ��ǰΪ [����������]������ָ���& del "%csgopath%\csgo\resource\csgo_schinese_pw.jqy" >nul 2>nul
  ) else (
      echo ���ڻָ� [����������]������ & ren "%csgopath%\csgo\resource\csgo_schinese_pw.jqy" csgo_schinese_pw.txt
    )
) else ( 
  if exist "%csgopath%\csgo\resource\csgo_schinese_pw.txt" ( 
    echo ��ǰΪ [����������]������ָ���
  ) else ( 
    echo ȱ�������������ı����䱸�ݣ���ͨ��[��֤��Ϸ������]�ָ���
    )
  )

if exist "%csgopath%\csgo\bak_audiochinese.txt" ( 
  echo ���ڻָ� [��������]������ & ping -n 2 127.1 >nul 
  ) else ( 
    if exist "%csgopath%\csgo\pakxv_audiochinese_*.vpk" ( 
      echo ��ǰΪ [��������]������ָ��� & ping -n 2 127.1 >nul 
      ) else ( 
        echo δ��⵽�������ݣ���ͨ�� [��֤��Ϸ������] �ָ��� 
        ) 
        )
ren "%csgopath%\csgo\pakxv_audiochinese_*.jqy" *.vpk >nul 2>nul
del "%csgopath%\csgo\pakxv_audiochinese_*.jqy" >nul 2>nul
del "%csgopath%\csgo\bak_audiochinese.txt" >nul 2>nul
echo.
echo �ѻָ���������г�棬��������ͺ�г��Ϸ��
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:install_simple_radar
::����Ƿ���CSGOToolbox
if not exist "%cd%\CSGOToolbox" echo ���뽫CSGOToolbox�ļ����ƶ����뱾����ͬһĿ¼ & echo. & echo ��������˳������� & pause >nul & goto exit

if exist "%csgopath%\csgo\resource\overviews\simple_radar.txt" (
  ( 
    echo ��⵽�ɰ�����״׼������ж�ء����������� & ping -n 2 127.1 >nul & echo ���� [ж��] �ɰ�����״���������� & ping -n 2 127.1 >nul 
  ) & (
    for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\resource\overviews\simple_radar.txt" ) do ( del "%csgopath%\csgo\resource\overviews\%%a" >nul 2>nul )
  ) & ( 
    del "%csgopath%\csgo\resource\overviews\simple_radar.txt" >nul 2>nul & ren "%csgopath%\csgo\resource\overviews\*.jqy" *.dds >nul 2>nul 
    )
)
echo ���� [��װ] �����״����������
ping -n 2 127.1 >nul
dir "%cd%\CSGOToolbox\simple radar\*.dds" /b > "%csgopath%\csgo\resource\overviews\simple_radar.txt"
for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\resource\overviews\simple_radar.txt" ) do ( ren "%csgopath%\csgo\resource\overviews\%%a" *.jqy >nul 2>nul & xcopy "%cd%\CSGOToolbox\simple radar\%%a" "%csgopath%\csgo\resource\overviews"  /s /e /y >nul 2>nul )
echo �����״ﰲװ��ɡ�
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:uninstall_simple_radar
if exist "%csgopath%\csgo\resource\overviews\simple_radar.txt" (
  ( 
    echo ���� [ж��] �����״���������� & ping -n 2 127.1 >nul
  ) & (
    for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\resource\overviews\simple_radar.txt" ) do ( del "%csgopath%\csgo\resource\overviews\%%a" >nul 2>nul )
  ) & ( 
    del "%csgopath%\csgo\resource\overviews\simple_radar.txt" >nul 2>nul & ren "%csgopath%\csgo\resource\overviews\*.jqy" *.dds >nul 2>nul & echo �����״�ж����ɡ� 
    )
) else (
  ping -n 2 127.1 >nul & echo δ��⵽�����״��޷�ж�ء� 
  )
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:install_CFG
::����Ƿ���CSGOToolbox
if not exist "%cd%\CSGOToolbox" echo ���뽫CSGOToolbox�ļ����ƶ����뱾����ͬһĿ¼ & echo. & echo ��������˳������� & pause >nul & goto exit

if exist "%csgopath%\csgo\cfg\extra_cfg.txt" (
  ( 
    echo ��⵽�ɰ��Զ���CFG��׼������ж�ء����������� & ping -n 2 127.1 >nul & echo ���� [ж��] �ɰ��Զ���CFG������������ & ping -n 2 127.1 >nul
  ) & ( 
    for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\cfg\extra_cfg.txt" ) do ( del "%csgopath%\csgo\cfg\%%a" >nul 2>nul )
  ) & ( 
    del "%csgopath%\csgo\cfg\extra_cfg.txt" >nul 2>nul 
    )
)
echo ���� [��װ] �Զ���CFG������������
ping -n 2 127.1 >nul
dir "%cd%\CSGOToolbox\cfg\*.cfg" /b >"%csgopath%\csgo\cfg\extra_cfg.txt"
for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\cfg\extra_cfg.txt" ) do ( xcopy "%cd%\CSGOToolbox\cfg\%%a" "%csgopath%\csgo\cfg"  /s /e /y >nul 2>nul )
echo �Զ���CFG��װ��ɡ�
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:uninstall_CFG
if exist "%csgopath%\csgo\cfg\extra_cfg.txt" (
  ( 
    echo ���� [ж��] �Զ���CFG������������ & ping -n 2 127.1 >nul
  ) & ( 
    for /f "usebackq delims=" %%a in ( "%csgopath%\csgo\cfg\extra_cfg.txt" ) do ( del "%csgopath%\csgo\cfg\%%a" >nul 2>nul )
  ) & ( 
    del "%csgopath%\csgo\cfg\extra_cfg.txt" >nul 2>nul & echo �Զ���CFGж����ɡ�
    )
) else (
  ping -n 2 127.1 >nul & echo δ��⵽�Զ���CFG�޷�ж�ء� 
  )
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:fix_VAC
if not exist "%cd%\CSGOToolbox\VAC�����޸����߹���ԱȨ������.bat" ( echo δ��⵽ VAC�����޸����߹���ԱȨ������.bat�� & echo �ļ������ѱ��ƶ��������������뻹ԭ�����ԡ� & echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu )
echo �������� [VAC�����޸�����]
ping -n 2 127.1 >nul
start "VAC�����޸�����" "%cd%\CSGOToolbox\VAC�����޸����߹���ԱȨ������.bat"
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

:explain
echo ���ڴ򿪹�����˵��
ping -n 2 127.1 >nul
start "������˵��" "%cd%\������˵��.txt"
echo. & echo ����������ز˵����˳�ֱ�ӹرա�& pause >nul & cls & goto menu

::::::::::::::::::::��Ҫ���� End::::::::::::::::::::

:exit
pause
exit