package com.dag.lets_play.mvc.controller

import com.dag.lets_play.mvc.model.GetStadiumRequest
import com.dag.lets_play.mvc.model.Stadium
import com.dag.lets_play.mvc.service.StadiumService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class StadiumControllerImpl(private val service: StadiumService) : StadiumController {

    override fun getStadiums(request: GetStadiumRequest): ResponseEntity<Set<Stadium>> {
        return ResponseEntity.ok(service.getStadiums(request))
    }
}
