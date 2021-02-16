library firebase_tools;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_tools/fierbase_analytics.dart';
import 'package:firebase_tools/remote_config_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FirebaseTools{
  RemoteConfigService _remoteConfigService;
  static FirebaseTools _firebaseTools=FirebaseTools._internal();
  FirebaseTools._internal()  {
    initializeRemoteConfig();
    Firebase.initializeApp();

  }
  factory FirebaseTools(){
    return _firebaseTools;
  }

  //it intialize the remote config object
  void initializeRemoteConfig() async {
    _remoteConfigService=await RemoteConfigService.getInstance();
    _remoteConfigService.initialize();
  }

  //method used to fetch  value of String parameter from remote config in firebase.
  String getStringValue({@required String stringKey}){
    return _remoteConfigService.getStringValue(stringKey: stringKey);
  }

  //method used to fetch value of bool parameter from remote config in firebase
  bool getBoolValue({@required String boolKey}){
    return _remoteConfigService.getBoolValue(boolKey: boolKey);
  }

  //method used to fetch value of int parameter from remote config in firebase.
  int getIntValue({@required String intKey}){
    return _remoteConfigService.getIntValue(intKey: intKey);
  }

  //method used to send Analytics to firebase by passing the event name and its corresponding parameter if any.
  //event name is generally the concatination of evnetType and eventName ex: eventType_eventName
  void sendAnalytics({@required String eventName, Map<String, dynamic> parameters}){
     Analytics.sendAnalytics(eventName: eventName,parameters: parameters);
  }

  //method used to set user property for analytics
  void setUserPropert({@required String key,@required String value}){
    Analytics.setUserProperty(userPropertyKey: key,userPropertyValue: value);
  }

  Future<void> enableCrashLytics() async {
   try{
     await FirebaseCrashlytics.instance
         .setCrashlyticsCollectionEnabled(true);
   }
   catch(e){
     print("error while enabling firebase crashlytics : $e");
   }
  }

}

