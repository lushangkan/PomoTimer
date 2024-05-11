package cn.cutemc.pomotimer.pomotimer.utils

import android.content.Context
import java.io.File


fun getFileFromAssets(context: Context, filePath: String): File {
    val cacheName = filePath.split("/").last()

    val file = File(context.cacheDir, cacheName)

    if (file.exists()) {
        file.delete()
    }

    val am = context.assets
    val stream = am.open(filePath)

    file.writeBytes(stream.readBytes())

    stream.close()

    return file
}
