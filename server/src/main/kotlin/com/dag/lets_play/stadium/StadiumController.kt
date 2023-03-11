package com.dag.lets_play.stadium

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping

@RequestMapping("/api/stadiums")
interface StadiumController {

    @PostMapping("/findNearest")
    fun getStadiums(@RequestBody request: GetStadiumRequest): ResponseEntity<List<Stadium>>
    
    @PostMapping("/")
    fun createStadium(@RequestBody request: Stadium): ResponseEntity<Stadium>
    
    @PutMapping("/")
    fun updateStadium(@RequestBody request: Stadium): ResponseEntity<Stadium>

    @DeleteMapping("/")
    fun deleteStadium(@RequestBody request: DeleteStadiumRequest): ResponseEntity<Unit>
}
