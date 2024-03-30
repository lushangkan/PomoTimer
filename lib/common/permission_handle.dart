import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pomotimer/common/platform_utils.dart';

import '../widgets/button_dialog_inner.dart';

final PermissionHandle permissionHandle = PermissionHandle();

class PermissionHandle {

  /// 权限列表
  static final List<Permission> permissionList = [
    Permission.storage, // 仅Android13以下
    Permission.audio, // 仅Android13以上
    Permission.accessMediaLocation,
    Permission.ignoreBatteryOptimizations,
    Permission.notification,
    Permission.scheduleExactAlarm,
    Permission.accessNotificationPolicy,
  ];

  /// 计时权限列表
  static final List<Permission> timerPermissionList = [
    Permission.ignoreBatteryOptimizations,
    Permission.notification,
    Permission.scheduleExactAlarm,
    Permission.accessNotificationPolicy,
  ];

  /// 存储权限列表
  static final List<Permission> storagePermissionList = [
    Permission.storage, // 仅Android13以下
    Permission.audio, // 仅Android13以上
    Permission.accessMediaLocation,
  ];

  /// 权限状态
  final Map<Permission, PermissionStatus?> _permissionStatus = permissionList.asMap().map((key, value) => MapEntry(value, null));

  /// 获取权限状态
  Future<void> checkAllPermissionStatus() async {
    for (var permission in permissionList) {
      if (permission == Permission.storage && await _isAndroid13Plus) {
        continue;
      } else if (permission == Permission.audio && !(await _isAndroid13Plus)) {
        continue;
      }
      var status = await permission.status;
      _permissionStatus.update(permission, (value) => status);
    }
  }

  /// 请求计时权限
  Future<bool> requestTimerPermission(BuildContext context) async {
    for (var permission in timerPermissionList) {
      var status = await permission.status;
      if (status.isGranted) {
        // 已经授权
        continue;
      }
      // 未授权
      // 弹出用户指南
      if (permission == Permission.ignoreBatteryOptimizations) {
        // 弹出权限设置指南，因为一些第三方UI请求该权限后需要用户手动选择
        if (!context.mounted) return false;
        if (!await _requestBatteryOptimizationsPermission(context)) {
          return false;
        }
      } else if (permission == Permission.accessNotificationPolicy) {
        // 弹出权限设置指南，因为AOSP请求该权限后会跳的应用列表需要用户找到应用并启动
        if (!context.mounted) return false;
        if (!await _requestNotificationPolicyPermission(context)) {
          return false;
        }
      }
      // 请求权限
      var newStatus = await permission.request();
      if (newStatus.isGranted) {
        _permissionStatus.update(permission, (value) => newStatus);
        continue;
      }
      return false;
    }
    return true;
  }

  /// 请求存储权限
  Future<bool> requestStoragePermission() async {
    for (var permission in storagePermissionList) {
      if (permission == Permission.storage && await _isAndroid13Plus) {
        continue;
      } else if (permission == Permission.audio && !(await _isAndroid13Plus)) {
        continue;
      }
      var status = await permission.status;
      if (status.isGranted) {
        continue;
      }
      var newStatus = await permission.request();
      if (newStatus.isGranted) {
        _permissionStatus.update(permission, (value) => newStatus);
        continue;
      }
      return false;
    }
    return true;
  }

  /// 计时需要的权限是否已授权
  bool get isTimerPermissionGranted {
    for (var permission in timerPermissionList) {
      if (_permissionStatus[permission] != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  /// 存储需要的权限是否已授权
  bool get isStoragePermissionGranted {
    for (var permission in storagePermissionList) {
      if (_permissionStatus[permission] != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> get _isAndroid13Plus async {
    return getPlatformType() == PlatformType.android && await getAndroidSDKVersion() >= 33;
  }

  Future<bool> _requestBatteryOptimizationsPermission(BuildContext context) async {
    var colorScheme = Theme.of(context).colorScheme;

    return await showBarModalBottomSheet(
        duration: const Duration(milliseconds: 200),
        barrierColor: Colors.black54,
        context: context,
        backgroundColor: colorScheme.background,
        builder: (context) {
          return const ButtonDialogInner(title: '需要权限', content: '计时器需要持续在后台运行, 以便及时提醒您。\n可能会弹出权限设置页面, 若弹出, 请将该应用设置为“无限制”或允许应用在后台运行。', selectMode: false,);
        }
    ) ?? false;
  }

  Future<bool> _requestNotificationPolicyPermission(BuildContext context) async {
    var colorScheme = Theme.of(context).colorScheme;

    return await showBarModalBottomSheet(
        duration: const Duration(milliseconds: 200),
        barrierColor: Colors.black54,
        context: context,
        backgroundColor: colorScheme.background,
        builder: (context) {
          return const ButtonDialogInner(title: '需要权限', content: '计时器需要在到达一个阶段后弹出窗口提醒, 以便及时提醒您。\n可能会弹出权限设置页面, 若弹出, 请将该应用设置为“允许‘勿扰’模式”。', selectMode: false,);
        }
    ) ?? false;
  }
}