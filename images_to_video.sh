#!/bin/sh

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <image_folder> <output_folder>"
  exit 1
fi

image_folder=$1
output_folder=$2

# Check if the input and output folders exist
if [ ! -d "$image_folder" ]; then
  echo "Error: Image folder does not exist."
  exit 1
fi

if [ ! -d "$output_folder" ]; then
  echo "Error: Output folder does not exist."
  exit 1
fi

# Check if FFmpeg is installed, and install it if not
command -v ffmpeg >/dev/null 2>&1 || {
  echo "FFmpeg not found. Installing FFmpeg..."
  sudo apt-get update
  sudo apt-get install -y ffmpeg
}

# Convert images to video
ffmpeg -framerate 30 -pattern_type glob -i "${image_folder}/*.png" -c:v libx264 -r 30 -pix_fmt yuv420p "${output_folder}/output2.mp4"

echo "Video created in ${output_folder}/output2.mp4"
