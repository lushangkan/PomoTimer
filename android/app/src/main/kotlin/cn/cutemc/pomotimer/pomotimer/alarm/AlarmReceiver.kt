package cn.cutemc.pomotimer.pomotimer.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import cn.cutemc.pomotimer.pomotimer.channel.Methods
import cn.cutemc.pomotimer.pomotimer.channel.NativeMethodChannel
import cn.cutemc.pomotimer.pomotimer.controllers.NotificationsController
import cn.cutemc.pomotimer.pomotimer.controllers.RingtoneController
import cn.cutemc.pomotimer.pomotimer.controllers.VibratorController
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import java.util.*

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent == null) {
            return
        }

        val alarmJson = intent.getStringExtra("alarm") ?: return

        val alarm = Alarm.fromJson(alarmJson)

        MainScope().launch {
            NativeMethodChannel.alarmCallBack(alarm.toJson())
        }

        if (alarm.audioPath != null && alarm.isAlarm) {
            RingtoneController.play(alarm, context)
        }

        if (alarm.vibrate) {
            VibratorController.start(alarm, context)
        }

        if (alarm.notification) { // 这行不用,因为如果通知都没有就不会注册闹钟
            NotificationsController.postAlarmNotification(alarm, context)
        }
    }
}