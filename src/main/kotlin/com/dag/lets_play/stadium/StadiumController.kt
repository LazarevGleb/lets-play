package com.dag.lets_play.stadium

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.multipart.MultipartFile

@RequestMapping("/api/stadiums")
interface StadiumController {

    @GetMapping("/{id}")
    fun get(@PathVariable id: Long): ResponseEntity<Stadium>
    
    @PostMapping("/findNearest")
    fun findNearest(@RequestBody request: GetStadiumRequest): ResponseEntity<List<StadiumPreview>>

    @PostMapping("/")
    fun create(@RequestBody request: Stadium): ResponseEntity<Stadium>

    @PutMapping("/{id}")
    fun update(@PathVariable id: Long, @RequestBody request: Stadium): ResponseEntity<Stadium>

    @DeleteMapping("/{id}")
    fun delete(@PathVariable id: Long, @RequestBody request: DeleteStadiumRequest): ResponseEntity<Unit>

    @PostMapping("/upload")
    fun uploadFile(@RequestParam("file") file: MultipartFile): ResponseEntity<Unit>
}
