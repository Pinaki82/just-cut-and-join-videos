@echo off
setlocal enabledelayedexpansion

echo Calculating total video duration...
echo. > durations.txt

for %%i in (*.mp4 *.avi *.mov *.mts *.mkv) do (
    if exist "%%i" (
        ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" 2>>nul >> durations.txt
    )
)

set total=0
for /f "usebackq tokens=*" %%n in ("durations.txt") do (
    set /a total+=%%n
)

set /a hours=!total!/3600
set /a minutes=(!total! %% 3600)/60
set /a seconds=!total! %% 60

echo Total: !hours!:!minutes!:!seconds!
del durations.txt
pause
