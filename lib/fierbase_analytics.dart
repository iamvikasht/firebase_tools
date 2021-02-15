
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_tools.dart';


class Analytics {
  static FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();

  static void sendAnalytics(
      {@required String eventName, Map<String, dynamic> parameters}) async {

    if(kReleaseMode)
      await firebaseAnalytics.logEvent(name: eventName, parameters: parameters);
  }



  static void setUserProperty({@required String userPropertyKey,@required String userPropertyValue}) {
    if (kReleaseMode) {
      if (userPropertyKey != null) {
        firebaseAnalytics.setUserProperty(
            name:   userPropertyKey,
            value: userPropertyValue);
      }
    }

  }
}




