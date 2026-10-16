;; Auto-generated. Do not edit!


(when (boundp 'pepper_nodes::VoiceDetectionService)
  (if (not (find-package "PEPPER_NODES"))
    (make-package "PEPPER_NODES"))
  (shadow 'VoiceDetectionService (find-package "PEPPER_NODES")))
(unless (find-package "PEPPER_NODES::VOICEDETECTIONSERVICE")
  (make-package "PEPPER_NODES::VOICEDETECTIONSERVICE"))
(unless (find-package "PEPPER_NODES::VOICEDETECTIONSERVICEREQUEST")
  (make-package "PEPPER_NODES::VOICEDETECTIONSERVICEREQUEST"))
(unless (find-package "PEPPER_NODES::VOICEDETECTIONSERVICERESPONSE")
  (make-package "PEPPER_NODES::VOICEDETECTIONSERVICERESPONSE"))

(in-package "ROS")



(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass pepper_nodes::VoiceDetectionServiceRequest
  :super ros::object
  :slots ())

(defmethod pepper_nodes::VoiceDetectionServiceRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass pepper_nodes::VoiceDetectionServiceResponse
  :super ros::object
  :slots (_output ))

(defmethod pepper_nodes::VoiceDetectionServiceResponse
  (:init
   (&key
    ((:output __output) (instance std_msgs::Int16MultiArray :init))
    )
   (send-super :init)
   (setq _output __output)
   self)
  (:output
   (&rest __output)
   (if (keywordp (car __output))
       (send* _output __output)
     (progn
       (if __output (setq _output (car __output)))
       _output)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Int16MultiArray _output
    (send _output :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Int16MultiArray _output
       (send _output :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Int16MultiArray _output
     (send _output :deserialize buf ptr-) (incf ptr- (send _output :serialization-length))
   ;;
   self)
  )

(defclass pepper_nodes::VoiceDetectionService
  :super ros::object
  :slots ())

(setf (get pepper_nodes::VoiceDetectionService :md5sum-) "c4e176c9f8ad32507aa931a67656b59c")
(setf (get pepper_nodes::VoiceDetectionService :datatype-) "pepper_nodes/VoiceDetectionService")
(setf (get pepper_nodes::VoiceDetectionService :request) pepper_nodes::VoiceDetectionServiceRequest)
(setf (get pepper_nodes::VoiceDetectionService :response) pepper_nodes::VoiceDetectionServiceResponse)

(defmethod pepper_nodes::VoiceDetectionServiceRequest
  (:response () (instance pepper_nodes::VoiceDetectionServiceResponse :init)))

(setf (get pepper_nodes::VoiceDetectionServiceRequest :md5sum-) "c4e176c9f8ad32507aa931a67656b59c")
(setf (get pepper_nodes::VoiceDetectionServiceRequest :datatype-) "pepper_nodes/VoiceDetectionServiceRequest")
(setf (get pepper_nodes::VoiceDetectionServiceRequest :definition-)
      "---
std_msgs/Int16MultiArray output

================================================================================
MSG: std_msgs/Int16MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
int16[]           data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
")

(setf (get pepper_nodes::VoiceDetectionServiceResponse :md5sum-) "c4e176c9f8ad32507aa931a67656b59c")
(setf (get pepper_nodes::VoiceDetectionServiceResponse :datatype-) "pepper_nodes/VoiceDetectionServiceResponse")
(setf (get pepper_nodes::VoiceDetectionServiceResponse :definition-)
      "---
std_msgs/Int16MultiArray output

================================================================================
MSG: std_msgs/Int16MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
int16[]           data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
")



(provide :pepper_nodes/VoiceDetectionService "c4e176c9f8ad32507aa931a67656b59c")


