# Pepper-Mall-Guardian-ROS
# 🤖 Guardian of the Mall: Pepper Robot Assistant

An AI-assisted robotic system designed for shopping malls, featuring the **Pepper humanoid robot** as an interactive guardian and customer assistant. This project integrates a ROS-based architecture, advanced video analytics (people, face, and emotion detection), and a conversational AI chatbot (powered by RASA) to enhance the customer experience.

---

## 📖 Project Overview

In this innovative ecosystem, Pepper acts as a robotic sentinel. Rather than directly processing heavy video analytics on its internal hardware, Pepper interfaces with a database populated by an external camera and video processing system. This allows Pepper to fluidly interact with mall visitors via Natural Language Processing (NLP), answering complex queries about crowd metrics, finding lost individuals, and providing specific event/contest information.

---

## 🏗️ System Architecture (ROS)

The system relies on a robust **Robot Operating System (ROS)** architecture, utilizing custom topics and services to manage video feeds, AI inference, and robotic control.

### Vision & Detection Nodes
* **`image_publisher_node`**: Manages and publishes video feeds (from Pepper's internal camera or external sources) to the `/image_feed` topic.
* **`face_detector_node`**: Uses an OpenCV deep learning module to detect faces, calculate bounding boxes, and publish data as a `Detection2DArray` to `/face_detection`.
* **`people_detector_node`**: Utilizes the highly efficient **MobileNetSSD** to detect pedestrians in real-time, publishing to `/people_detection`.
* **`emotion_recognition_node`**: Employs a pre-trained CNN to normalize faces (224x224) and classify expressions into 7 Ekman categories (surprise, fear, disgust, happiness, sadness, anger, neutral). Publishes results to `/emotion_detection`.
* **`visualization_node`**: Subscribes to the image, people, and emotion topics to render the final visual output with superimposed bounding boxes and labels.

### Conversational & Control Nodes
* **`dialogue_server`**: The core chatbot node linking ROS to the RASA engine. Subscribes to audio text data and queries the RASA server to retrieve logical responses.
* **`asr` (Audio Speech Recognition)**: Captures audio from Pepper's microphone (`/mic_data`) and translates it into text using the **Google Speech Recognition API**.
* **`dialogue_interface`**: Extracts RASA's answers and triggers Pepper's Text-to-Speech and Animation services.
* **`text2speech_node` & `animation_node`**: Wrap the `ALTextToSpeech` and `ALAnimatedSpeech` APIs, giving Pepper a natural voice and contextual body language (e.g., waving during greetings).
* **`wakeup_rest_node`**: Manages Pepper's posture, motors (`ALMotion`, `ALRobotPosture`), and human-tracking capabilities (`ALBasicAwareness`).

---

## 💬 Conversational AI (RASA Chatbot)

The NLP engine is built with **RASA**, allowing Pepper to understand complex human queries through a sophisticated pipeline of Intents, Entities, and Policies.

### Core Capabilities
1. **Count People Task**: Pepper can count individuals based on specific attributes (e.g., "How many females are in the mall?") or track how many people crossed specific virtual boundaries (Alpha, Beta, Gamma, and Delta lines).
2. **Finding Person Task**: Pepper uses interactive forms to ask for specific traits (e.g., gender, carrying a bag, wearing a hat). If a match is found in the database, Pepper provides the location; otherwise, it can alert mall security.
3. **Contest Information Task**: Pepper can answer dynamic queries about mall events or contests (e.g., "Who won the contest?", "Did Group 10 participate?", "What was their score?").

### NLU Configuration
* **Pipeline**: `WhitespaceTokenizer`, `RegexFeaturizer`, `LexicalSyntacticFeaturizer`, `CountVectorsFeaturizer`, `DIETClassifier` (for intent/entity extraction), `EntitySynonymMapper`, and `ResponseSelector`.
* **Policies**: `MemoizationPolicy`, `RulePolicy`, and `TEDPolicy` (max history: 6) to manage complex, multi-turn dialogues and fallback behaviors.
* **Lookup Tables**: Used to boost entity extraction for clothing, genders, passages/frequencies, negations, and specific IDs/Names.

---

## 📊 Performance Metrics

The system was rigorously evaluated through both qualitative end-to-end tests and quantitative cross-validation.

### Computer Vision Models (Test Video Scenarios)
| Detector | Precision | Recall | F1-Score |
| :--- | :--- | :--- | :--- |
| **People (MobileNetSSD)** | 1.000 | 0.931 | 0.964 |
| **Face (OpenCV CNN)** | 0.993 | 0.981 | 0.987 |
| **Emotion (Categorical)** | 0.355 | 0.355 | 0.355 |

### Chatbot Engine (Cross-Validation)
| Task | Accuracy | F1-Score | Precision |
| :--- | :--- | :--- | :--- |
| **Intent Classification** | 0.908 | 0.899 | 0.908 |
| **Entity Extraction (DIET)** | 0.986 | 0.954 | 0.948 |

---

## 🚀 How to Run

Ensure you have ROS and RASA configured in your environment before launching the nodes.

### 1. Run the Computer Vision Detectors
You can launch the detection modules with or without the physical Pepper robot:
```bash
# With Pepper connected and active
roslaunch detector detector.xml

# Using local PC camera instead of Pepper
roslaunch detector detector.xml pepper_on:=False pepper_camera_on:=False
```
2. Run the RASA Chatbot Interface
This script launches the Speech-to-Text, Dialogue Server, and Text-to-Speech nodes:
```bash
roslaunch chatbot dialogue.xml
```
3. Run the Complete System
To test the complete integration (Vision + Voice + RASA + Animations), launch the main XML file:
```bash
# Full system with Pepper
roslaunch all all.xml

# Full system without Pepper (testing locally)
roslaunch all all.xml pepper_on:=False pepper_camera_on:=False mic_index:=None
```
**Authors:** Giovanni Lamb, Palma Orlando, Fabrizio Saturnino, Egidio Zottarelli  
**Institution:** University of Salerno, Department of Information Engineering, Electrical Engineering and Applied Mathematics  
