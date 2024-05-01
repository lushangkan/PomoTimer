package cn.cutemc.pomotimer.pomotimer.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.Vibrator
import android.os.VibratorManager
import cn.cutemc.pomotimer.pomotimer.MainActivity
import cn.cutemc.pomotimer.pomotimer.controllers.NotificationsController
import cn.cutemc.pomotimer.pomotimer.controllers.RingtoneController
import cn.cutemc.pomotimer.pomotimer.controllers.VibratorController
import io.flutter.embedding.engine.loader.FlutterLoader
import java.util.*

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent == null) {
            return
        }

        val alarmJson = intent.getStringExtra("alarm") ?: return

        val alarm = Alarm.fromJson(alarmJson)

        if (alarm.audioPath != null) {
            RingtoneController.play(alarm, context)
        }

        if (alarm.vibrate) {
            VibratorController.start(alarm, context)
        }

        NotificationsController.postAlarmNotification(alarm, context)
    }
}