package com.dag.lets_play.player

import java.util.Date

data class Player(
    val id: Long,
    val name: String,
    val phone: String,
    val nickname: String,
    val age: Int,
    val birthDate: Date,
    val rank: Float?,
    val primaryPosition: Int,
    val secondaryPosition: Int?,
    val avatar: String?
)
