#!/usr/bin/env python3
from chatbot.srv import Dialogue, DialogueResponse

import rospy
import requests
import speech_recognition as sr
from std_msgs.msg import Int16MultiArray, String
import numpy as np


rospy.init_node('dialogue service')
pub = rospy.Publisher('/mic_data', Int16MultiArray, queue_size=10)
pub2 = rospy.Publisher('/ans', String, queue_size=10)

r = sr.Recognizer()
r.dynamic_energy_threshold = False 
r.energy_threshold = 150
m = sr.Microphone(device_index=None,
            sample_rate=16000,
            chunk_size=1024)

def callback(recognizer, audio):

	data = np.frombuffer(audio.get_raw_data(), dtype=np.int16)
	data_to_send = Int16MultiArray()
	data_to_send.data = data
	pub.publish(data_to_send)

def get_ans(data):
	
	get_answer_url = 'http://localhost:5002/webhooks/rest/webhook'
	message = {
	    "sender": 'bot',
	    "message": data.data
	}

	r = requests.post(get_answer_url, json=message)
	response = DialogueResponse()
	response.answer = ""

	for i in r.json():
		response.answer += i['text'] + ' ' if 'text' in i else ''

	final_message = data.data + "|" + response.answer

	pub2.publish(final_message)

stop_listening = r.listen_in_background(m, callback)
print('Recording')

def start():
	rospy.Subscriber('/ans_data', String, get_ans)
	rospy.spin()

if __name__  == '__main__':
	start()
