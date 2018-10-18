from xml.dom.minidom import parse
import xml.dom.minidom
import os

def gender(var):
    return {
        'male': 0,
        'female': 1
    }.get(var)

def age(var):
    return {
        'freshman': 0,
        'sophomore': 1,
        'junior': 2,
        'senior': 3
    }.get(var)

def toTxt(xmlfile, txtfile):
    DOMTree = xml.dom.minidom.parse(xmlfile)
    annotation = DOMTree.documentElement
    path = annotation.getElementsByTagName("path")
    objects = annotation.getElementsByTagName("object")
    fd = open(txtfile, "a")
    image_path = path[0].childNodes[0].data
    gender_label = gender(objects[0].getElementsByTagName("name")[0].childNodes[0].data)
    age_label = age(objects[1].getElementsByTagName("name")[0].childNodes[0].data)
    fd.write(image_path + " " + str(gender_label) + " " + str(age_label) + "\n")
    fd.close()

if __name__ == '__main__':
    rootdir = '/home/xmlfiles'
    xmllist = os.listdir(rootdir)
    traintxt = '/home/multiLabel/train.txt'
    valtxt = '/home/multiLabel/val.txt'

    for i in range(0, len(xmllist)):
        xmlPath = os.path.join(rootdir, xmllist[i])
        print xmlPath+'\n'
        if os.path.isfile(xmlPath) and xmlPath[-4:]=='.xml':
            if i < len(xmllist)*9/10:
                toTxt(xmlPath, traintxt)
            else:
                toTxt(xmlPath, valtxt)

