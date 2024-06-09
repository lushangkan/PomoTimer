package cn.cutemc.pomotimer.pomotimer.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import cn.cutemc.pomotimer.pomotimer.channel.Methods
import cn.cutemc.pomotimer.pomotimer.channel.NativeMethodChannel
import cn.cutemc.pomotimer.pomotimer.controllers.NotificationsController
import cn.cutemc.pomotimer.pomotimer.controllers.RingtoneController
import cn.cutemc.pomotimer.pomotimer.controllers.VibratorController
import java.util.*

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent == null) {
            return
        }

        val alarmJson = intent.getStringExtra("alarm") ?: return

        val alarm = Alarm.fromJson(alarmJson)

        NativeMethodChannel.methodChannel.invokeMethod(Methods.ALARM_CALLBACK, alarm.toJson())

        if (alarm.audioPath != null) {
            RingtoneController.play(alarm, context)
        }

        if (alarm.vibrate) {
            VibratorController.start(alarm, context)
        }

        NotificationsController.postAlarmNotification(alarm, context)
    }
}