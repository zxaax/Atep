#Anti Porn TeleBot
#!/usr/bin/env python
import sys
import argparse
from keras.preprocessing import image
from keras.applications.imagenet_utils import preprocess_input
from model import OpenNsfw
import keras
#from image_utils import create_yahoo_image_loader
import tensorflow
from tensorflow.keras.utils import load_img, img_to_array 
import cv2
import math
import numpy as np


def main(argv):
    model = OpenNsfw()
    #fn_load_image = create_yahoo_image_loader()
    frameNsfw = 0
    frameTotal = 0
    videoFile = sys.argv[1]
    print("Processing...")
    cap = cv2.VideoCapture(videoFile)
    frameRate = cap.get(5) #frame rate
    while(cap.isOpened()):
        frameId = cap.get(1) #current frame number
        ret, frame = cap.read()
        if(ret != True):
            break
        if(frameId % math.floor(frameRate) == 0):
            cv2.imwrite('temp.jpg', frame)
            image_path = 'temp.jpg'
            img = keras.utils.load_img(image_path, target_size=(224, 224))
            x = img_to_array(img)
            x = np.expand_dims(x, axis=0)
            x = preprocess_input(x)
            frameTotal= frameTotal+1
            preds = model.predict(x)
            # print(preds[0][1])
            if(preds[0][1]>=0.15): 
                frameNsfw= frameNsfw+1

    print("\tSFW score:\t{}\n\tNSFW score:\t{}".format(*preds[0]))

    cap.release() 
    if(frameNsfw > 0):
        nsfw_percentage = (frameNsfw/frameTotal)*100
        print("NSFW % = " + str(nsfw_percentage))
        if nsfw_percentage >= 90:
            print("POORN") 
        else:
            print("NONPORN")
    else:
        print("NONPORN")


if __name__ == "__main__":
    main(sys.argv)


#Coded by Ramin Salmani 
#Coded by @MrTeleGrami