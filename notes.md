ffmpeg -f concat -i mylist.txt -c copy "Videos Combined.MTS"

where mylist.txt contains the list of videos.

```
file '00099.MTS'
file '00100.MTS'
file '00101.MTS'
```

find "`pwd`" -maxdepth 1 -type f -iname "*.MTS" | sed "s/^/file '/g" | sed "s/$/'/g" > mylist.txt

Full command
find "`pwd`" -maxdepth 1 -type f -iname "*.MTS" | sed "s/^/file '/g" | sed "s/$/'/g" > mylist.txt && ffmpeg -f concat -i mylist.txt -c copy "Videos Combined.MTS" && rm mylist.txt

## Chapter marker stuff
This works on mp4 files to get the total number of frames.
Use this later in the script when creating the chapter marker
info to calculate where the chapter marker goes.

It lists the video 'packets', and that gets counted by `wc` to give us the frame count.

`ffprobe -show_packets 00100.MTS 2>/dev/null | grep video | wc -l`

For avi and other videos, use the nb_frames parameter to get frames. I don't keep videos in this format, so I won't devote much time to making the script work with other formats.

`ffprobe -select_streams v -show_streams 00099.MTS 2>/dev/null | grep nb_frames`

