package cn.cutemc.pomotimer.pomotimer.langs

import cn.cutemc.pomotimer.pomotimer.channel.Methods
import cn.cutemc.pomotimer.pomotimer.channel.NativeMethodChannel
import cn.cutemc.pomotimer.pomotimer.utils.resettableLazy
import cn.cutemc.pomotimer.pomotimer.utils.resettableManager
import kotlinx.coroutines.runBlocking

object Texts {
    private val lazyMgr = resettableManager()

    val appName: String by resettableLazy<String>(lazyMgr) {
         return@resettableLazy runBlocking {
             return@runBlocking (NativeMethodChannel.invokeMethod(Methods.GET_LOCAL_APP_NAME, null) as String?) ?: "PomoTimer"
        }
    }

    val foregroundNotificationDescription: String by resettableLazy(lazyMgr) {
        return@resettableLazy runBlocking {
            return@runBlocking (NativeMethodChannel.invokeMethod(Methods.GET_FOREGROUND_NOTIFICATION_DESCRIPTION, null) as String?) ?: ""
        }
    }

    fun reload() {
        lazyMgr.reset()
    }

}