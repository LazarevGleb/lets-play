package com.dag.lets_play.stadium

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class StadiumControllerImpl(private val service: StadiumService) : StadiumController {

    override fun getStadiums(request: GetStadiumRequest): ResponseEntity<Set<Stadium>> {
        return ResponseEntity.ok(service.getStadiums(request))
    }
}
