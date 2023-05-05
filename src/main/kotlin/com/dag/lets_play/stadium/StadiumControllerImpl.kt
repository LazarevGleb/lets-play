package com.dag.lets_play.stadium

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.multipart.MultipartFile


@RestController
class StadiumControllerImpl(private val service: StadiumService) : StadiumController {
    
    override fun get(id: Long): ResponseEntity<Stadium> {
        val stadium = service.getStadiumById(id)
        return ResponseEntity.ok(stadium)
    }

    override fun findNearest(request: GetStadiumRequest): ResponseEntity<List<StadiumPreview>> {
        val stadiumPreviews = service.getStadiumPreviews(request)
        return ResponseEntity.ok(stadiumPreviews)
    }

    override fun create(request: Stadium): ResponseEntity<Stadium> {
        return ResponseEntity
            .status(HttpStatus.CREATED)
            .body(service.create(request))
    }

    override fun update(id: Long, request: Stadium): ResponseEntity<Stadium> {
        val updated = service.update(id, request)
        if (updated > 0) {
            return ResponseEntity.ok().build()
        }
        return ResponseEntity.notFound().build()
    }

    // TODO Удаление по локации или по id или и так и так?
    override fun delete(id: Long, request: DeleteStadiumRequest): ResponseEntity<Unit> {
        val removed = service.deleteByLocation(request.location)
        if (removed > 0) {
            return ResponseEntity.noContent().build()
        }
        return ResponseEntity.notFound().build()
    }

    override fun uploadFile(@RequestParam("file") file: MultipartFile): ResponseEntity<Unit> {
        service.uploadStadiums(file)
        return ResponseEntity.ok().build()
    }
}
