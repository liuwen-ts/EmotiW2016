#!/bin/bash

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -lt $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0`"
  exit $E_BADARGS
fi

#if [ ! -d "data"]; then
#  mkdir -m 755 "data"
#fi

# -m给这个目录加权限，755是默认权限
mkdir -m 755 "../data/audio_ori_wav"
cd "../data/audio_ori_wav"
# $1 接收第一个参数，%.*：从最右边往左一直删到"."(去掉后缀)
NAME=${1%.*}
# basename 是去掉路径，只保留最后的文件名
BNAME=`basename $NAME`
# find在NAME目录中查找普通类型（- type f）的后缀是avi（- name 指定文件名）的文件
for video in `find $NAME -type f -name '*.avi'`
do
	echo $video
	# cut用来从标准输入或文本文件中剪切列或域。-f field  指定剪切域数。-d  指定与空格和tab键不同的域分隔符。下面的命令指定域为"/"，-f表示第七个域
        VNAME=`echo $video | cut -d "/" -f7`
        #if [ ! -d "$D1NAME"]; then
        D2NAME=`echo $VNAME | cut -d "." -f1`
        echo $D2NAME
	# eg1.ffmpeg -i input-video.avi -vn -acodec copy output-audio.aac 
	# vn is no video.acodec copy says use the same audio stream that's already in there.
	# eg2.ffmpeg -i video.mp4 -f mp3 -ab 192000 -vn music.mp3
	# The -i option in the above command is simple: it is the path to the input file. The second option -f mp3 tells ffmpeg that the ouput is in mp3 format. 
	# The third option i.e -ab 192000 tells ffmpeg that we want the output to be encoded at 192Kbps and -vn tells ffmpeg that we dont want video. The last 
	# param is the name of the output file.#
	# shell字符串拼接只需将两个字符串放在一起
        ffmpeg -i $video -vn -acodec copy $D2NAME.wav
done
