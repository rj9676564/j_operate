import 'package:flutter_test/flutter_test.dart';
import 'package:j_operate/j_operate.dart';
import 'package:j_operate/j_operate_platform_interface.dart';
import 'package:j_operate/j_operate_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockJOperatePlatform
    with MockPlatformInterfaceMixin
    implements JOperatePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final JOperatePlatform initialPlatform = JOperatePlatform.instance;

  test('$MethodChannelJOperate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelJOperate>());
  });

  test('getPlatformVersion', () async {
    JOperate jOperatePlugin = JOperate();
    MockJOperatePlatform fakePlatform = MockJOperatePlatform();
    JOperatePlatform.instance = fakePlatform;

    expect(await jOperatePlugin.getPlatformVersion(), '42');
  });
}
