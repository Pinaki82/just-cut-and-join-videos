#!/bin/bash

# Requirements: bc and FFMPEG
# Bing Search:
# The 'bc' command is typically pre-installed on most Linux distributions.
# However, if it’s not, you can install it on Debian-based distributions like
# Ubuntu with the command sudo apt-get install bc.
# For RPM-based distributions like CentOS, use the command sudo yum install bc.

###########################################################################
# SCRIPT: Video Processing Script - MXF Intermediate Method
# AUTHOR: DeepSeek (https://chat.deepseek.com/) (* Feedback provided by Pinaki Sekhar Gupta.)
# CREATED: 2025-Oct-28
# MODIFIED: 2025-Oct-29
#
# INTENDED GOAL:
# 1. Process all video files in the current directory
# 2. Convert to MXF intermediate for frame-accurate editing
# 3. Trim 5 frames from the start and 13 frames from the end of each clip
# 4. De-interlace footage (** manually remove yadif filter for DSLR/Mirrorless)
# 5. Convert to H.264 MP4 format
# 6. Combine all processed videos into the final output
# 7. Save the final video one directory level up
#
# USAGE:
# 1. Save as process_videos.sh and make executable: chmod +x process_videos.sh
# 2. Place in a folder with video files
# 3. Ensure FFmpeg is installed: sudo apt install ffmpeg
# 4. Run: ./process_videos.sh
# 5. Final output: ../final_output.mp4
#
# NOTES:
# - For 25fps footage: 5 frames = 0.2s, 13 frames = 0.52s (Calculation: 5 * 1/25 and 13 * 1/25)
# - For 30fps (NTSC): 5 frames = 0.167s, 13 frames = 0.433s (Calculation: 5 * 1/30 and 13 * 1/30)
# - Remove yadif filter for progressive footage (DSLR/Mirrorless/GoPro/Drone)
# - Adjust CRF value (18-28) for quality/size balance
# - Install bc for precise calculations: Debian: sudo apt install bc
###########################################################################

# TECHNICAL NOTES:
# - MXF with DNxHR HQ provides frame-accurate editing without GOP issues
# - Temporary MXF files are deleted immediately to save disk space
# - Files are processed in numerical order (ls -1v sorting)
# - H.264 CRF 23 provides good quality with a reasonable file size
# - Audio is converted to AAC 192kbps for compatibility
# - De-interlacing uses yadif (yet another de-interlacing filter)
# - Requires bc package for precise floating-point calculations

echo "Video Processing Script - MXF Intermediate Method"
echo "==============================================="

# Check if ffmpeg is available
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: FFmpeg not found. Please install FFmpeg first."
    exit 1
fi

# Check if bc is available for floating point math
if ! command -v bc &> /dev/null; then
    echo "Note: 'bc' not found. Using alternative calculation method."
    USE_BC=false
else
    USE_BC=true
fi

# Create temporary directories
mkdir -p temp_mxf temp_processed
count=0

echo "Step 1: Processing files with MXF intermediate..."

# Check if any video files exist first
shopt -s nullglob
video_files=(*.mts *.MTS *.mp4 *.MP4 *.avi *.AVI *.mov *.MOV *.mkv *.MKV)
shopt -u nullglob

if [ ${#video_files[@]} -eq 0 ]; then
    echo "No video files found in the current directory."
    echo "Supported formats: MTS, MP4, AVI, MOV, MKV"
    rmdir temp_mxf temp_processed 2>/dev/null
    exit 1
fi

echo "Found ${#video_files[@]} video file(s) to process."
echo ""

# Process files in numerical order
for file in "${video_files[@]}"; do
    if [ -f "$file" ]; then
        ((count++))
        filename=$(basename "$file")
        echo "Processing \"$file\" ($count of ${#video_files[@]})"

        # Step 1A: Convert to MXF (frame-accurate intermediate).  NOTE: Remove the line containing the YADIFF deinterlace filter `-vf "yadif=0:-1:0" \` for DSLR/Mirrorless videos.
        echo "  Converting to MXF..."
        ffmpeg -i "$file" \
            -vf "yadif=0:-1:0" \
            -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p \
            -c:a pcm_s16le \
            -y "temp_mxf/${count}_${filename%.*}.mxf"

        # Step 1B: Get duration of MXF file
        duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "temp_mxf/${count}_${filename%.*}.mxf" 2>/dev/null)

        if [ -z "$duration" ]; then
            echo "  Warning: Could not get duration for $file, using default trimming"
            end_time="10.0"  # default value
        else
            # Step 1C: Calculate end time (duration - 13 frames = duration - 0.52s at 25fps) (calculated as: 13 * 1/25 = 0.52. For NTSC: 13 * 1/30 = 0.433). NOTE: You can adjust the trimming zone by changing the start and end frames. The formula is available.
            if [ "$USE_BC" = true ]; then
                end_time=$(echo "$duration - 0.52" | bc)
            else
                # Alternative calculation using awk if bc is not available
                end_time=$(echo "$duration" | awk '{printf "%.2f", $1 - 0.52}')
            fi
        fi

        echo "  Duration: ${duration}s, End time: ${end_time}s"

        # Step 1D: Trim MXF and convert to final MP4 (5 frames from start, 13 from end) (start frame is 5, meaning, 5 * 1/25 = 0.25. For NTSC: 5 * 1/30 = 0.167).
        echo "  Trimming and converting to MP4..."
        ffmpeg -i "temp_mxf/${count}_${filename%.*}.mxf" \
            -ss 0.2 -to "$end_time" \
            -c:v libx264 -crf 23 -preset medium \
            -c:a aac -b:a 192k \
            -y "temp_processed/${count}_${filename%.*}.mp4"

        # Clean up MXF file immediately to save space
        rm -f "temp_mxf/${count}_${filename%.*}.mxf"

        echo "  Completed $file"
        echo ""
    fi
done

if [ $count -eq 0 ]; then
    echo "No video files were successfully processed."
    rmdir temp_mxf temp_processed 2>/dev/null
    exit 1
fi

echo "Step 2: Combining processed files..."

# Check if any files were successfully processed
if [ -z "$(ls -A temp_processed/*.mp4 2>/dev/null)" ]; then
    echo "Error: No processed files found. Check FFmpeg errors above."
    exit 1
fi

# Create file list for concatenation in proper order
cd temp_processed
for f in $(ls -1v *.mp4); do
    echo "file '$f'" >> filelist.txt
done
cd ..

# Combine all processed videos
echo "Combining $count video files..."
ffmpeg -f concat -safe 0 -i "temp_processed/filelist.txt" -c copy "../final_output.mp4" -y

# Cleanup
rm -f "temp_processed/filelist.txt"
rm -rf temp_mxf temp_processed

echo ""
if [ -f "../final_output.mp4" ]; then
    echo "Done! Final video saved as: ../final_output.mp4"
    echo "Total files processed: $count"
else
    echo "Error: Final video was not created successfully."
fi
echo ""
