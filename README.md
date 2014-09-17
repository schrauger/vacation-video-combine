##vacation-video-combine

Combines (concats) short clips made with a camcorder and combines them into one seamless video.

When recording video clips on vacation or other events, I tend to record short (<10 second) clips. When played back, there is a notable pause between clips, as the computer has to load the next one and does not do so seamlessly. Gapless playback only exists on certain audio players, and I haven't found a single video player that does gapless playback.

After converting all of my videos into h.264 codec inside a MKV container, I run this script to combine the videos from each event into one long video.

I'd like this script to add chapter markers for each clip in the future, but that isn't part of the script currently.

## Dependencies
Requires a new version of ffmpeg, version 1.1 or later. Due to politics, ffmpeg was replaced by avconv in debian/ubuntu repositories, and avconv does not have the concat demuxer needed by this script. You should really remove avconv and reinstall ffmpeg, as it has added many features, and it also pulls in fixes from the avconv project.
