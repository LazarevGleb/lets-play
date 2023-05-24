package com.dag.lets_play.event

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class EventControllerImpl(
    private val eventService: EventService
) : EventController {

    override fun get(id: Long): ResponseEntity<Event> {
        val event = eventService.getById(id)
        return ResponseEntity.ok(event)
    }

    override fun findEvents(request: GetStadiumWithEventsRequests): ResponseEntity<StadiumWithEvents> {
        val response = eventService.findStadiumWithEvents(request)
        return ResponseEntity.ok(response)
    }

    override fun findNearest(request: GetEventRequest): ResponseEntity<List<EventToStadium>> {
        val events = eventService.findEventToStadiums(request)
        return ResponseEntity.ok(events)
    }

    override fun create(request: CreateEventRequest): ResponseEntity<Event> {
        val created = eventService.create(request)
        return ResponseEntity.status(HttpStatus.CREATED).body(created)
    }

    override fun addPlayerToEvent(eventId: Long, playerId: Long, request: AddPlayerToEventRequest) {
        eventService.addPlayerToEvent(eventId, playerId, request)
    }
}
