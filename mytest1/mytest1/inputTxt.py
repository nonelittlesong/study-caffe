import argparse
import sys, os
def writeouput(result, path):
    if os.path.isfile(path):
        f = open(path, 'a')
        f.write(result + '\n')
        f.close()
    else:
        f = open(path, 'w')
        f.write(result + '\n')
        f.close()
def main(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "image_name",
        help = "Input image, directory or npy."
    )
    parser.add_argument(
        "image_label",
        help = "Output npy filename."
    )

    args = parser.parse_args()
    writeouput(args.image_name+" "+args.image_label, '/home/song/caffe/examples/mytest1/all.txt')
if __name__ == '__main__':
    main(sys.argv)
