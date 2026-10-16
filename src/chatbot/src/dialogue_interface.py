#!/usr/bin/env python3

import rospy
from chatbot.srv import Dialogue, DialogueResponse
from std_msgs.msg import String, Float32MultiArray
from animate import Handler_animate
from threading import Thread

rospy.init_node('writing')
handler_animate = Handler_animate()

def callback(response):
    res = response.data.split('|')
    print(f'[IN]: {res[0]}') 
    __handle_animation_in_thread(res[1])
    print(f'[OUT]: {res[1]}')


def __handle_animation(text):
        '''
        Handles the selection and execution of an animation based on the given text. Chooses different animations 
        like greeting, explaining, calming, or thinking based on the content of the text.

        Args:
            text (str): The text based on which the animation is selected.
        ''' 
        handler_animate.call(text)
    
def __handle_animation_in_thread(text):
        '''
        Executes an animation in a separate thread. This allows the animation to be run without blocking 
        the main execution thread of the node.

        Args:
        - text (str): The text based on which the animation is selected and executed.
        '''
        thread = Thread(target=__handle_animation, args=(text,))
        thread.start()
    
def main():
    rospy.Subscriber("/ans", String, callback)
    rospy.spin()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass