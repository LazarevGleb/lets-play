package com.dag.lets_play.exception

class EventNotFoundException(message: String) : RuntimeException(message)

class PlayerNotFoundException(message: String) : RuntimeException(message)

class StadiumNotFoundException(message: String) : RuntimeException(message)

class PlayerEventAlreadyExists(message: String) : RuntimeException(message)
