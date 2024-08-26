package cn.cutemc.pomotimer.pomotimer

import android.content.Context
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.MotionEvent
import cn.cutemc.pomotimer.pomotimer.channel.NativeMethodChannel
import cn.cutemc.pomotimer.pomotimer.controllers.NotificationsController
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    companion object {
        lateinit var appContext: Context
        lateinit var instance: MainActivity
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        appContext = context.applicationContext
        instance = this

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationsController.createNotificationChannel(context)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // 初始化方法通道
        NativeMethodChannel.configureChannel(flutterEngine, context)
    }

}


