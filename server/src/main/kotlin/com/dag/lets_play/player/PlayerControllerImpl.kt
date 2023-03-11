package com.dag.lets_play.player

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class PlayerControllerImpl(private val service: PlayerService) : PlayerController {

    override fun create(request: Player): ResponseEntity<Player> {
        return ResponseEntity
            .status(HttpStatus.CREATED)
            .body(service.create(request))
    }

    override fun getByPhone(phone: String): ResponseEntity<Player> {
        return ResponseEntity
            .status(HttpStatus.OK)
            .body(service.getPlayerByPhone(phone))
    }
}
