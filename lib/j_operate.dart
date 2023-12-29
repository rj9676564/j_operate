
import 'j_operate_platform_interface.dart';

class JOperate {
  Future<String?> getPlatformVersion() {
    return JOperatePlatform.instance.getPlatformVersion();
  }
  void setup(String key) {
     JOperatePlatform.instance.setup(key);
  }

  void setDebug(bool isDebug) {
    JOperatePlatform.instance.setDebug(isDebug);
  }

  void login(Map params) {
    JOperatePlatform.instance.login(params);
  }

  void setChannel(Map params) {
    JOperatePlatform.instance.setChannel(params);
  }

  void onEvent(String key, Map params) {
    JOperatePlatform.instance.onEvent(key, params);
  }

  Future<String?> getCuid() async {
    final cuid = await JOperatePlatform.instance.getCuid();
    return cuid;
  }

  void registerSuperProperties(Map params) {
    JOperatePlatform.instance.registerSuperProperties(params);
  }

  void clearSuperProperties(String? key) {
    JOperatePlatform.instance.clearSuperProperties(key );
  }

  void setUtmProperties(Map params) {
    JOperatePlatform.instance.setUtmProperties(params);
  }

  void profileSet(String key, String value) {
    JOperatePlatform.instance.profileSet(key, value);
  }

  void profileSetValues(String key,String value) {
    JOperatePlatform.instance.profileSetValues(key, value);
  }

  void profileSetOnceValues(String key,List<String> values) {
    JOperatePlatform.instance.profileSetOnceValues(key, values);
  }

  void profileSetOnce(String key, String value) {
    JOperatePlatform.instance.profileSetOnce(key, value);
  }

  void profileIncrement(Map<String,int> params) {
    JOperatePlatform.instance.profileIncrement(params);
  }

  void profileAppend(String key, String values) {
    JOperatePlatform.instance.profileAppend(key, values);
  }

  void profileAppendValues(String key, List<String> values) {
    JOperatePlatform.instance.profileAppendValues(key, values);
  }

  void profileUnset(String name) {
    JOperatePlatform.instance.profileUnset(name);
  }

  Future<String?> onEventTimerStart(String eventName) async {
    return JOperatePlatform.instance.onEventTimerStart(eventName);
  }

  void onEventTimerPause(String eventNameKey) {
    JOperatePlatform.instance.onEventTimerPause(eventNameKey);
  }

  void onEventTimerResume(String eventNameKey) {
    JOperatePlatform.instance.onEventTimerResume(eventNameKey);
  }

  void onEventTimerEnd(String eventNameKey) {
    JOperatePlatform.instance.onEventTimerEnd(eventNameKey);
  }

  void removeTimer(String eventNameKey) {
    JOperatePlatform.instance.removeTimer(eventNameKey);
  }

  Future<String?> getPeripheralProperty() async{
    return JOperatePlatform.instance.getPeripheralProperty();
  }

  void setPermissionsAll(bool isGranted) {
    JOperatePlatform.instance.setPermissionsAll(isGranted);
  }

  void setPermissionsLocation(bool isGranted) {
    JOperatePlatform.instance.setPermissionsLocation(isGranted);
  }

  void setPermissionsMac(bool isGranted) {
    JOperatePlatform.instance.setPermissionsMac(isGranted);
  }
}
