package com.dag.lets_play.exception

import jakarta.servlet.http.HttpServletRequest
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler

@ControllerAdvice
class ErrorHandler {

    @ExceptionHandler(value = [Exception::class])
    fun handleException(e: Exception, request: HttpServletRequest): ResponseEntity<Any> {
        logger.error("Error in endpoint=${request.requestURI}. $e")
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build()
    }

    companion object {
        private val logger = LoggerFactory.getLogger(ErrorHandler::class.java)
    }
}
