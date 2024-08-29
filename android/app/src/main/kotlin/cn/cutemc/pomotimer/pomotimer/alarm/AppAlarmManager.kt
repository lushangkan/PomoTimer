package cn.cutemc.pomotimer.pomotimer.alarm

import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import cn.cutemc.pomotimer.pomotimer.MainActivity
import cn.cutemc.pomotimer.pomotimer.controllers.NotificationsController
import cn.cutemc.pomotimer.pomotimer.controllers.RingtoneController
import cn.cutemc.pomotimer.pomotimer.controllers.VibratorController
import io.flutter.Log
import java.time.Instant
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.util.Date
import java.util.concurrent.TimeUnit

object AppAlarmManager {
    private val alarms: MutableMap<PendingIntent, Alarm> = mutableMapOf()

    private fun getAlarmManager(context: Context): AlarmManager {
        return context.getSystemService(AlarmManager::class.java)
    }

    fun addAlarm(alarm: Alarm, context: Context) {
        val intent = Intent(context, AlarmReceiver::class.java).apply {
            putExtra("alarm", alarm.toJson())
        }

        val broadcast = PendingIntent.getBroadcast(context, alarm.id, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

        getAlarmManager(context).setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, alarm.timestamp, broadcast)

        Log.d("AppAlarmManager", "Alarm added: ${alarm.toJson()}")

        alarms[broadcast] = alarm
    }

    fun deleteAlarm(id: Int, context: Context) {
        alarms.filterValues { it.id == id }.forEach { (pendingIntent, _) ->
            getAlarmManager(context).cancel(pendingIntent)
            alarms.remove(pendingIntent)
            Log.d("AppAlarmManager", "Alarm deleted: $id")
        }
    }

    fun deleteAllAlarms(context: Context) {
        alarms.keys.forEach {
            getAlarmManager(context).cancel(it)
        }
        alarms.clear()
        Log.d("AppAlarmManager", "All alarms deleted")
    }

    fun stopAlarm(id: Int) {
        alarms.filterValues { it.id == id }.forEach { (pendingIntent, alarm) ->
            NotificationsController.cancelNotifications(alarm, MainActivity.appContext)
            RingtoneController.stop(alarm)
            VibratorController.stop(alarm)
            Log.d("AppAlarmManager", "Alarm stopped: $id")
        }
    }

    fun hasAlarm(id: Int): Boolean {
        return alarms.values.any { it.id == id }
    }
}
