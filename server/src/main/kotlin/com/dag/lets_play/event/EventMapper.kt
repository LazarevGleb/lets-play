package com.dag.lets_play.event

import com.dag.lets_play.player.Player
import com.dag.lets_play.utils.BaseMapper
import org.springframework.stereotype.Component

@Component
class EventMapper : BaseMapper() {
    fun toEntity(event: Event, _id: Long? = null): EventEntity {
        return EventEntity().apply {
            id = _id
            stadiumId = event.stadiumId
            beginAt = event.beginAt
            isFinished = event.isFinished
            isCancelled = event.isCancelled
            minPlayers = event.minPlayers
            minAge = event.minAge
            maxAge = event.maxAge
            minRank = event.minRank
            maxRank = event.maxRank
            createdAt = event.createdAt
        }
    }

    fun toEntity(request: CreateEventRequest): EventEntity {
        return EventEntity().apply {
            stadiumId = request.stadiumId
            beginAt = request.beginAt
            isFinished = false
            isCancelled = false
            minPlayers = request.minPlayers ?: 0
            minAge = request.minAge ?: 0
            maxAge = request.maxAge ?: 0
            minRank = request.minRank ?: 0.0
            maxRank = request.maxRank ?: 0.0
        }
    }

    fun toEvent(entity: EventEntity) = Event(
        id = entity.id!!,
        stadiumId = entity.stadiumId!!,
        beginAt = entity.beginAt!!,
        isFinished = entity.isFinished!!,
        isCancelled = entity.isCancelled!!,
        minPlayers = entity.minPlayers,
        minAge = entity.minAge,
        maxAge = entity.maxAge,
        minRank = entity.minRank,
        maxRank = entity.maxRank,
        createdAt = entity.createdAt!!,
        players = mutableListOf()
    )

    fun toEvent(entity: EventEntity, players: List<Player>): Event {
        val event = toEvent(entity)
        event.players = players
        return event
    }
}
