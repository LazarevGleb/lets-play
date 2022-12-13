package com.dag.lets_play.mvc.controller

import com.dag.lets_play.mvc.model.GetStadiumRequest
import com.dag.lets_play.mvc.model.Stadium
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping

@RequestMapping("/api/stadiums")
interface StadiumController {

    @PostMapping("/")
    fun getStadiums(@RequestBody request: GetStadiumRequest): ResponseEntity<Set<Stadium>>
}
