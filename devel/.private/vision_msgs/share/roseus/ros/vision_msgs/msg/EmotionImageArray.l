;; Auto-generated. Do not edit!


(when (boundp 'vision_msgs::EmotionImageArray)
  (if (not (find-package "VISION_MSGS"))
    (make-package "VISION_MSGS"))
  (shadow 'EmotionImageArray (find-package "VISION_MSGS")))
(unless (find-package "VISION_MSGS::EMOTIONIMAGEARRAY")
  (make-package "VISION_MSGS::EMOTIONIMAGEARRAY"))

(in-package "ROS")
;;//! \htmlinclude EmotionImageArray.msg.html


(defclass vision_msgs::EmotionImageArray
  :super ros::object
  :slots (_detections ))

(defmethod vision_msgs::EmotionImageArray
  (:init
   (&key
    ((:detections __detections) ())
    )
   (send-super :init)
   (setq _detections __detections)
   self)
  (:detections
   (&rest __detections)
   (if (keywordp (car __detections))
       (send* _detections __detections)
     (progn
       (if __detections (setq _detections (car __detections)))
       _detections)))
  (:serialization-length
   ()
   (+
    ;; vision_msgs/EmotionImage[] _detections
    (apply #'+ (send-all _detections :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; vision_msgs/EmotionImage[] _detections
     (write-long (length _detections) s)
     (dolist (elem _detections)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; vision_msgs/EmotionImage[] _detections
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _detections (let (r) (dotimes (i n) (push (instance vision_msgs::EmotionImage :init) r)) r))
     (dolist (elem- _detections)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get vision_msgs::EmotionImageArray :md5sum-) "bbc3eaf0740c9f6564d400133cd89040")
(setf (get vision_msgs::EmotionImageArray :datatype-) "vision_msgs/EmotionImageArray")
(setf (get vision_msgs::EmotionImageArray :definition-)
      "EmotionImage[] detections

================================================================================
MSG: vision_msgs/EmotionImage
string emotion        # Nome dell'emozione rilevata (es. happiness, sadness)
float32 score         # Punteggio di confidenza dell'emozione
float32 x             # Coordinate x della bounding box (centro)
float32 y             # Coordinate y della bounding box (centro)
float32 width         # Larghezza della bounding box
float32 height        # Altezza della bounding box


")



(provide :vision_msgs/EmotionImageArray "bbc3eaf0740c9f6564d400133cd89040")


