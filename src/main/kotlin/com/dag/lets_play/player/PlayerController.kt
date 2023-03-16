package com.dag.lets_play.player

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping

@RequestMapping("/api/players")
interface PlayerController {

    @PostMapping("/")
    fun createPlayer(@RequestBody request: Player): ResponseEntity<Player>

    @GetMapping("/{phone}")
    fun getPlayerByPhone(@PathVariable phone: String): ResponseEntity<Player>

    @GetMapping("/")
    fun getPlayers(): ResponseEntity<List<Player>>
}
