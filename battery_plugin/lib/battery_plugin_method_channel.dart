import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_plugin_platform_interface.dart';

/// An implementation of [BatteryPluginPlatform] that uses method channels.
class MethodChannelBatteryPlugin extends BatteryPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('battery_plugin');
  final eventChannel = const EventChannel('chat_gpt/battery');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void getBatteryLevel() {
    try {
      eventChannel.receiveBroadcastStream().listen((event) {});
    } on PlatformException catch (e){
      print("Failed to get battery level: '${e.message}'.");
    }
  }
}
