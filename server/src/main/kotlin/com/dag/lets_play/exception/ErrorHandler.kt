package com.dag.lets_play.exception

import jakarta.servlet.http.HttpServletRequest
import jakarta.validation.ConstraintViolationException
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.validation.FieldError
import org.springframework.web.bind.MethodArgumentNotValidException
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler


@ControllerAdvice
class ErrorHandler {

    @ExceptionHandler(value = [ConstraintViolationException::class])
    fun handleConstraintViolationException(
        e: ConstraintViolationException,
        request: HttpServletRequest
    ): ResponseEntity<Any> {
        logger.warn("Validation failed. ${e.constraintViolations.map { "${it.invalidValue} in ${it.propertyPath}" }}")
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build()
    }

    @ExceptionHandler(value = [MethodArgumentNotValidException::class])
    fun handleConstraintViolationException(
        e: MethodArgumentNotValidException,
        request: HttpServletRequest
    ): ResponseEntity<Any> {
        val errors = mutableMapOf<String, String>()
        e.bindingResult.allErrors.forEach { error ->
            val fieldName = (error as FieldError).field
            val errorMessage = error.getDefaultMessage()!!
            errors[fieldName] = errorMessage
        }
        logger.warn("Validation failed. ${errors.map { "${it.key} ${it.value}" }}")
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build()
    }

    @ExceptionHandler(
        value = [
            PlayerNotFoundException::class,
            EventNotFoundException::class,
            StadiumNotFoundException::class
        ]
    )
    fun handleNotFoundException(e: RuntimeException, request: HttpServletRequest): ResponseEntity<Any> {
        logger.warn("Not found exception. ${e.message}")
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build()
    }

    @ExceptionHandler(
        value = [
            PlayerEventAlreadyExists::class,
        ]
    )
    fun handleAlreadyExists(e: RuntimeException, request: HttpServletRequest): ResponseEntity<Any> {
        logger.warn("Already exists exception. ${e.message}")
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build()
    }

    @ExceptionHandler(value = [Exception::class])
    fun handleException(e: Exception, request: HttpServletRequest): ResponseEntity<Any> {
        logger.error("Error in endpoint=${request.requestURI}. $e")
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body("Упс, что-то пошло не по плану:${System.lineSeparator()}'${e.message}'")
    }

    companion object {
        private val logger = LoggerFactory.getLogger(ErrorHandler::class.java)
    }
}
