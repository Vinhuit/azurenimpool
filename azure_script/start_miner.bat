REM
REM Example bat file for starting PhoenixMiner.exe to mine ETH
REM

timeout /t 10
setx GPU_FORCE_64BIT_PTR 0
setx GPU_MAX_HEAP_SIZE 100
setx GPU_USE_SYNC_OBJECTS 1
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_SINGLE_ALLOC_PERCENT 100

REM IMPORTANT: Replace the ETH address with your own ETH wallet address in the -wal option (Rig001 is the name of the rig)
start PhoenixMiner.exe -pool asia1.ethermine.org:4444 -wal 0x3df4995db147FE771d576fbBebDc7c8e0aAA375B.ten-may -logfile mylog.txt -logsmaxsize 50
timeout /t 300
monitor.bat
pause

