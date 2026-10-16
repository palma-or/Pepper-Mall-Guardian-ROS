
(cl:in-package :asdf)

(defsystem "pepper_nodes-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "AnimationService" :depends-on ("_package_AnimationService"))
    (:file "_package_AnimationService" :depends-on ("_package"))
    (:file "ExecuteJS" :depends-on ("_package_ExecuteJS"))
    (:file "_package_ExecuteJS" :depends-on ("_package"))
    (:file "LoadUrl" :depends-on ("_package_LoadUrl"))
    (:file "_package_LoadUrl" :depends-on ("_package"))
    (:file "Rest" :depends-on ("_package_Rest"))
    (:file "_package_Rest" :depends-on ("_package"))
    (:file "TabletService" :depends-on ("_package_TabletService"))
    (:file "_package_TabletService" :depends-on ("_package"))
    (:file "Text2Speech" :depends-on ("_package_Text2Speech"))
    (:file "_package_Text2Speech" :depends-on ("_package"))
    (:file "VoiceDetectionService" :depends-on ("_package_VoiceDetectionService"))
    (:file "_package_VoiceDetectionService" :depends-on ("_package"))
    (:file "WakeUp" :depends-on ("_package_WakeUp"))
    (:file "_package_WakeUp" :depends-on ("_package"))
  ))