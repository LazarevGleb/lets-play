package com.dag.lets_play.utils

import com.fasterxml.jackson.core.JsonProcessingException
import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import jakarta.persistence.AttributeConverter
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.io.IOException


class MapConverter : AttributeConverter<Map<String, Any>, String> {

    private val logger: Logger = LoggerFactory.getLogger(MapConverter::class.java)

    private val objectMapper = ObjectMapper()

    override fun convertToDatabaseColumn(attribute: Map<String, Any>?): String? {
        return try {
            objectMapper.writeValueAsString(attribute)
        } catch (e: JsonProcessingException) {
            logger.error("JSON writing error", e)
            null
        }
    }

    override fun convertToEntityAttribute(dbData: String?): Map<String, Any>? {
        return try {
            objectMapper.readValue(dbData, object : TypeReference<Map<String, Any>>() {})
        } catch (e: IOException) {
            logger.error("JSON reading error", e)
            null
        }
    }
}
