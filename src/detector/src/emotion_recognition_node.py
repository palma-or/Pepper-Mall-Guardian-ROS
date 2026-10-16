#!/usr/bin/python3
import rospy
import cv2
import numpy as np
import os

from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from vision_msgs.msg import EmotionImage, EmotionImageArray, Detection2DArray
from vision_msgs.msg import ObjectHypothesisWithPose
from tensorflow.keras.models import load_model
from threading import Lock

# Parameters
script_dir = os.path.dirname(os.path.abspath(__file__))
EMOTION_MODEL = os.path.join(script_dir, "EmotionModels", "emotion.hdf5")
INPUT_SIZE = (224, 224)
MEANS = np.array([131.0912, 103.8827, 91.4953])
EMOTION_LIST = ['surprise', 'fear', 'disgust', 'happiness', 'sadness', 'anger', 'neutral']

class EmotionClassifierNode():
    """
    Class for detecting emotions in faces using a deep learning model.

    Attributes:
        _br (CvBridge): Bridge for converting ROS image messages to OpenCV images.
        _model (tensorflow.keras.models.Model): Loaded emotion recognition model.
        _publisher (rospy.Publisher): ROS publisher for emotion detection results.
        _image_lock (threading.Lock): Lock for thread-safe access to the image.
        _image (numpy.ndarray): The latest received image.
        _detections (list): List of detected faces.

    Methods:
        __init__(self): Initializes the EmotionClassifierNode.
        __call__(self): Starts the ROS node and subscribes to relevant topics.
        __receive_image(self, msg: Image): Handles incoming image messages.
        __receive_detections(self, msg: Detection2DArray): Handles face detection messages.
        __classify_emotions(self): Processes detected faces and classifies their emotions.
    """
    
    def __init__(self) -> None:
        """Initializes the EmotionClassifierNode class."""
        self._br = CvBridge()
        self._model = load_model(EMOTION_MODEL)
        self._publisher = rospy.Publisher('/emotion_detection', EmotionImageArray, queue_size=1)
        self._image_lock = Lock()
        self._image = None
        self._detections = []

    def __call__(self) -> None:
        """Starts the ROS node and subscribes to relevant topics."""
        rospy.init_node('emotion_recognition', anonymous=True)
        #rospy.loginfo("Emotion Classifier ready.")
        rospy.Subscriber('/image_feed', Image, self.__receive_image)
        rospy.Subscriber('/face_detection', Detection2DArray, self.__receive_detections)
        try:
            rospy.spin()
        except KeyboardInterrupt:
            pass
    
    def __receive_image(self, msg: Image) -> None:
        """Handles incoming image messages."""
        with self._image_lock:
            self._image = self._br.imgmsg_to_cv2(msg, "bgr8")
    
    def __receive_detections(self, msg: Detection2DArray) -> None:
        """Handles face detection messages."""
        with self._image_lock:
            self._detections = msg.detections
        self.__classify_emotions()
    
    def __classify_emotions(self) -> None:
        """Processes detected faces and classifies their emotions."""
        with self._image_lock:
            if self._image is None or not self._detections:
                return
            emotion_message = EmotionImageArray()
            h, w, _ = self._image.shape
            
            for detection in self._detections:
                bbox = detection.bbox
                x1 = int((bbox.center.x - bbox.size_x / 2) * w)
                y1 = int((bbox.center.y - bbox.size_y / 2) * h)
                x2 = int((bbox.center.x + bbox.size_x / 2) * w)
                y2 = int((bbox.center.y + bbox.size_y / 2) * h)
                
                face = self._image[max(0, y1):min(y2, h), max(0, x1):min(x2, w)]
                if face.size == 0:
                    continue
                
                resized_face = cv2.resize(face, INPUT_SIZE)
                blob = np.array([resized_face.astype(float) - MEANS])
                emotion_preds = self._model.predict(blob, verbose=0)
                emotion = EMOTION_LIST[np.argmax(emotion_preds[0])]
                score = float(np.max(emotion_preds[0]))
                
                emotion_detection = EmotionImage()
                emotion_detection.emotion = emotion
                emotion_detection.score = score
                emotion_detection.x = bbox.center.x
                emotion_detection.y = bbox.center.y
                emotion_detection.width = bbox.size_x
                emotion_detection.height = bbox.size_y
                
                emotion_message.detections.append(emotion_detection)
                
            self._publisher.publish(emotion_message)

if __name__ == '__main__':
    node = EmotionClassifierNode()
    node()