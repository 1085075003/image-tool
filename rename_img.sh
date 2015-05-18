#!/bin/bash

OUTPUT_PATH="/Users/tommy/Documents/spritesheet"
function createPlist(){
    for file in ` ls $1 `
    do
            if [ -d $1"/"$file ]
            then
                    createPlist $1"/"$file
            elif [ "${file##*.}" = "png" ]
			then
                TexturePacker $1 --sheet $OUTPUT_PATH"/"${1##*/}".png" --data $OUTPUT_PATH"/"${1##*/}".plist" --trim --opt RGBA4444 --size-constraints AnySize --dither-fs-alpha --border-padding 0 --disable-rotation
                echo createPlist" "$1
                break
            fi
    done
}

function compression(){
    for file in ` ls $1 `
    do
            if [ -d $1"/"$file ]
            then
                    compression $1"/"$file
            elif [ "${file##*.}" = "png" ]
			then
				cd /Users/tommy/Documents/ImageProcessing/pngquant
				./pngquant --ext .png --force $1"/"$file
				echo "compression "$1"/"$file
            fi
    done
}

NEW_RESOURCE_PATH="/Users/tommy/Documents/resource_new/release_skill/"
function rename_img()
{
	index=0
	for file in `ls $1`
	do
		current_file=$2
		if [ -d $1"/"$file ]
		then
			#echo $file
			current_file=$current_file"/"$file
			rename_img $1"/"$file $current_file
		elif [ "${file##*.}" == "png" ]
		then
			# 增加index
			index=`expr $index + 1`

			# 连接文件名
			path=$current_file"/"$index".png"

			# 将中文替换掉
			path=${path//待机/stand2}
			path=${path//跑步/run}
			path=${path//普击/attack}
			path=${path//受击/hurt}
			path=${path//死飞/dead2}
			path=${path//死亡/dead}
			path=${path//战待/stand}

			# /替换成_
			path=${path//\//_}

			# 删除第一个_
			path=${path#*_}

			# 取得第一个目录名称
			newFile=${path:0:13}

			# 检查目录是否存在
			if [ -d $NEW_RESOURCE_PATH$newFile ]
			then
				# 复制文件到新的目录
				cp -i $1"/"$file $NEW_RESOURCE_PATH$newFile"/"$path
				echo copy file $NEW_RESOURCE_PATH$newFile"/"$path
			else
				# 创建这个目录
				mkdir $NEW_RESOURCE_PATH$newFile
				echo create file $NEW_RESOURCE_PATH$newFile
			fi
		fi
	done
}
IMG_PATH="/Users/tommy/Documents/resource_new/release_skill2"
rename_img $IMG_PATH ""
#createPlist $NEW_RESOURCE_PATH
#compression $OUTPUT_PATH
# ${1##*/}   ##*/ 表示从左边开始删除最后（最右边）一个 / 号及左边的所有字符