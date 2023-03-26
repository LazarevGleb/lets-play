package com.dag.lets_play.event

import com.dag.lets_play.stadium.Location
import com.dag.lets_play.stadium.Stadium
import java.time.LocalDateTime

data class GetStadiumWithEventsRequests(
    val stadiumId: Long,
    val ids: List<Long>
)

data class GetEventRequest(
    val location: Location,
    val distance: Double,
    val beginFrom: LocalDateTime,
    val beginTill: LocalDateTime,
    val age: Int?,
    val rank: Double?
)

data class CreateEventRequest(
    val stadiumId: Long,
    val beginAt: LocalDateTime,
    val minPlayers: Int?,
    val minAge: Int?,
    val maxAge: Int?,
    val minRank: Double?,
    val maxRank: Double?,
)

data class Event(
    val id: Long,
    val stadiumId: Long,
    val beginAt: LocalDateTime,
    val isFinished: Boolean,
    val isCancelled: Boolean,
    val currentPlayers: Int,
    val minPlayers: Int?,
    val minAge: Int?,
    val maxAge: Int?,
    val minRank: Double?,
    val maxRank: Double?,
    val createdAt: LocalDateTime
)

data class EventToStadium(
    val stadiumId: Long,
    val eventIds: List<Long>
)

data class StadiumWithEvents(
    val stadium: Stadium,
    val events: List<Event>
)
