package cn.cutemc.pomotimer.pomotimer.controllers

import android.content.Context
import android.media.AudioAttributes
import android.os.*
import androidx.annotation.RequiresApi
import cn.cutemc.pomotimer.pomotimer.alarm.Alarm

object VibratorController {

    private val vibrators: MutableMap<Int, Vibrator> = mutableMapOf()

    fun start(alarm: Alarm, context: Context) {
        val vibrator = getVibrator(context)

        vibrators[alarm.id] = vibrator

        if (Build.VERSION.SDK_INT in 21..25) {
            vibrator.vibrate(longArrayOf((2 * 1000), (1 * 1000)), 0, getAudioAttributes())
        } else if (Build.VERSION.SDK_INT in 26..32) {
            vibrator.vibrate(getWaveform(), getAudioAttributes())
        } else if (Build.VERSION.SDK_INT >= 33) {
            vibrator.vibrate(getWaveform(), getVibrationAttributes())
        }
    }

    private fun getVibrator(context: Context): Vibrator {
        val vibrator: Vibrator;

        if (Build.VERSION.SDK_INT >= 31) {
            val vibratorManager = context.getSystemService(VibratorManager::class.java)
            vibrator = vibratorManager.defaultVibrator
        } else {
            vibrator = context.getSystemService(Vibrator::class.java)
        }

        return vibrator
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun getWaveform(): VibrationEffect {
        return VibrationEffect.createWaveform(
            longArrayOf((2 * 1000), (1 * 1000)),
            intArrayOf(VibrationEffect.DEFAULT_AMPLITUDE, 0), 0
        )
    }

    private fun getAudioAttributes(): AudioAttributes {
        return AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_ALARM)
            .build()
    }

    @RequiresApi(Build.VERSION_CODES.R)
    private fun getVibrationAttributes(): VibrationAttributes {
        return VibrationAttributes.Builder()
            .setUsage(VibrationAttributes.USAGE_ALARM)
            .build();
    }

    fun stop(id: Int) {
        if (!vibrators.containsKey(id)) throw IllegalArgumentException("Vibrator with id $id not found")

        val vibrator = vibrators[id]!!

        vibrator.cancel()
    }

    fun stop(alarm: Alarm) {
        stop(alarm.id)
    }
}