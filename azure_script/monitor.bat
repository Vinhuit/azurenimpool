@ECHO off
set /p name="Enter Name: "
:loop
set "x = 0"
set endl="--------"
findstr /r "[0-9]W" mylog.txt >gpu.txt
set /p gpu=<gpu.txt
For /F "UseBackQ Delims==" %%A In ("gpu.txt") Do Set "lastline=%%A"
Echo %lastline%

findstr /r " Effective" mylog.txt>hashrate.txt
set /p hashrate=<hashrate.txt
For /F "UseBackQ Delims==" %%A In ("hashrate.txt") Do Set "lastline2=%%A"
Echo %lastline2%
powershell.exe -command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (new-object net.webclient).DownloadString('https://api.telegram.org/bot1627764338:AAG4f3OrpP21UQaF7DircoDUhi2Gy0-aHDE/sendMessage?parse_mode=markdown&disable_notification=%~2&chat_id=-1001277940480&text=*%name%:* %lastline%%endl%%lastline2%')"
timeout /t 3600
goto loop
