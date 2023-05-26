package com.dag.lets_play.event

import com.dag.lets_play.utils.BaseDao
import org.locationtech.jts.geom.Point
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import java.time.LocalDateTime

@Component
class EventDao(private val repository: EventRepository) : BaseDao<EventEntity>(repository) {

    fun create(entity: EventEntity): EventEntity {
        try {
            entity.createdAt = LocalDateTime.now()
            return repository.save(entity)
        } catch (e: Exception) {
            logger.error("Cannot save stadium=$entity due to error. ", e)
            throw e
        }
    }

    fun getEventToStadiumMappings(
        point: Point,
        distance: Double,
        beginFrom: LocalDateTime,
        beginTill: LocalDateTime,
        age: Int?,
        rank: Double?
    ): List<IEventToStadium> {
        return repository.findEventToStadiumRelations(point, distance, beginFrom, beginTill, age, rank)
    }

    fun existsPlayerEvent(eventId: Long, playerId: Long): Boolean {
       return repository.existsPlayerEvent(eventId, playerId)
    }

    fun addPlayerToEvent(eventId: Long, playerId: Long, withBall: Boolean?) {
        repository.insertIntoPlayerEvent(eventId, playerId, withBall)
    }

    companion object {
        private val logger = LoggerFactory.getLogger(EventDao::class.java)
    }
}
