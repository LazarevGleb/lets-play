package com.dag.lets_play.player

import org.springframework.stereotype.Repository
import java.util.Optional

@Repository
class PlayerDao(private val repository: PlayerRepository) {

    fun getPlayerByPhone(phone: String): Optional<PlayerEntity?> {
        return repository.findByPhone(phone)
    }

    fun save(entity: PlayerEntity): PlayerEntity {
        return repository.save(entity)
    }
}
