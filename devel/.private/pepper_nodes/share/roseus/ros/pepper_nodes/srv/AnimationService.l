;; Auto-generated. Do not edit!


(when (boundp 'pepper_nodes::AnimationService)
  (if (not (find-package "PEPPER_NODES"))
    (make-package "PEPPER_NODES"))
  (shadow 'AnimationService (find-package "PEPPER_NODES")))
(unless (find-package "PEPPER_NODES::ANIMATIONSERVICE")
  (make-package "PEPPER_NODES::ANIMATIONSERVICE"))
(unless (find-package "PEPPER_NODES::ANIMATIONSERVICEREQUEST")
  (make-package "PEPPER_NODES::ANIMATIONSERVICEREQUEST"))
(unless (find-package "PEPPER_NODES::ANIMATIONSERVICERESPONSE")
  (make-package "PEPPER_NODES::ANIMATIONSERVICERESPONSE"))

(in-package "ROS")

(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass pepper_nodes::AnimationServiceRequest
  :super ros::object
  :slots (_input ))

(defmethod pepper_nodes::AnimationServiceRequest
  (:init
   (&key
    ((:input __input) (instance std_msgs::String :init))
    )
   (send-super :init)
   (setq _input __input)
   self)
  (:input
   (&rest __input)
   (if (keywordp (car __input))
       (send* _input __input)
     (progn
       (if __input (setq _input (car __input)))
       _input)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/String _input
    (send _input :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/String _input
       (send _input :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/String _input
     (send _input :deserialize buf ptr-) (incf ptr- (send _input :serialization-length))
   ;;
   self)
  )

(defclass pepper_nodes::AnimationServiceResponse
  :super ros::object
  :slots (_output ))

(defmethod pepper_nodes::AnimationServiceResponse
  (:init
   (&key
    ((:output __output) (instance std_msgs::String :init))
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
    ;; std_msgs/String _output
    (send _output :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/String _output
       (send _output :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/String _output
     (send _output :deserialize buf ptr-) (incf ptr- (send _output :serialization-length))
   ;;
   self)
  )

(defclass pepper_nodes::AnimationService
  :super ros::object
  :slots ())

(setf (get pepper_nodes::AnimationService :md5sum-) "d8b7e9905e6a815639dc67959117aa3b")
(setf (get pepper_nodes::AnimationService :datatype-) "pepper_nodes/AnimationService")
(setf (get pepper_nodes::AnimationService :request) pepper_nodes::AnimationServiceRequest)
(setf (get pepper_nodes::AnimationService :response) pepper_nodes::AnimationServiceResponse)

(defmethod pepper_nodes::AnimationServiceRequest
  (:response () (instance pepper_nodes::AnimationServiceResponse :init)))

(setf (get pepper_nodes::AnimationServiceRequest :md5sum-) "d8b7e9905e6a815639dc67959117aa3b")
(setf (get pepper_nodes::AnimationServiceRequest :datatype-) "pepper_nodes/AnimationServiceRequest")
(setf (get pepper_nodes::AnimationServiceRequest :definition-)
      "std_msgs/String input

================================================================================
MSG: std_msgs/String
string data
---
std_msgs/String output

================================================================================
MSG: std_msgs/String
string data
")

(setf (get pepper_nodes::AnimationServiceResponse :md5sum-) "d8b7e9905e6a815639dc67959117aa3b")
(setf (get pepper_nodes::AnimationServiceResponse :datatype-) "pepper_nodes/AnimationServiceResponse")
(setf (get pepper_nodes::AnimationServiceResponse :definition-)
      "std_msgs/String input

================================================================================
MSG: std_msgs/String
string data
---
std_msgs/String output

================================================================================
MSG: std_msgs/String
string data
")



(provide :pepper_nodes/AnimationService "d8b7e9905e6a815639dc67959117aa3b")


