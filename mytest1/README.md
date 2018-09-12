
1. (getTxt.sh+inputTxt.py){jpg} -> {all.txt}
2. (trainval.py){all.txt} -> {train.txt, val.txt}
3. (create_imagenet.sh){train.txt, val.txt, jpg} -> {train_lamb, test_lamb}
4. (make_imagenet_mean.sh){train_lamb} -> {imagenet_mean.binaryproto}
5. (start.sh){train_lamb, test_lamb, imagenet_mean.binaryproto} -> {caffemodel}
