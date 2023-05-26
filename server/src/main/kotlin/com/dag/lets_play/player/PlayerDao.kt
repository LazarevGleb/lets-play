package com.dag.lets_play.player

import com.dag.lets_play.utils.BaseDao
import org.springframework.stereotype.Component
import java.util.Optional

@Component
class PlayerDao(private val repository: PlayerRepository) : BaseDao<PlayerEntity>(repository) {

    fun getPlayerByPhone(phone: String): Optional<PlayerEntity?> {
        return repository.findByPhone(phone)
    }

    fun save(entity: PlayerEntity): PlayerEntity {
        return repository.save(entity)
    }

    fun findByEventId(eventId: Long): List<PlayerEntity?> {
        return repository.findByEventId(eventId)  
    }
}
