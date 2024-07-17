package cn.cutemc.pomotimer.pomotimer.alarm

import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@Serializable
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
            return Json.decodeFromString<Alarm>(json)
        }
    }

    fun toJson(): String {
        return Json.encodeToString(this)
    }
}
