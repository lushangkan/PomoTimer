package cn.cutemc.pomotimer.pomotimer.alarm

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper

data class Alarm(
    val id: Int,
    val timestamp: Long,
    val audioPath: String?,
    val fromAppAsset: Boolean?,
    val vibrate: Boolean,
    val loop: Boolean,
    val loopTimes: Int,
    val notificationTitle: String?,
    val notificationContent: String?,
) {
    companion object {
        fun fromJson(json: String): Alarm {
            val jackson = jacksonObjectMapper()

            return jackson.readValue(json, Alarm::class.java)
        }
    }

    fun toJson(): String {
        val jackson = jacksonObjectMapper()

        return jackson.writeValueAsString(this)
    }
}
