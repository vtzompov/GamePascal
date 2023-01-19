@echo off
@TITLE GPAudio
echo Converting video to GPT compatible format....
echo(
ffmpeg.exe -i "%1" -c:v mpeg1video -q:v 11 -b:v 11055k -b:a 384k -maxrate 22110k -bufsize 22110k -c:a mp2 -format mpeg "%2" -loglevel quiet -stats -y
