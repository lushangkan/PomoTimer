package cn.cutemc.pomotimer.pomotimer.channel

import android.content.Context
import android.os.Build
import androidx.lifecycle.Lifecycle
import cn.cutemc.pomotimer.pomotimer.MainActivity
import cn.cutemc.pomotimer.pomotimer.R
import cn.cutemc.pomotimer.pomotimer.alarm.Alarm
import cn.cutemc.pomotimer.pomotimer.alarm.AppAlarmManager
import cn.cutemc.pomotimer.pomotimer.controllers.NotificationsController
import cn.cutemc.pomotimer.pomotimer.langs.Texts
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withTimeoutOrNull
import kotlin.coroutines.resume

object NativeMethodChannel : MethodChannel.MethodCallHandler {
    lateinit var methodChannel: MethodChannel
        private set

    fun configureChannel(flutterEngine: FlutterEngine, context: Context) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, context.resources.getString(R.string.channel_id))
        methodChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val methodName = call.method
        val args = call.arguments

        when (methodName) {
            Methods.RELOAD_LOCALE -> {
                Texts.reload()
                result.success(null)
                return
            }

            Methods.REGISTER_ALARM -> {
                if (args !is String) {
                    result.error("INVALID_ARGUMENT", "Arguments must be a string", null)
                }

                val alarm = Alarm.fromJson(args as String)
                AppAlarmManager.addAlarm(alarm, MainActivity.appContext)
                // TODO: 添加重复ID检查
                result.success(null)
                return
            }

            Methods.UNREGISTER_ALARM -> {
                if (args !is Int) {
                    result.error("INVALID_ARGUMENT", "Arguments must be a int", null)
                }
                val id = args as Int
                AppAlarmManager.deleteAlarm(id, MainActivity.appContext)
                result.success(null)
                return
            }

            Methods.UNREGISTER_ALL_ALARMS -> {
                AppAlarmManager.deleteAllAlarms(MainActivity.appContext)
                result.success(null)
                return
            }

            Methods.STOP_ALARM -> {
                if (args !is Int) {
                    result.error("INVALID_ARGUMENT", "Arguments must be a int", null)
                }
                val id = args as Int
                AppAlarmManager.stopAlarm(id)
                result.success(null)
                return
            }

            Methods.REQUEST_HEADS_UP_PERMISSION -> {
                if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
                    result.error("UNSUPPORTED_PLATFORM", "This method is only supported on Android Oreo and above", null)
                    return
                }

                NotificationsController.requestHeadsUpPermission(MainActivity.appContext)

                runBlocking {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        withTimeoutOrNull(Long.MAX_VALUE) {
                            while (!MainActivity.instance.lifecycle.currentState.isAtLeast(Lifecycle.State.RESUMED)) {
                                delay(1000)
                            }
                        }
                    }

                    result.success(null)
                }

                return
            }

        }
        result.notImplemented()
    }

    private suspend fun invokeMethod(method: String, arguments: Any?): Any? {
        return suspendCancellableCoroutine { cont ->
            val resultHandle = object : MethodChannel.Result {
                override fun success(result: Any?) {
                    if (cont.isActive) {
                        cont.resume(result)
                    }
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    if (cont.isActive) {
                        cont.resume(null)
                    }
                }

                override fun notImplemented() {
                    if (cont.isActive) {
                        cont.resume(null)
                    }
                }
            }

            methodChannel.invokeMethod(method, arguments, resultHandle)
        }
    }

    suspend fun getNotificationStopButtonText(): String {
        return (invokeMethod(Methods.GET_NOTIFICATION_STOP_BUTTON_TEXT, null) ?: throw IllegalArgumentException("Action button text is null")) as String
    }

    suspend fun clickNotificationCallback(alarmJson: String) {
        invokeMethod(Methods.CLICK_NOTIFICATION_CALLBACK, alarmJson)
    }

    suspend fun alarmCallBack(alarmJson: String) {
        invokeMethod(Methods.ALARM_CALLBACK, alarmJson)
    }

    suspend fun getLocalAppName(): String {
        return (invokeMethod(Methods.GET_LOCAL_APP_NAME, null) ?: throw IllegalArgumentException("App name is null")) as String
    }

    suspend fun getForegroundNotificationDescription(): String {
        return (invokeMethod(Methods.GET_FOREGROUND_NOTIFICATION_DESCRIPTION, null) ?: throw IllegalArgumentException("Foreground notification description is null")) as String
    }

}