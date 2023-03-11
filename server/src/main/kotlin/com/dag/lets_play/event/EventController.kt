package com.dag.lets_play.event

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping

@RequestMapping("/api/events")
interface EventController {

    @GetMapping("/{id}")
    fun get(@PathVariable id: Long): ResponseEntity<Event>

    @PostMapping("/findStadiumWithEvents")
    fun findEvents(@RequestBody request: GetStadiumWithEventsRequests): ResponseEntity<StadiumWithEvents>

    @PostMapping("/findNearest")
    fun findNearest(@RequestBody request: GetEventRequest): ResponseEntity<List<EventToStadium>>

    @PostMapping
    fun create(@RequestBody request: CreateEventRequest): ResponseEntity<Event>
}
