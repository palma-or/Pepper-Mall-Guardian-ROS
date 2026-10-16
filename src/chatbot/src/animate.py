#!/usr/bin/python3

import rospy
from pepper_nodes.srv import AnimationService, AnimationServiceRequest, AnimationServiceResponse
from std_msgs.msg import String

class Handler_animate:
    '''
    The constructor creates the service proxy object, which is able to make the robot speak
    '''
    def __init__(self):
        self.animate = rospy.ServiceProxy("/animated_speech_service", AnimationService)

    '''
    This method calls the Text to Speech service and sends it the desired text to be played.
    '''
    def call(self, text):
        msg = AnimationServiceRequest()
        msg.input.data = text
        try:
            resp = self.animate(msg)
            rospy.loginfo(resp.ack)
        except Exception as e:
            pass