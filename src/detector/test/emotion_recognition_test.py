#!/usr/bin/python3
import cv2
import glob
import os
import numpy as np

from tensorflow.keras.models import load_model
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from vision_msgs.msg import EmotionImageArray
from vision_msgs.msg import Detection2DArray

# Parameters
script_dir = os.path.dirname(os.path.abspath(__file__))
EMOTION_MODEL = os.path.join(script_dir, "../src/EmotionModels", "emotion.hdf5")
INPUT_SIZE = (224, 224)
MEANS = np.array([131.0912, 103.8827, 91.4953])
EMOTION_LIST = ['surprise', 'fear', 'disgust', 'happiness', 'sadness', 'anger', 'neutral']

VIDEOS_PATH = os.path.join(script_dir, "TestSet/TestEmotion*")
DIR_LIST = [path for path in glob.glob(os.path.join(VIDEOS_PATH, "**"), recursive=True) if os.path.isdir(path)]
FRAMES_LIST = [path for dir_video in DIR_LIST for path in glob.glob(os.path.join(dir_video, "**"), recursive=True) if os.path.isfile(path)]
FRAMES_LIST = sorted(FRAMES_LIST)

class EmotionRecognitionTest():
    """
    Class for testing the emotion recognition model.
    
    Attributes:
        - _br: CvBridge for image conversion.
        - _model: Loaded deep learning model for emotion recognition.
        - _predictions: List of detected emotions.
        - _ground_truths: List of ground truth labels.
    
    Methods:
        - __init__(self): Initializes the test class.
        - __call__(self): Runs the test on all frames.
        - __handle_emotion_detection(self, img): Detects emotions in a given image.
        - __calculate_metrics(self): Computes precision, recall, and F1-score.
    """
    
    def __init__(self) -> None:
        """Initializes the EmotionRecognitionTest class."""
        self._br = CvBridge()
        self._model = load_model(EMOTION_MODEL)
        self._predictions = []
        self._ground_truths = []

       
        for dir_video in DIR_LIST:
            dir_video = dir_video.split("/")[:-1]
            dir_video[-1] += "_annotations.txt"
            dir_video = "/".join(dir_video)
            with open(dir_video, "r") as f:
                lines = f.readlines()
                for line in lines:
                    line = line.strip().split(",")
                    self._ground_truths.append(line[1])  
    
    def __call__(self) -> None:
        """Runs the test on all frames."""
        for frame in FRAMES_LIST:
            img = cv2.imread(os.path.join(frame))
            self.__handle_emotion_detection(img)
        
        precision, recall, f1_score = self.__calculate_metrics()
        print(f"Precision = {precision} | Recall = {recall} | F1-score = {f1_score}")

    def __handle_emotion_detection(self, img) -> None:
        """Detects emotions in a given image."""
        if img is None:
            self._predictions.append(None)
            return
        
        resized_face = cv2.resize(img, INPUT_SIZE)
        blob = np.array([resized_face.astype(float) - MEANS])
        
        emotion_preds = self._model.predict(blob)
        emotion = EMOTION_LIST[np.argmax(emotion_preds[0])]
        
        self._predictions.append(emotion)

    def __calculate_metrics(self):
        """Computes precision, recall, and F1-score."""
        true_positives = 0
        false_positives = 0
        false_negatives = 0

        for pred, gt in zip(self._predictions, self._ground_truths):
            if pred is None or gt not in EMOTION_LIST:
                continue
            if pred == gt:
                true_positives += 1
            else:
                false_positives += 1
                false_negatives += 1

        precision = true_positives / (true_positives + false_positives) if (true_positives + false_positives) > 0 else 0
        recall = true_positives / (true_positives + false_negatives) if (true_positives + false_negatives) > 0 else 0
        f1_score = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0

        return precision, recall, f1_score

if __name__ == '__main__':
    emotion_test = EmotionRecognitionTest()
    emotion_test()

