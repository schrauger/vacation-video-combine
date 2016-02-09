#!/usr/bin/env bash -e

# 1. Concat the already-converted videos
# 1a. Build up a list before concating, so that if any files get added later, the chapter markers
#     don't get messed up.
# 2. Create chapter markers by counting the frames for each video
# 3. Add chapter markers to the concated video.

# 2.
find DIR -iname "*.EXT" -type f -exec sh -c "ffprobe -show_packets {} 2>/dev/null | grep video | wc -l" >> frame.txt.temp \; -exec echo "file '{}'" >> concat.txt.temp \;

# In future versions, I may also make automatic day chapter markers. So for multi-day vacation
# videos, you could skip to the next day. Probably using 2 or 3am as the split time, rather
# than midnight, since many times things go late into the night. But by 3am, it's very unlikely
# to be recording video.

# It may also be nice to do some smart processing based on subfolders. If the user already
# organized by day, and even by sub-day events, those could be major and minor chapter
# markers (assuming videos can have different levels of chapter markers).