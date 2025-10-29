:: #########################################################################
:: # SCRIPT: Video Processing Script - MXF Intermediate Method
:: # AUTHOR: DeepSeek (https://chat.deepseek.com/)
:: # CREATED: 2025-Oct-28
:: # MODIFIED: 2025-Oct-29
:: #
:: # INTENDED GOAL:
:: # 1. Process all video files in the current directory
:: # 2. Convert to MXF intermediate for frame-accurate editing
:: # 3. Trim 5 frames from the start and 13 frames from the end of each clip
:: # 4. De-interlace footage (** manually remove yadif filter for DSLR/Mirrorless)
:: # 5. Convert to X.264 MP4 format using FFMPEG
:: # 6. Combine all processed videos into the final output
:: # 7. Save the final video one directory level up
:: #
:: # USAGE:
:: # 1. Place the script in a folder with video files
:: # 2. Ensure FFmpeg is installed and in the system PATH
:: # 3. Double-click the script or run it from the command prompt
:: # 4. Final output: ../final_output.mp4
:: # 5. Rename the generated output.
:: #
:: # NOTES:
:: # - For 25fps footage: 5 frames = 0.2s, 13 frames = 0.52s (Calculation: 5 * 1/25 and 13 * 1/25)
:: # - For 30fps (NTSC): 5 frames = 0.167s, 13 frames = 0.433s (Calculation: 5 * 1/30 and 13 * 1/30)
:: # - Remove yadif filter for progressive footage (DSLR/Mirrorless/GoPro/Drone)
:: # - Adjust CRF value (18-28) for quality/size balance
:: #########################################################################

@echo off
setlocal enabledelayedexpansion

echo Video Processing Script - MXF Intermediate Method
echo ===============================================

where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: FFmpeg not found in PATH.
    pause
    exit /b 1
)

if not exist "temp_mxf" mkdir "temp_mxf"
if not exist "temp_processed" mkdir "temp_processed"
set count=0

echo Step 1: Processing files with MXF intermediate...
for /f "tokens=*" %%i in ('dir /b /on *.mts *.mp4 *.avi *.mov *.mkv') do (
    if exist "%%i" (
        set /a count+=1
        echo Processing "%%i" (!count! of ?)
        
        :: Step 1A: Convert to MXF (frame-accurate intermediate). NOTE: Remove the line containing the YADIFF deinterlace filter `-vf "yadif=0:-1:0" ^` for DSLR/Mirrorless videos.
        echo   Converting to MXF...
        ffmpeg -i "%%i" ^
            -vf "yadif=0:-1:0" ^
            -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p ^
            -c:a pcm_s16le ^
            -y "temp_mxf\!count!_%%~ni.mxf"
        
        :: Step 1B: Get duration of MXF file
        for /f "tokens=*" %%d in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "temp_mxf\!count!_%%~ni.mxf" 2^>nul') do set duration=%%d

        :: Step 1C: Calculate end time (duration - 13 frames = duration - 0.52s at 25fps) (calculated as: 13 * 1/25 = 0.52. For NTSC: 13 * 1/30 = 0.433). NOTE: You can adjust the trimming zone by changing the start and end frames. The formula is available.
        set /a "end_time_seconds=!duration:.*=! - 1"
        set "end_time=!end_time_seconds!.48"

        :: Step 1D: Trim MXF and convert to final MP4 (5 frames from start, 13 from end) (start frame is 5, meaning, 5 * 1/25 = 0.25. For NTSC: 5 * 1/30 = 0.167).
        echo   Trimming and converting to MP4...
        ffmpeg -i "temp_mxf\!count!_%%~ni.mxf" ^
            -ss 0.2 -to !end_time! ^
            -c:v libx264 -crf 23 -preset medium ^
            -c:a aac -b:a 192k ^
            -y "temp_processed\!count!_%%~ni.mp4"
        
        :: Clean up MXF file immediately to save space
        del "temp_mxf\!count!_%%~ni.mxf" 2>nul
    )
)

if %count% equ 0 (
    echo No video files found in the current directory.
    rmdir "temp_mxf" 2>nul
    rmdir "temp_processed" 2>nul
    pause
    exit /b 1
)

echo.
echo Step 2: Combining processed files...

:: Check if any files were successfully processed
dir /b "temp_processed\*.mp4" >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: No processed files found. Check FFmpeg errors above.
    pause
    exit /b 1
)

:: Create file list for concatenation in proper order
cd temp_processed
(for /f "tokens=*" %%f in ('dir /b /on *.mp4') do @echo file '%%f') > filelist.txt
cd ..

:: Combine all processed videos
ffmpeg -f concat -safe 0 -i "temp_processed\filelist.txt" -c copy "..\final_output.mp4" -y

:: Cleanup
del "temp_processed\filelist.txt" 2>nul
rmdir /s /q "temp_mxf" 2>nul
rmdir /s /q "temp_processed" 2>nul

echo.
if exist "..\final_output.mp4" (
    echo Done! Final video saved as: ..\final_output.mp4
) else (
    echo Error: Final video was not created successfully.
)
echo.
pause

