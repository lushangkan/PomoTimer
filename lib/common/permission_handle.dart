import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pomotimer/common/channel/flutter_method_channel.dart';
import 'package:pomotimer/common/utils/platform_utils.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../states/app_states.dart';
import '../widgets/button_dialog_inner.dart';

class PermissionHandle {

  static final PermissionHandle instance = PermissionHandle();

  /// 权限列表
  static final List<Permission> permissionList = [
    Permission.storage, // 仅Android13以下
    Permission.audio, // 仅Android13以上
    Permission.ignoreBatteryOptimizations,
    Permission.notification,
    Permission.scheduleExactAlarm,
    Permission.accessNotificationPolicy,
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

  Future<bool> showPermissionDialog(BuildContext context,) async {
    var colorScheme = Theme.of(context).colorScheme;

    return await showBarModalBottomSheet(
        duration: const Duration(milliseconds: 200),
        barrierColor: Colors.black54,
        context: context,
        backgroundColor: colorScheme.surface,
        builder: (context) {
          return ButtonDialogInner(title: S.current.needPermission, content: S.current.needPermissionContent,);
        }
    ) ?? false;
  }

  Future<bool> showStoragePermissionDialog(BuildContext context,) async {
    var colorScheme = Theme.of(context).colorScheme;

    return await showBarModalBottomSheet(
        duration: const Duration(milliseconds: 200),
        barrierColor: Colors.black54,
        context: context,
        backgroundColor: colorScheme.surface,
        builder: (context) {
          return ButtonDialogInner(title: S.current.needStoragePermission, content: S.current.needStoragePermissionContent,);
        }
    ) ?? false;
  }

  /// 请求权限, 如果未授权, 会弹出权限请求对话框
  /// 如果已经请求过权限, 会直接返回true
  /// @param context 上下文
  /// @param askUser 是否询问用户
  /// @return 是否已授权
  Future<bool> requestPermission(BuildContext context, {bool askUser = true}) async {
    var appStates = context.read<AppStates>();

    // 检查权限
    if (askUser) {
      if (!PermissionHandle.instance.isPermissionGranted) {
        // 未授权
        var result = await showPermissionDialog(context);

        if (result != true) {
          return false;
        }
      }
    }

    for (var permission in permissionList) {
      var status = await permission.status;
      if (status.isGranted) {
        // 已经授权
        continue;
      }
      // 未授权
      // 判断安卓版本
      if (permission == Permission.storage && await _isAndroid13Plus) {
        continue;
      } else if (permission == Permission.audio && !(await _isAndroid13Plus)) {
        continue;
      }
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

        if (permission == Permission.notification && await getAndroidSDKVersion() >= 26 && await isMiui()) {
          // 弹出请求悬浮通知权限，由于miui将此默认关闭
          if (!context.mounted) return false;
          if (await _requestHeadsUpPermission(context)) {
            await FlutterMethodChannel.instance.requestHeadsUpPermission();
            // 等待用户回到应用
            if (appStates.appLifecycleState == AppLifecycleState.resumed) {
              while (appStates.appLifecycleState == AppLifecycleState.resumed) {
                await Future.delayed(const Duration(milliseconds: 100));
              }
            }
            if (appStates.appLifecycleState != AppLifecycleState.resumed) {
              while (appStates.appLifecycleState != AppLifecycleState.resumed) {
                await Future.delayed(const Duration(milliseconds: 100));
              }
            }
          }
        }

        continue;
      }
      return false;
    }
    return true;
  }

  Future<bool> requestStoragePermission(BuildContext context) async {
    // 检查是否已经授权
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    }

    // 弹出权限请求对话框
    if (!context.mounted) return false;
    var result = await showStoragePermissionDialog(context);

    if (result != true) {
      return false;
    }

    // 请求存储权限
    // 判断安卓版本
    PermissionStatus? newStatus;

    if (await _isAndroid13Plus) {
      newStatus = await Permission.audio.request();

      if (newStatus.isGranted) {
        _permissionStatus.update(Permission.audio, (value) => newStatus);

        return true;
      }
    } else if (!(await _isAndroid13Plus)) {
      newStatus = await Permission.storage.request();

      if (newStatus.isGranted) {
        _permissionStatus.update(Permission.storage, (value) => newStatus);

        return true;
      }
    }

    return false;
  }

  /// 计时需要的权限是否已授权
  bool get isPermissionGranted {
    for (var permission in permissionList) {
      if (_permissionStatus[permission] != PermissionStatus.granted && _permissionStatus[permission] != null) {
        return false;
      }
    }
    return true;
  }

  /// 读取文件的权限是否已授权
  Future<bool> get isStoragePermissionGranted async {
    if (await _isAndroid13Plus) {
      return _permissionStatus[Permission.audio] == PermissionStatus.granted;
    } else {
      return _permissionStatus[Permission.storage] == PermissionStatus.granted;
    }
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
        backgroundColor: colorScheme.surface,
        builder: (context) {
          return ButtonDialogInner(title: S.current.needBackgroundPermission, content: S.current.needBackgroundPermissionContent, selectMode: false,);
        }
    ) ?? false;
  }

  Future<bool> _requestHeadsUpPermission(BuildContext context) async {
    var colorScheme = Theme.of(context).colorScheme;

    return await showBarModalBottomSheet(
        duration: const Duration(milliseconds: 200),
        barrierColor: Colors.black54,
        context: context,
        backgroundColor: colorScheme.surface,
        builder: (context) {
          return ButtonDialogInner(title: S.current.needNotificationPermission, content: S.current.needNotificationPermissionContent, selectMode: false,);
        }
    ) ?? false;
  }

  Future<bool> _requestNotificationPolicyPermission(BuildContext context) async {
    var colorScheme = Theme.of(context).colorScheme;

    return await showBarModalBottomSheet(
        duration: const Duration(milliseconds: 200),
        barrierColor: Colors.black54,
        context: context,
        backgroundColor: colorScheme.surface,
        builder: (context) {
          return ButtonDialogInner(title: S.current.needPopoutPermission, content: S.current.needPopoutPermissionContent, selectMode: false,);
        }
    ) ?? false;
  }
}