import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'j_operate_platform_interface.dart';

/// An implementation of [JOperatePlatform] that uses method channels.
class MethodChannelJOperate extends JOperatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('j_operate');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void setup(String key) {
    methodChannel.invokeMethod("setup",{"key":key});
  }

  @override
  void setDebug(bool debug) {
    methodChannel.invokeMethod("setDebug", {"debug": debug});
  }

  @override
  void login(Map params) {
    methodChannel.invokeMethod("login", pragma);
  }

  @override
  void setChannel(Map params) {
    methodChannel.invokeMethod("setChannel", pragma);
  }

  @override
  void onEvent(String key, Map params) {
    methodChannel.invokeMethod("onEvent", {"key": key, "params": params});
  }

  @override
  Future<String?> getCuid() async {
    final cuid = await methodChannel.invokeMethod("getCuid");
    return cuid;
  }

  @override
  void registerSuperProperties(Map params) {
    methodChannel.invokeMethod("registerSuperProperties", params);
  }

  @override
  void clearSuperProperties(String? key) {
    methodChannel.invokeMethod("clearSuperProperties", {"key": key});
  }

  @override
  void setUtmProperties(Map params) {
    methodChannel.invokeMethod("setUtmProperties", params);
  }

  @override
  void profileSet(String key, String value) {
    methodChannel.invokeMethod("profileSet", {"key": key, "value": value});
  }

  @override
  void profileSetValues(String key, String value) {
    methodChannel
        .invokeMethod("profileSetValues", {"key": key, "value": value});
  }

  @override
  void profileSetOnceValues(String key, List<String> values) {
    methodChannel
        .invokeMethod("profileSetOnceValues", {"key": key, "values": values});
  }

  @override
  void profileSetOnce(String key, String value) {
    methodChannel.invokeMethod("profileSetOnce", {"key": key, "value": value});
  }

  @override
  void profileIncrement(Map<String, int> params) {
    methodChannel.invokeMethod("profileIncrement", params);
  }

  @override
  void profileAppend(String key, String values) {
    methodChannel.invokeMethod("profileAppend", {"key": key, "value": values});
  }

  @override
  void profileAppendValues(String key, List<String> values) {
    methodChannel
        .invokeMethod("profileAppendValues", {"key": key, "values": values});
  }

  @override
  void profileUnset(String name) {
    methodChannel.invokeMethod("profileUnset", {"property": name});
  }

  @override
  Future<String?> onEventTimerStart(String eventName) async {
    return await methodChannel
        .invokeMethod("onEventTimerStart", {"eventName": eventName});
  }

  @override
  void onEventTimerPause(String eventNameKey) {
    methodChannel
        .invokeMethod("onEventTimerPause", {"eventNameKey": eventNameKey});
  }

  @override
  void onEventTimerResume(String eventNameKey) {
    methodChannel
        .invokeMethod("onEventTimerResume", {"eventNameKey": eventNameKey});
  }

  @override
  void onEventTimerEnd(String eventNameKey) {
    methodChannel
        .invokeMethod("onEventTimerEnd", {"eventNameKey": eventNameKey});
  }

  @override
  void removeTimer(String eventNameKey) {
    methodChannel.invokeMethod("removeTimer", {"eventNameKey": eventNameKey});
  }

  @override
  Future<String?> getPeripheralProperty() async {
    return await methodChannel.invokeMethod("getPeripheralProperty", {});
  }

  @override
  void setPermissionsAll(bool isGranted) {
    methodChannel.invokeMethod("setPermissionsAll", {"isGranted": isGranted});
  }

  @override
  void setPermissionsLocation(bool isGranted) {
    methodChannel
        .invokeMethod("setPermissionsLocation", {"isGranted": isGranted});
  }

  @override
  void setPermissionsMac(bool isGranted) {
    methodChannel.invokeMethod("setPermissionsMac", {"isGranted": isGranted});
  }
}
