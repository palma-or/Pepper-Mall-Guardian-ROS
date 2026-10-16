// Auto-generated. Do not edit!

// (in-package vision_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let EmotionImage = require('./EmotionImage.js');

//-----------------------------------------------------------

class EmotionImageArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.detections = null;
    }
    else {
      if (initObj.hasOwnProperty('detections')) {
        this.detections = initObj.detections
      }
      else {
        this.detections = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EmotionImageArray
    // Serialize message field [detections]
    // Serialize the length for message field [detections]
    bufferOffset = _serializer.uint32(obj.detections.length, buffer, bufferOffset);
    obj.detections.forEach((val) => {
      bufferOffset = EmotionImage.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EmotionImageArray
    let len;
    let data = new EmotionImageArray(null);
    // Deserialize message field [detections]
    // Deserialize array length for message field [detections]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.detections = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.detections[i] = EmotionImage.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.detections.forEach((val) => {
      length += EmotionImage.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'vision_msgs/EmotionImageArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bbc3eaf0740c9f6564d400133cd89040';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    EmotionImage[] detections
    
    ================================================================================
    MSG: vision_msgs/EmotionImage
    string emotion        # Nome dell'emozione rilevata (es. happiness, sadness)
    float32 score         # Punteggio di confidenza dell'emozione
    float32 x             # Coordinate x della bounding box (centro)
    float32 y             # Coordinate y della bounding box (centro)
    float32 width         # Larghezza della bounding box
    float32 height        # Altezza della bounding box
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new EmotionImageArray(null);
    if (msg.detections !== undefined) {
      resolved.detections = new Array(msg.detections.length);
      for (let i = 0; i < resolved.detections.length; ++i) {
        resolved.detections[i] = EmotionImage.Resolve(msg.detections[i]);
      }
    }
    else {
      resolved.detections = []
    }

    return resolved;
    }
};

module.exports = EmotionImageArray;
