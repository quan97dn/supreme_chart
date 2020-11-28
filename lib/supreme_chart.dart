
import 'dart:async';

import 'package:flutter/services.dart';

class SupremeChart {
  static const MethodChannel _channel =
      const MethodChannel('supreme_chart');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
