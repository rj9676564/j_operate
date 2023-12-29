import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_operate/j_operate_method_channel.dart';

void main() {
  MethodChannelJOperate platform = MethodChannelJOperate();
  const MethodChannel channel = MethodChannel('j_operate');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
