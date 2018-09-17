#/usr/bin/env sh

IMAGE_ROOT=/home/song/Documents/VGG_test/
TARGET_PATH=/home/xmlfiles/

for subpath in `ls $IMAGE_ROOT`
do
	echo "subpath: "$subpath
	for xmlfile in `find $IMAGE_ROOT$subpath -name "*.xml" -print`
	do
		echo "xmlfile: "$xmlfile
#		cp $subpath"/"$xmlfile $TARGET_PATH$subpath"_"$xmlfile
        cp $xmlfile $TARGET_PATH$subpath"_"$(basename $xmlfile)
	done
done
