package cn.cutemc.pomotimer.pomotimer.controllers

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import cn.cutemc.pomotimer.pomotimer.MainActivity
import cn.cutemc.pomotimer.pomotimer.R
import cn.cutemc.pomotimer.pomotimer.alarm.Alarm
import kotlin.math.roundToInt


object NotificationsController {

    private val channelId by lazy {
        MainActivity.appContext.resources.getString(R.string.notification_channel_id)
    }

    private val channelName by lazy {
        MainActivity.appContext.resources.getString(R.string.notification_channel_name)
    }

    private val channelDescription by lazy {
        MainActivity.appContext.resources.getString(R.string.notification_channel_description)
    }

    private val notification: MutableMap<Int, Alarm> = mutableMapOf()


    fun postAlarmNotification(alarm: Alarm, context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU && !checkPermission(context)) {
            return
        }

        val intent = Intent(context, MainActivity::class.java)

        val pendingIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_IMMUTABLE)

        val notificationBuild = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(R.drawable.ic_notification_icon)
            .setContentTitle(alarm.notificationTitle)
            .setContentText(alarm.notificationContent)
            .setPriority(NotificationCompat.PRIORITY_MAX)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .setCategory(NotificationCompat.CATEGORY_ALARM)

        NotificationManagerCompat.from(context).notify(randomNotificationId(), notificationBuild.build())
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun createNotificationChannel(context: Context): NotificationChannel {
        val channel = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_HIGH)

        val notificationManager = context.getSystemService(NotificationManager::class.java)

        notificationManager.createNotificationChannel(channel)

        return channel
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    private fun checkPermission(context: Context): Boolean {
        val permission = ActivityCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS)
        return permission == PackageManager.PERMISSION_GRANTED
    }

    private fun randomNotificationId(): Int {
        var result: Int? = null
        while (result == null) {
            val random = (Math.random() * 100000).roundToInt()
            if (!notification.containsKey(random)) {
                result = random
            }
        }
        return result
    }

    fun cancelNotification(id: Int, context: Context) {
        val notificationManager = context.getSystemService(NotificationManager::class.java)
        notificationManager.cancel(id)
        notification.remove(id)
    }

    fun cancelNotifications(alarm: Alarm, context: Context) {
        notification.filterValues { it.id == alarm.id }.forEach { (id, _) ->
            cancelNotification(id, context)
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun requestHeadsUpPermission(context: Context) {
        val settingsIntent: Intent = Intent(Settings.ACTION_CHANNEL_NOTIFICATION_SETTINGS)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            .putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName)
            .putExtra(Settings.EXTRA_CHANNEL_ID, channelId)
        context.startActivity(settingsIntent)
    }
}