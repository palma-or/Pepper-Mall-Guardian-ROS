#!/usr/bin/python3
import rospy
from std_msgs.msg import Int16MultiArray, String
import numpy as np

from speech_recognition import AudioData
import speech_recognition as sr

# Initialize a Recognizer
r = sr.Recognizer()

# Init node
rospy.init_node('speech_recognition', anonymous=True)
pub = rospy.Publisher('/ans_data', String, queue_size=10)

# this is called from the background thread
def callback(audio):
    data = np.array(audio.data,dtype=np.int16)
    audio_data = AudioData(data.tobytes(), 16000, 2)

    try:
        spoken_text= r.recognize_google(audio_data, language='en-EN')
        #print("Google Speech Recognition pensa tu abbia detto: " + spoken_text)
        pub.publish(spoken_text)
    except sr.UnknownValueError:
        rospy.loginfo("Google Speech Recognition don't understand")
    except sr.RequestError as e:
        rospy.loginfo("Could not request results from Google Speech Recognition service; {0}".format(e))

def listener():
    rospy.Subscriber("/mic_data", Int16MultiArray, callback)

    rospy.spin()

if __name__ == '__main__':
    listener()