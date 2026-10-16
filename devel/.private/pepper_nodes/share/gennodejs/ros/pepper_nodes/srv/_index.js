
"use strict";

let Text2Speech = require('./Text2Speech.js')
let VoiceDetectionService = require('./VoiceDetectionService.js')
let AnimationService = require('./AnimationService.js')
let WakeUp = require('./WakeUp.js')
let LoadUrl = require('./LoadUrl.js')
let TabletService = require('./TabletService.js')
let Rest = require('./Rest.js')
let ExecuteJS = require('./ExecuteJS.js')

module.exports = {
  Text2Speech: Text2Speech,
  VoiceDetectionService: VoiceDetectionService,
  AnimationService: AnimationService,
  WakeUp: WakeUp,
  LoadUrl: LoadUrl,
  TabletService: TabletService,
  Rest: Rest,
  ExecuteJS: ExecuteJS,
};
