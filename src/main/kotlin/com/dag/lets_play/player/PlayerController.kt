package com.dag.lets_play.player

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RequestMapping("/api/players")
interface PlayerController {

    @PostMapping("/")
    fun createPlayer(@RequestBody request: Player): ResponseEntity<Player>

    @GetMapping("/{phone}")
    fun getPlayer(@PathVariable phone: String): ResponseEntity<Player>

    @GetMapping("/")
    fun getPlayers(): ResponseEntity<List<Player>>
}
