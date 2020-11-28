import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supreme_chart/supreme_chart.dart';

void main() {
  const MethodChannel channel = MethodChannel('supreme_chart');

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
    expect(await SupremeChart.platformVersion, '42');
  });
}
