package com.dag.lets_play.player

import org.springframework.stereotype.Repository
import java.util.*

@Repository
class PlayerDao(private val repository: PlayerRepository) {

    fun getPlayerByPhone(phone: String): Optional<PlayerEntity?> {
        return repository.findByPhone(phone)
    }

    fun getAllPlayers(): List<PlayerEntity> {
        return repository.findAll()
    }

    fun save(entity: PlayerEntity): PlayerEntity {
        return repository.save(entity)
    }
}
