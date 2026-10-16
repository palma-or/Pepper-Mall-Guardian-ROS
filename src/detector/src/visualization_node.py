#!/usr/bin/python3
import cv2
import rospy
import time
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from threading import Lock
from vision_msgs.msg import *
from std_msgs.msg import String

class VisualizationNode:
    """
    Class for visualizing object detection and emotion analysis results on images.

    Attributes:
    - _br: CvBridge object for converting image messages to OpenCV format.
    - _image: Current image data for visualization.
    - _image_lock: Thread lock for safe access to image data.
    - _emotions: Dictionary to store emotions detected for each bounding box.
    - _people_detections: List to store people detection data.
    - _emotion_timestamps: Dictionary to store timestamps of detected emotions.

    Methods:
    - __init__(self): Initializes the VisualizationNode class.
    - __call__(self): Initiates the ROS node, subscribes to image, detection, and emotion topics, and starts visualization.
    - __receive_image(self, msg: Image) -> None: Callback for receiving raw image messages.
    - __receive_detection(self, msg: Detection2DArray) -> None: Callback for receiving people detection messages.
    - __receive_emotion(self, msg: EmotionImageArray) -> None: Callback for receiving emotion detection messages.
    - __draw(self) -> None: Draws bounding boxes, labels, and emotions on the current image.
    """
    
    def __init__(self) -> None:
        """
        Initializes the VisualizationNode class.

        Attributes:
        - _br: CvBridge object for converting image messages to OpenCV format.
        - _image: Current image data for visualization.
        - _image_lock: Thread lock for safe access to image data.
        - _emotions: Dictionary to store emotions detected for each bounding box.
        - _people_detections: List to store people detection data.
        - _emotion_timestamps: Dictionary to store timestamps of detected emotions.
        """
        self._br = CvBridge()
        self._image = None
        self._image_lock = Lock()
        self._emotions = {}
        self._people_detections = []
        self._emotion_timestamps = {}

    def __call__(self) -> None:
        """
        Initiates the node, subscribes to video input, and starts visualization.

        Subscribes to '/image_feed' for raw images, '/face_detection' for face bounding boxes, and
        '/emotion_detection' for emotion analysis. Displays the annotated image.
        """
        rospy.init_node('visualization_node')
        rospy.Subscriber("/image_feed", Image, self.__receive_image)
        rospy.Subscriber("/people_detection", Detection2DArray, self.__receive_detection)
        rospy.Subscriber("/emotion_detection", EmotionImageArray, self.__receive_emotion)

        try:
            while not rospy.is_shutdown():
                with self._image_lock:
                    if self._image is not None:
                        self.__draw()
                        cv2.imshow("Visualization", self._image)
                        cv2.waitKey(delay=1)
        except KeyboardInterrupt:
            pass
        finally:
            cv2.destroyAllWindows()

    # Private Methods
    def __receive_image(self, msg : Image) -> None:
        """
        Callback function for receiving raw images.

        Args:
        - msg (Image): Incoming image data.

        Converts the received image message to OpenCV format and updates the _image attribute.
        """
        with self._image_lock:
            self._image = self._br.imgmsg_to_cv2(msg, "bgr8")
    
    def __receive_detection(self, msg: Detection2DArray) -> None:
        """
        Callback function for receiving face detection messages.

        Args:
        - msg (Detection2DArray): Incoming detection data.

        Draws bounding boxes and labels on the current image based on the received detection data.
        """
        with self._image_lock:
            self._people_detections = msg.detections

    def __receive_emotion(self, msg: EmotionImageArray) -> None:
        """
        Callback function to process received emotion detections.

        Args:
        - msg (EmotionImageArray): The message containing emotion detections.

        This function processes the incoming emotion detections.
        """
        with self._image_lock:
            current_time = time.time()
            self._emotions.clear()  

            #rospy.loginfo(f"Received {len(msg.detections)} emotion detections")  # Debug

            for detection in msg.detections:
                face_id = f"{detection.x}_{detection.y}"  
                self._emotions[face_id] = {
                    'emotion': detection.emotion,
                    'score': detection.score,
                    'bbox': (detection.x, detection.y, detection.width, detection.height),
                    'timestamp': current_time
                }


    def __draw(self) -> None:
        """
        Draws bounding boxes, labels, and emotions on the image.

        This method processes the current image to overlay bounding boxes for detected people and emotions.
        It also removes outdated emotion detections based on their timestamps.
        """
        image = self._image.copy()
        h, w, _ = image.shape

        # Draw people detections
        for detection in self._people_detections:
            bbox = detection.bbox
            x1 = int((bbox.center.x - bbox.size_x / 2) * w)
            y1 = int((bbox.center.y - bbox.size_y / 2) * h)
            x2 = int((bbox.center.x + bbox.size_x / 2) * w)
            y2 = int((bbox.center.y + bbox.size_y / 2) * h)

            cv2.rectangle(image, (x1, y1), (x2, y2), (255, 0, 0), 2)  # Blue for people
            label = f"Person ({detection.results[0].score:.2f})"
            cv2.putText(image, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 0, 0), 2)

        current_time = time.time()
        # Remove outdated emotions
        expired_keys = [key for key, data in self._emotions.items() if current_time - data['timestamp'] > 1.0]
        for key in expired_keys:
            del self._emotions[key]

        # Draw emotion detections
        for face_id, emotion_data in self._emotions.items():
            emotion = emotion_data['emotion']
            score = emotion_data['score']
            x, y, width, height = emotion_data['bbox']

            # Calculate bounding box coordinates
            x1 = int((x - width / 2) * w)
            y1 = int((y - height / 2) * h)
            x2 = int((x + width / 2) * w)
            y2 = int((y + height / 2) * h)

            # Draw bounding box for emotion
            cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)  # Green for emotions
            label = f"{emotion} ({score:.2f})"
            cv2.putText(image, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

        self._image = image


if __name__ == "__main__":
    visualization_node = VisualizationNode()
    visualization_node()