package com.dag.lets_play.event

import com.dag.lets_play.exception.EventNotFoundException
import com.dag.lets_play.exception.PlayerEventAlreadyExists
import com.dag.lets_play.player.PlayerService
import com.dag.lets_play.stadium.StadiumService
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class EventService(
    private val dao: EventDao,
    private val mapper: EventMapper,
    private val stadiumService: StadiumService,
    private val playerService: PlayerService,
) {

    fun getById(id: Long): Event {
        val entity = dao.findById(id)
        if (entity.isEmpty) {
            throw EventNotFoundException("Can't find event by id: $id")
        }
        return mapper.toEvent(entity.get())
    }

    fun findEventToStadiums(request: GetEventRequest): List<EventToStadium> {
        val point = mapper.locationToPoint(request.location)
        val response = dao.getEventToStadiumMappings(
            point,
            request.distance,
            request.beginFrom,
            request.beginTill,
            request.age,
            request.rank
        )
        return response
            .groupBy(
                keySelector = { it.stadiumId!! },
                valueTransform = { it.eventId!! }
            ).map {
                EventToStadium(it.key, it.value)
            }.toList()
    }

    fun findStadiumWithEvents(request: GetStadiumWithEventsRequests): StadiumWithEvents {
        val stadium = stadiumService.getStadiumById(request.stadiumId)
        val eventEntities = dao.findByIdList(request.ids)
        return StadiumWithEvents(
            stadium,
            eventEntities.map { mapper.toEvent(it) }
        )
    }

    @Transactional
    fun create(request: CreateEventRequest): Event {
        val entity = mapper.toEntity(request)
        val savedEntity = dao.create(entity)
        logger.info("Saved event: $savedEntity")
        return mapper.toEvent(savedEntity)
    }

    @Transactional
    fun addPlayerToEvent(eventId: Long, playerId: Long, request: AddPlayerToEventRequest) {
        // проверка, что стадион и игрок существуют
        getById(eventId)
        playerService.getById(playerId)
        
        val exists = dao.existsPlayerEvent(eventId, playerId)
        if (exists) {
            throw PlayerEventAlreadyExists("Player=[$playerId] already added to event=[$eventId]")
        }
        dao.addPlayerToEvent(eventId, playerId, request.withBall)
    }

    companion object {
        private val logger = LoggerFactory.getLogger(EventService::class.java)
    }
}
