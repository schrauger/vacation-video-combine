#!/bin/bash -e

#This converts the panasonic camcorder video files into mkv files with an x264 format.
# If you wish to combine the videos later into one continuous file, see the ‘merge mkv’ doc for instructions.

file_ext="MTS"; # default is MTS files, the files created by panasonic camcorders
file_save_ext="mkv";
while getopts ":e:s:" optname
  do
    case "$optname" in
      "e")
    # change the file extension to look for
        file_ext=${OPTARG}
	echo "Searching for $file_ext files"
        ;;
      "s")
    # change the output file extension
        file_save_ext=${OPTARG}
	echo "Saving as $file_save_ext files"
        ;;
      "?")
        echo "Unknown option $OPTARG"
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        ;;
    esac
  done
shift $((OPTIND-1))

input_folder=$1
#output_folder=$2
#if [ "$output_folder" = "" ]
#then
#    output_folder=$input_folder
#fi

IFS=$(echo -en "\n\b")
cmd=$(find "$input_folder" -name "*.$file_ext")

for input_file_path in $(find "$input_folder/" -name "*.$file_ext" | sort); do

    output_folder=$(dirname "$input_file_path")
    input_file=$(basename "$input_file_path")

    input_file="${input_file%.$file_ext}"
    output_file="$output_folder"/"$input_file"."$file_save_ext"
    if [ -f "$output_file.incomplete" ]; then
        # detected partial video. delete and restart.
        rm -f "$output_file" "$output_file.incomplete";
    fi
    if [ ! -f "$output_file" ]; then
        # skip completed conversions. only convert if no converted video exists.
        touch "$output_file.incomplete"; # if script gets killed, the partial video conversion must be restarted.
        echo "OUTPUT GOES HERE *********** $output_file"
        HandBrakeCLI --verbose 0 -i "$input_file_path" -o "$output_file" -e x264 -q 20.0 -a 1,1 -E faac,copy:ac3 -B 160,160 -6 dpl2,auto -R Auto,Auto -D 0.0,0.0 -f "$file_save_ext" --detelecine --decomb --width 1920 --height 1080 --strict-anamorphic -m -x rc-lookahead=10:me=umh:direct=auto:b-adapt=2:bframes=5:subme=9 --crop 0:0:0:0

        test $? -gt 128 && exit #test for a break. basically, this lets the user manually stop the entire script. (Normally, a ctrl+c would only break the current command in the loop, and it would simply continue on with the next command. This way, the entire convert batch script ends).

        # now that the file is converted, copy over the timestamp. we want to preserve the original meta-data as much as possible.
        touch -r "$input_file_path" "$output_file"
        rm "$output_file.incomplete";
    fi
done
