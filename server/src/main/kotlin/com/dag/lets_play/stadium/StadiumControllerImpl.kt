package com.dag.lets_play.stadium

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController

@RestController
class StadiumControllerImpl(private val service: StadiumService) : StadiumController {

    override fun getStadiums(request: GetStadiumRequest): ResponseEntity<List<Stadium>> {
        return ResponseEntity.ok(service.getStadiums(request))
    }

    override fun createStadium(request: Stadium): ResponseEntity<Stadium> {
        return ResponseEntity
            .status(HttpStatus.CREATED)
            .body(service.create(request))
    }

    override fun updateStadium(request: Stadium): ResponseEntity<Stadium> {
        val updated = service.update(request)
        if (updated > 0) {
            return ResponseEntity.ok().build()
        }
        return ResponseEntity.notFound().build()
    }

    override fun deleteStadium(request: DeleteStadiumRequest): ResponseEntity<Unit> {
        val removed = service.deleteByLocation(request.location)
        if (removed > 0) {
            return ResponseEntity.noContent().build()
        }
        return ResponseEntity.notFound().build()
    }
}
