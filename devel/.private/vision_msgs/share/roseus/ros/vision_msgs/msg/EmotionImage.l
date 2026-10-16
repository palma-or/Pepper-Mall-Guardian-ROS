;; Auto-generated. Do not edit!


(when (boundp 'vision_msgs::EmotionImage)
  (if (not (find-package "VISION_MSGS"))
    (make-package "VISION_MSGS"))
  (shadow 'EmotionImage (find-package "VISION_MSGS")))
(unless (find-package "VISION_MSGS::EMOTIONIMAGE")
  (make-package "VISION_MSGS::EMOTIONIMAGE"))

(in-package "ROS")
;;//! \htmlinclude EmotionImage.msg.html


(defclass vision_msgs::EmotionImage
  :super ros::object
  :slots (_emotion _score _x _y _width _height ))

(defmethod vision_msgs::EmotionImage
  (:init
   (&key
    ((:emotion __emotion) "")
    ((:score __score) 0.0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:width __width) 0.0)
    ((:height __height) 0.0)
    )
   (send-super :init)
   (setq _emotion (string __emotion))
   (setq _score (float __score))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _width (float __width))
   (setq _height (float __height))
   self)
  (:emotion
   (&optional __emotion)
   (if __emotion (setq _emotion __emotion)) _emotion)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:serialization-length
   ()
   (+
    ;; string _emotion
    4 (length _emotion)
    ;; float32 _score
    4
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _width
    4
    ;; float32 _height
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _emotion
       (write-long (length _emotion) s) (princ _emotion s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _height
       (sys::poke _height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _emotion
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _emotion (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _height
     (setq _height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get vision_msgs::EmotionImage :md5sum-) "de8208f24e1e0de5e7853623548d7c21")
(setf (get vision_msgs::EmotionImage :datatype-) "vision_msgs/EmotionImage")
(setf (get vision_msgs::EmotionImage :definition-)
      "string emotion        # Nome dell'emozione rilevata (es. happiness, sadness)
float32 score         # Punteggio di confidenza dell'emozione
float32 x             # Coordinate x della bounding box (centro)
float32 y             # Coordinate y della bounding box (centro)
float32 width         # Larghezza della bounding box
float32 height        # Altezza della bounding box


")



(provide :vision_msgs/EmotionImage "de8208f24e1e0de5e7853623548d7c21")


