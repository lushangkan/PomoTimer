import 'package:permission_handler/permission_handler.dart';
import 'package:pomotimer/common/platform_utils.dart';
import 'package:quiver/collection.dart';


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
  final Multimap<Permission, PermissionStatus?> _permissionStatus = Multimap();

  /// 获取权限状态
  void checkAllPermissionStatus() async {
    for (var permission in permissionList) {
      if (permission == Permission.storage && await _isAndroid13Plus) {
        continue;
      } else if (permission == Permission.audio && !(await _isAndroid13Plus)) {
        continue;
      }
      var status = await permission.status;
      _permissionStatus.add(permission, status);
    }
  }

  /// 请求计时权限
  Future<bool> requestTimerPermission() async {
    for (var permission in timerPermissionList) {
      var status = await permission.status;
      if (status.isGranted) {
        continue;
      }
      var newStatus = await permission.request();
      if (newStatus.isGranted) {
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
        continue;
      }
      return false;
    }
    return true;
  }

  Future<bool> get _isAndroid13Plus async {
    return getPlatformType() == PlatformType.android && await getAndroidSDKVersion() >= 33;
  }
}