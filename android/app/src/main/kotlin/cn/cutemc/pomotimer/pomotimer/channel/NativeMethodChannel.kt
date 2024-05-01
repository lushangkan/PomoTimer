package cn.cutemc.pomotimer.pomotimer.channel

import android.content.Context
import cn.cutemc.pomotimer.pomotimer.MainActivity
import cn.cutemc.pomotimer.pomotimer.R
import cn.cutemc.pomotimer.pomotimer.alarm.Alarm
import cn.cutemc.pomotimer.pomotimer.alarm.AppAlarmManager
import cn.cutemc.pomotimer.pomotimer.langs.Texts
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.suspendCancellableCoroutine
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

        }
        result.notImplemented()
    }

    suspend fun invokeMethod(method: String, arguments: Any?): Any? {
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
}