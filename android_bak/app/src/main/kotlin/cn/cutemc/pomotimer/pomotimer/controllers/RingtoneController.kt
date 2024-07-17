package cn.cutemc.pomotimer.pomotimer.controllers

import android.content.Context
import android.media.AudioAttributes
import android.media.MediaMetadataRetriever
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import cn.cutemc.pomotimer.pomotimer.alarm.Alarm
import cn.cutemc.pomotimer.pomotimer.alarm.AppAlarmManager
import cn.cutemc.pomotimer.pomotimer.utils.getFileFromAssets
import io.flutter.FlutterInjector
import java.io.File
import java.util.*


object RingtoneController {

    private val ringtones: MutableList<RingtoneData> = mutableListOf()

    private val timer = Timer()

    fun play(alarm: Alarm, context: Context) {
        val audioUri = getAudioPath(context, alarm) ?: throw IllegalArgumentException("Alarm audio path is null")

        val audioDuration = getRingtoneDuration(audioUri, context)

        val ringtone = getRingtone(alarm, context)

        val task = object : TimerTask() {

            var runtimes = 0
            var canceled = false

            override fun run() {
                if (canceled) {
                    return
                }
                if (!ringtone.isPlaying) {
                    if (runtimes >= alarm.loopTimes) {
                        AppAlarmManager.stopAlarm(alarm.id)
                        stop(alarm)
                        cancel()
                        return
                    }
                    runtimes++
                    ringtone.play()
                }
            }

            override fun cancel(): Boolean {
                canceled = true
                return super.cancel()
            }
        }

        timer.scheduleAtFixedRate(task, 0, audioDuration + 100)

        ringtones.add(RingtoneData(ringtone, alarm, task))
    }

    fun stop(id: Int) {
        val ringtoneData = ringtones.find { it.alarm.id == id } ?: return

        ringtoneData.ringtone.stop()
        ringtoneData.task?.cancel()

        ringtones.remove(ringtoneData)
    }

    fun stop(alarm: Alarm) {
        stop(alarm.id)
    }

    private fun getRingtone(alarm: Alarm, context: Context): Ringtone {
        val ringtone = RingtoneManager.getRingtone(context, getAudioPath(context, alarm))

        ringtone.audioAttributes = AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_ALARM)
            .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
            .build()

        return ringtone
    }

    private fun getAudioPath(context: Context, alarm: Alarm): Uri? {
        val path = if (alarm.fromAppAsset == true) {
            // 铃声来自应用资源
            if (alarm.audioPath == null) {
                throw IllegalArgumentException("Alarm audio path is null")
            }

            val loader = FlutterInjector.instance().flutterLoader()
            val flutterAssetPath = loader.getLookupKeyForAsset(alarm.audioPath)

            flutterAssetPath
        } else {
            // 铃声来自系统文件
            alarm.audioPath
        } ?: return null

        return if (alarm.fromAppAsset == true) {
            Uri.fromFile(getFileFromAssets(context, path))
        } else {
            Uri.fromFile(File(path))
        }
    }

    private fun getRingtoneDuration(uri: Uri, context: Context): Long {
        val mmr = MediaMetadataRetriever()
        mmr.setDataSource(context, uri)
        val durationStr = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION) ?: return -1
        return durationStr.toLong()
    }

}

data class RingtoneData(
    val ringtone: Ringtone,
    val alarm: Alarm,
    val task: TimerTask?
)
