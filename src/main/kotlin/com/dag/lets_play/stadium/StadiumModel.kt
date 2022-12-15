package com.dag.lets_play.stadium

import com.fasterxml.jackson.annotation.JsonValue

data class GetStadiumRequest(val location: Location, val distance: Double)

data class Location(val latitude: Double, val longitude: Double)

data class Stadium(
    val address: String,
    val location: Location,
    val capacity: Capacity,
    val description: String?,
    val data: Map<String, Any>?
)

enum class Capacity(@JsonValue private val desc: String) {
    FIVE("5x5"),
    SEVEN("7x7"),
    ELEVEN("11x11"),
    ;

    companion object {
        fun ofDescription(desc: String): Capacity {
            return Capacity.values().find { it.desc == desc }
                ?: throw IllegalArgumentException("Unknown Capacity description: $desc")
        }
    }
}
