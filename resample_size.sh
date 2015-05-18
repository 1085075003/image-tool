#这个是用来批量处理图片大小的
#可以查看sips --help查看命令
IMG_SIZE=100
OUT_PATH="/Users/tommy/Documents/test2"
function ergodic(){
        for file in ` ls $1 `
        do
                if [ -d $1"/"$file ]
                then
                        ergodic $1"/"$file
                elif [ "${file##*.}" = "png" ]
				then
                    sips -Z $IMG_SIZE $1"/"$file --out $OUT_PATH"/"$file
                    echo $1"/"$file
                fi
        done
}
INIT_PATH="/Users/tommy/Documents/test"
ergodic $INIT_PATH