package com.dag.lets_play.player

import com.dag.lets_play.position.Position
import java.util.*

data class Player(
    val name: String,
    val phone: String,
    val nickname: String,
    val age: Int,
    val birthDate: Date,
    val rank: Float?,
    val primaryPosition: Position,
    val secondaryPosition: Position?,
    val avatar: String?
)
