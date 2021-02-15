library firebase_tools;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_tools/fierbase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FirebaseTools{

  static FirebaseTools _firebaseTools=FirebaseTools._internal();
  FirebaseTools._internal(){
    Firebase.initializeApp();
  }
  factory FirebaseTools(){
    return _firebaseTools;
  }

  void sendAnalytics({@required eventName, Map<String, dynamic> parameters}){
     Analytics.sendAnalytics(eventName: eventName,parameters: parameters);
  }

  void setUserPropert({@required String value,@required String key}){
    Analytics.setUserProperty(userPropertyKey: key,userPropertyValue: value);
  }

  Future<void> enableCrashLytics() async {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(true);
  }

}

