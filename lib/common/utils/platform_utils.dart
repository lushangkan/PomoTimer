import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
/// 获取平台类型
/// @return PlatformType
PlatformType getPlatformType() {
  if (kIsWeb) {
    return PlatformType.web;
  } else if (Platform.isAndroid) {
    return PlatformType.android;
  } else if (Platform.isIOS) {
    return PlatformType.ios;
  } else if (Platform.isWindows) {
    return PlatformType.windows;
  } else if (Platform.isMacOS) {
    return PlatformType.macos;
  } else if (Platform.isLinux) {
    return PlatformType.linux;
  } else if (Platform.isFuchsia) {
    return PlatformType.fuchsia;
  } else {
    return PlatformType.unknown;
  }
}

/// 获取AndroidSDK版本
/// @return Future<int> SDK版本
Future<int> getAndroidSDKVersion() async {
  if (getPlatformType() != PlatformType.android) {
    return -1;
  }

  var androidInfo = await DeviceInfoPlugin().androidInfo;
  return androidInfo.version.sdkInt;
}

/// 获取iOS版本
/// @return Future<double> iOS版本
Future<double> getIOSVersion() async {
  if (getPlatformType() != PlatformType.ios) {
    return -1;
  }

  var iosInfo = await DeviceInfoPlugin().iosInfo;
  return double.parse(iosInfo.systemVersion);
}

Future<bool> isMiui() async {
  if (getPlatformType() != PlatformType.android) {
    return false;
  }

  var androidInfo = await DeviceInfoPlugin().androidInfo;
  return androidInfo.manufacturer.toLowerCase() == 'xiaomi';
}

enum PlatformType {
  android,
  ios,
  web,
  windows,
  macos,
  linux,
  fuchsia,
  unknown,
}