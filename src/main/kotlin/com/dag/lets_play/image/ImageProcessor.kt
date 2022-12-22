package com.dag.lets_play.image

import com.dag.lets_play.stadium.StadiumService
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import java.io.*
import java.util.*


@Component
class ImageProcessor {

    fun loadImage(path: String): String {
        val inputStream: InputStream = FileInputStream(path)
        val buffer = ByteArray(8192)
        var bytesRead: Int
        val output = ByteArrayOutputStream()

        try {
            while (inputStream.read(buffer).also { bytesRead = it } != -1) {
                output.write(buffer, 0, bytesRead)
            }
        } catch (e: IOException) {
            logger.error(e.message, e)
        }

        return Base64.getEncoder().encodeToString(output.toByteArray())
    }

    fun saveImage(base64Image: String): String {
        val data: ByteArray = base64Image.toByteArray()
        val imageName = UUID.randomUUID().toString()
        FileOutputStream(imageName).use { stream -> stream.write(data) }
        return imageName;
    }

    companion object {
        private val logger = LoggerFactory.getLogger(StadiumService::class.java)
    }
}