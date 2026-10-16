; Auto-generated. Do not edit!


(cl:in-package vision_msgs-msg)


;//! \htmlinclude EmotionImageArray.msg.html

(cl:defclass <EmotionImageArray> (roslisp-msg-protocol:ros-message)
  ((detections
    :reader detections
    :initarg :detections
    :type (cl:vector vision_msgs-msg:EmotionImage)
   :initform (cl:make-array 0 :element-type 'vision_msgs-msg:EmotionImage :initial-element (cl:make-instance 'vision_msgs-msg:EmotionImage))))
)

(cl:defclass EmotionImageArray (<EmotionImageArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EmotionImageArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EmotionImageArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vision_msgs-msg:<EmotionImageArray> is deprecated: use vision_msgs-msg:EmotionImageArray instead.")))

(cl:ensure-generic-function 'detections-val :lambda-list '(m))
(cl:defmethod detections-val ((m <EmotionImageArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vision_msgs-msg:detections-val is deprecated.  Use vision_msgs-msg:detections instead.")
  (detections m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EmotionImageArray>) ostream)
  "Serializes a message object of type '<EmotionImageArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'detections))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'detections))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EmotionImageArray>) istream)
  "Deserializes a message object of type '<EmotionImageArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'detections) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'detections)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'vision_msgs-msg:EmotionImage))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EmotionImageArray>)))
  "Returns string type for a message object of type '<EmotionImageArray>"
  "vision_msgs/EmotionImageArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EmotionImageArray)))
  "Returns string type for a message object of type 'EmotionImageArray"
  "vision_msgs/EmotionImageArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EmotionImageArray>)))
  "Returns md5sum for a message object of type '<EmotionImageArray>"
  "bbc3eaf0740c9f6564d400133cd89040")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EmotionImageArray)))
  "Returns md5sum for a message object of type 'EmotionImageArray"
  "bbc3eaf0740c9f6564d400133cd89040")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EmotionImageArray>)))
  "Returns full string definition for message of type '<EmotionImageArray>"
  (cl:format cl:nil "EmotionImage[] detections~%~%================================================================================~%MSG: vision_msgs/EmotionImage~%string emotion        # Nome dell'emozione rilevata (es. happiness, sadness)~%float32 score         # Punteggio di confidenza dell'emozione~%float32 x             # Coordinate x della bounding box (centro)~%float32 y             # Coordinate y della bounding box (centro)~%float32 width         # Larghezza della bounding box~%float32 height        # Altezza della bounding box~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EmotionImageArray)))
  "Returns full string definition for message of type 'EmotionImageArray"
  (cl:format cl:nil "EmotionImage[] detections~%~%================================================================================~%MSG: vision_msgs/EmotionImage~%string emotion        # Nome dell'emozione rilevata (es. happiness, sadness)~%float32 score         # Punteggio di confidenza dell'emozione~%float32 x             # Coordinate x della bounding box (centro)~%float32 y             # Coordinate y della bounding box (centro)~%float32 width         # Larghezza della bounding box~%float32 height        # Altezza della bounding box~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EmotionImageArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'detections) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EmotionImageArray>))
  "Converts a ROS message object to a list"
  (cl:list 'EmotionImageArray
    (cl:cons ':detections (detections msg))
))
