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

# Convert images to GIF at 30 FPS
ffmpeg -framerate 30 -pattern_type glob -i "${image_folder}/*.png" -vf "scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "${output_folder}/output.gif"

echo "GIF created in ${output_folder}/output.gif"
