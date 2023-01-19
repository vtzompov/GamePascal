@echo off
@TITLE GPVideo
echo Converting audio to GPT compatible format....
echo(
ffmpeg.exe -i "%s" -ar 48000 -vn -c:a libvorbis -b:a 64k "%s" -loglevel quiet -stats -y