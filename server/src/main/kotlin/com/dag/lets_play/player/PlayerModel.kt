package com.dag.lets_play.player

import com.dag.lets_play.validation.ValidPhone
import java.time.LocalDate

data class Player(
    val id: Long,
    val name: String,
    val phone: String,
    val nickname: String,
    val age: Int,
    val birthDate: LocalDate,
    val rank: Double?,
    val primaryPosition: Position,
    val secondaryPosition: Position?,
    val avatar: String?
)

data class CreatePlayerRequest(
    val name: String,
    @field:ValidPhone
    val phone: String,
    val nickname: String,
    val birthDate: LocalDate,
    val rank: Double?,
    val primaryPosition: Position,
    val secondaryPosition: Position?,
    val avatar: String?
)

enum class Position {
    FORWARD,
    HALFBACK,
    DEFENDER,
    GOALKEEPER,
}
