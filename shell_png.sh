#!/bin/bash
function ergodic(){
        for file in ` ls $1 `
        do
                if [ -d $1"/"$file ]
                then
                        ergodic $1"/"$file
                elif [ "${file##*.}" = "png" ]
				then
					cd /Users/tommy/Documents/ImageProcessing/pngquant
					./pngquant --ext .png --force $1"/"$file
					echo $1"/"$file
                    
                    TexturePacker $1"/"$file --sheet $1"/"$file --no-trim --opt RGBA4444 --size-constraints AnySize --dither-fs-alpha --border-padding 0 --disable-rotation
                    echo 'TP setting OK name = '$file
                fi
        done
}
INIT_PATH="/Users/tommy/Documents/sheroes/res"
ergodic $INIT_PATH