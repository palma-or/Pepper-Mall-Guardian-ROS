;; Auto-generated. Do not edit!


(when (boundp 'pepper_nodes::TabletService)
  (if (not (find-package "PEPPER_NODES"))
    (make-package "PEPPER_NODES"))
  (shadow 'TabletService (find-package "PEPPER_NODES")))
(unless (find-package "PEPPER_NODES::TABLETSERVICE")
  (make-package "PEPPER_NODES::TABLETSERVICE"))
(unless (find-package "PEPPER_NODES::TABLETSERVICEREQUEST")
  (make-package "PEPPER_NODES::TABLETSERVICEREQUEST"))
(unless (find-package "PEPPER_NODES::TABLETSERVICERESPONSE")
  (make-package "PEPPER_NODES::TABLETSERVICERESPONSE"))

(in-package "ROS")

(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass pepper_nodes::TabletServiceRequest
  :super ros::object
  :slots (_input ))

(defmethod pepper_nodes::TabletServiceRequest
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

(defclass pepper_nodes::TabletServiceResponse
  :super ros::object
  :slots (_ack ))

(defmethod pepper_nodes::TabletServiceResponse
  (:init
   (&key
    ((:ack __ack) (instance std_msgs::String :init))
    )
   (send-super :init)
   (setq _ack __ack)
   self)
  (:ack
   (&rest __ack)
   (if (keywordp (car __ack))
       (send* _ack __ack)
     (progn
       (if __ack (setq _ack (car __ack)))
       _ack)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/String _ack
    (send _ack :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/String _ack
       (send _ack :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/String _ack
     (send _ack :deserialize buf ptr-) (incf ptr- (send _ack :serialization-length))
   ;;
   self)
  )

(defclass pepper_nodes::TabletService
  :super ros::object
  :slots ())

(setf (get pepper_nodes::TabletService :md5sum-) "8b55dba5ce52d0e4d2c88f751b201113")
(setf (get pepper_nodes::TabletService :datatype-) "pepper_nodes/TabletService")
(setf (get pepper_nodes::TabletService :request) pepper_nodes::TabletServiceRequest)
(setf (get pepper_nodes::TabletService :response) pepper_nodes::TabletServiceResponse)

(defmethod pepper_nodes::TabletServiceRequest
  (:response () (instance pepper_nodes::TabletServiceResponse :init)))

(setf (get pepper_nodes::TabletServiceRequest :md5sum-) "8b55dba5ce52d0e4d2c88f751b201113")
(setf (get pepper_nodes::TabletServiceRequest :datatype-) "pepper_nodes/TabletServiceRequest")
(setf (get pepper_nodes::TabletServiceRequest :definition-)
      "std_msgs/String input

================================================================================
MSG: std_msgs/String
string data
---
std_msgs/String ack

================================================================================
MSG: std_msgs/String
string data
")

(setf (get pepper_nodes::TabletServiceResponse :md5sum-) "8b55dba5ce52d0e4d2c88f751b201113")
(setf (get pepper_nodes::TabletServiceResponse :datatype-) "pepper_nodes/TabletServiceResponse")
(setf (get pepper_nodes::TabletServiceResponse :definition-)
      "std_msgs/String input

================================================================================
MSG: std_msgs/String
string data
---
std_msgs/String ack

================================================================================
MSG: std_msgs/String
string data
")



(provide :pepper_nodes/TabletService "8b55dba5ce52d0e4d2c88f751b201113")


