OUTPUT_PATH="/Users/tommy/Documents/spritesheet"
function ergodic(){
        for file in ` ls $1 `
        do
                if [ -d $1"/"$file ]
                then
                        ergodic $1"/"$file
                elif [ "${file##*.}" = "png" ]
				then
                    TexturePacker $1 --sheet $OUTPUT_PATH"/"${1##*/}".png" --data $OUTPUT_PATH"/"${1##*/}".plist" --trim-mode Crop --opt RGBA4444 --size-constraints AnySize --dither-fs-alpha --border-padding 0 --disable-rotation
                    echo $1
                    break
                fi
        done
}
INIT_PATH="/Users/tommy/Documents/resource_new/release_skill"
ergodic $INIT_PATH



## ${1##*/}   ##*/ 表示从左边开始删除最后（最右边）一个 / 号及左边的所有字符