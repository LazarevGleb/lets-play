package com.dag.lets_play.player

import java.util.Date

data class Player(
    val id: Long,
    val name: String,
    val phone: String,
    val nickname: String,
    val age: Int,
    val birthDate: Date,
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
