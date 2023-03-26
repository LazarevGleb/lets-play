package com.dag.lets_play.stadium

import com.fasterxml.jackson.annotation.JsonValue
import java.time.LocalDateTime

data class GetStadiumRequest(val location: Location, val distance: Double)

data class DeleteStadiumRequest(val location: Location)

data class Location(val latitude: Double, val longitude: Double)

data class Stadium(
    val id: Long,
    val address: String,
    val location: Location,
    val capacity: Capacity,
    val avatar: String?,
    val description: String?,
    val data: Map<String, Any>?,
    val createdAt: LocalDateTime?,
    val removedAt: LocalDateTime?
)

data class StadiumPreview(
    val id: Long, 
    val location: Location
)

enum class Capacity(@get:JsonValue val value: String) {
    FIVE("5x5"),
    SEVEN("7x7"),
    ELEVEN("11x11"),
    ;

    companion object {
        fun of(value: String): Capacity {
            return Capacity.values().find { it.value == value }
                ?: throw IllegalArgumentException("Unknown Capacity description: $value")
        }
    }
}
