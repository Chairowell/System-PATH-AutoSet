@echo off
color 06

::����Ŀ��
set object=ffmpeg.exe
::���ݻ�������
echo %path% >.\Path-backup.txt
echo =================== %object% ���������Զ���װ�ű� ===================
echo ��Ŀ���ļ����������˻��������ļ�Path-backup.txt���������������ó������ֶ��ָ�
echo ===============================================================
echo �������ýű���Ҫ��������explorer.exe �벻Ҫ������ʱʹ�ã��Ա��ⲻ��Ҫ����ʧ ������
echo �����������ñ�����ʹ�ã����ű����ṩѧϰ��ϵͳ�𻵸Ų����� ������
echo �ű���������������������Ч���ֶ�������������ȷ�ϸ��»��������������߿��Ը��Ľű�60-65�д���

::��ȡĿ���ļ���λ�ú͵�ǰ��������
set myPath=%path%
set curPath=%cd%
set digPath=%curPath%



::�жϵ�ǰĿ¼�Ƿ��ڻ���������
echo %path% | find /i "%digPath%">nul && goto A || goto B

:A
echo ===============================================================
echo ��ǰ%digPath%·�������뻷���������������������س����Լ��
pause
echo ===============================================================
%object%
pause
exit


:B
echo ===============================================================
echo ��ǰ���������� %digPath% ���Խ�����ӣ��س��Լ���
pause
::���ffmpeg.exe�Ƿ�������ļ�����
if exist ".\%object%" (goto C) else (goto D)

:C
echo ===============================================================
echo %object% Ŀ������� %cd%
echo ��ȷ����%object% ���뻷�����������롾y�� (Сд) ͬ�⣬���س������˳���
set /p a=
echo ===============================================================
if %a% equ y (goto E) else (exit)

:D
echo ===============================================================
echo %object% ���ڴ��ļ����У��뽫�ű�����Ŀ���ļ��У�����
pause
exit

:E
::setx -->�û����� setx /m --->ϵͳ���� wmic where --->ԭ�����ϸ��� wmic create --->�����±��� %computername%\%username% --->�û����� <system> --->ϵͳ���� 
::ָ����޷�ֱ����Ч�������������ֶ�����������Ȼ����£�BUG��Ĭ��ʹ�õڶ�����ֱ�ӳɹ��ʱȽϸ�
::���ʹ��setx�����ע��78��79�д��룬���ʹ��wmic�������78��79��ע��ȥ��
::setx "Path" "%myPath%;%digPath%"
setx "Path" "%myPath%;%digPath%" /m
::wmic ENVIRONMENT where "name='Path' and username='%computername%\\%username%'" set VariableValue="%myPath%;%digPath%"
::wmic ENVIRONMENT create name="Path",username="%computername%\%username%",VariableValue="%myPath%;%digPath%"
::wmic ENVIRONMENT where "name='Path' and username='<system>'" set VariableValue="%myPath%;%digPath%"
::wmic ENVIRONMENT create name="Path",username="<system>",VariableValue="%myPath%;%digPath%"

::����explorer.exe
echo ===============================================================
echo ��ʼ�������� explorer.exe ��ˢ�»��������������������������롾�س������Ա��ⲻ��Ҫ����ʧ�����롾y�� (Сд) �Լ�����
set /p b=
echo ===============================================================
if %b% equ y (goto F) else (exit)

:F
echo �����������뵥���ű������Լ�����
pause

::taskkill /im explorer.exe /f
::start explorer.exe
%object%
start "��⻷�������Ƿ���Ч" cmd /k "Path-AutoSet.bat"
