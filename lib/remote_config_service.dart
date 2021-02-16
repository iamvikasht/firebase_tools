
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';


class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;


  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }
    return _instance;
  }


  Future initialize() async {
    try {
      await _fetchAndActivate();
    } on FetchThrottledException catch (e) {
      print("Rmeote Config fetch throttled: $e");
    } catch (e) {
      print("Unable to fetch remote config. Default value will be used");
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch(expiration: Duration(seconds: 0));
    await _remoteConfig.activateFetched();
  }

  String getStringValue({@required String stringKey}){
    return _remoteConfig.getString(stringKey);
  }
  bool getBoolValue({@required String boolKey}){
    return _remoteConfig.getBool(boolKey);
  }
  int getIntValue({@required String intKey}){
    return _remoteConfig.getInt(intKey);
  }
}
