ffmpeg -f concat -i mylist.txt -c copy "Videos Combined.MTS"

where mylist.txt contains the list of videos.

```
file '00099.MTS'
file '00100.MTS'
file '00101.MTS'
```

After finding, sort by filename (should cause it to be in order of date),
and replace any single quotes ("'") with escaped ("'\''") for ffmpeg to process.
Then surround it with quotes and prepend 'file'.

find "`pwd`" -maxdepth 1 -type f -iname "*.MTS" ! -iname "*Combined*" -printf "%f ;;; %p\n" | sort | sed "s/.*;;; //g" | sed "s/'/'\\\''/g" | sed "s/^/file '/g" | sed "s/$/'/g" > mylist.txt


Full command

find "`pwd`" -maxdepth 1 -type f -iname "*.MTS" ! -iname "*Combined*" -printf "%f ;;; %p\n" | sort | sed "s/.*;;; //g" | sed "s/'/'\\\''/g" | sed "s/^/file '/g" | sed "s/$/'/g" > mylist.txt && ffmpeg -f concat -i mylist.txt -c copy "../Videos Combined.MTS" && rm mylist.txt

If you want to do recursive, change maxdepth to something greater than 1. You may want to tweak it to remove any subfolders with "mistake" clips.


## Chapter marker stuff
This works on mp4 files to get the total number of frames.
Use this later in the script when creating the chapter marker
info to calculate where the chapter marker goes.

It lists the video 'packets', and that gets counted by `wc` to give us the frame count.

`ffprobe -show_packets 00100.MTS 2>/dev/null | grep video | wc -l`

For avi and other videos, use the nb_frames parameter to get frames. I don't keep videos in this format, so I won't devote much time to making the script work with other formats.

`ffprobe -select_streams v -show_streams 00099.MTS 2>/dev/null | grep nb_frames`

