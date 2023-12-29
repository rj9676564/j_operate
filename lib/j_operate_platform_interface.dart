import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'j_operate_method_channel.dart';

abstract class JOperatePlatform extends PlatformInterface {
  /// Constructs a JOperatePlatform.
  JOperatePlatform() : super(token: _token);

  static final Object _token = Object();

  static JOperatePlatform _instance = MethodChannelJOperate();

  /// The default instance of [JOperatePlatform] to use.
  ///
  /// Defaults to [MethodChannelJOperate].
  static JOperatePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JOperatePlatform] when
  /// they register themselves.
  static set instance(JOperatePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void setup(String key) {
    throw UnimplementedError('setup() has not been implemented.');
  }

  void setDebug(bool debug) {
    throw UnimplementedError('setDebug() has not been implemented.');
  }

  void login(Map params) {
    throw UnimplementedError('login() has not been implemented.');
  }

  void setChannel(Map params) {
    throw UnimplementedError('setChannel() has not been implemented.');
  }

  void onEvent(String key, Map params) {
    throw UnimplementedError('onEvent() has not been implemented.');
  }

  Future<String?> getCuid() async {
    throw UnimplementedError('getCuid() has not been implemented.');
  }

  void registerSuperProperties(Map params) {
    throw UnimplementedError('registerSuperProperties() has not been implemented.');
  }

  void clearSuperProperties(String? key) {
    throw UnimplementedError('clearSuperProperties() has not been implemented.');
  }

  void setUtmProperties(Map params) {
    throw UnimplementedError('setUtmProperties() has not been implemented.');
  }

  void profileSet(String key, String value) {
    throw UnimplementedError('profileSet() has not been implemented.');
  }

  void profileSetValues(String key,String value) {
    throw UnimplementedError('profileSetValues() has not been implemented.');
  }

  void profileSetOnceValues(String key,List<String> values) {
    throw UnimplementedError('profileSetOnceValues() has not been implemented.');
  }

  void profileSetOnce(String key, String value) {
    throw UnimplementedError('profileSetOnce() has not been implemented.');
  }

  void profileIncrement(Map<String,int> params) {
    throw UnimplementedError('profileIncrement() has not been implemented.');
  }

  void profileAppend(String key, String values) {
    throw UnimplementedError('profileAppend() has not been implemented.');
  }

  void profileAppendValues(String key, List<String> values) {
    throw UnimplementedError('profileAppendValues() has not been implemented.');
  }

  void profileUnset(String name) {
    throw UnimplementedError('profileUnset() has not been implemented.');
  }

  Future<String?> onEventTimerStart(String eventName) async {
    throw UnimplementedError('onEventTimerStart() has not been implemented.');
  }

  void onEventTimerPause(String eventNameKey) {
    throw UnimplementedError('onEventTimerPause() has not been implemented.');
  }

  void onEventTimerResume(String eventNameKey) {
    throw UnimplementedError('onEventTimerResume() has not been implemented.');
  }

  void onEventTimerEnd(String eventNameKey) {
    throw UnimplementedError('onEventTimerEnd() has not been implemented.');
  }

  void removeTimer(String eventNameKey) {
    throw UnimplementedError('removeTimer() has not been implemented.');
  }

  Future<String?> getPeripheralProperty() async{
    throw UnimplementedError('getPeripheralProperty() has not been implemented.');
  }

  void setPermissionsAll(bool isGranted) {
    throw UnimplementedError('setPermissionsAll() has not been implemented.');
  }

  void setPermissionsLocation(bool isGranted) {
    throw UnimplementedError('setPermissionsLocation() has not been implemented.');
  }

  void setPermissionsMac(bool isGranted) {
    throw UnimplementedError('setPermissionsMac() has not been implemented.');
  }

}
