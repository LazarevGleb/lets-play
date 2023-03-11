package com.dag.lets_play.image

import com.dag.lets_play.stadium.StadiumService
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import java.io.ByteArrayOutputStream
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException
import java.util.Base64
import java.util.UUID


@Component
class ImageProcessor {

    fun loadImage(path: String): String {
        val inputStream = FileInputStream(path)
        val buffer = ByteArray(8192)
        var bytesRead: Int
        val output = ByteArrayOutputStream()

        try {
            while (inputStream.read(buffer).also { bytesRead = it } != -1) {
                output.write(buffer, 0, bytesRead)
            }
        } catch (e: IOException) {
            logger.error("Error during image '$path' loading: ${e.message}", e)
        }

        return encoder.encodeToString(output.toByteArray())
    }

    fun saveImage(base64Image: String): String {
        val data = base64Image.toByteArray()
        val imageName = UUID.randomUUID().toString()
        FileOutputStream(imageName).use { it.write(data) }
        return imageName;
    }

    companion object {
        private val logger = LoggerFactory.getLogger(StadiumService::class.java)
        private val encoder = Base64.getEncoder()
    }
}