package com.dag.lets_play.player

import com.dag.lets_play.exception.PlayerNotFoundException
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class PlayerService(
    private val dao: PlayerDao,
    private val mapper: PlayerMapper
) {

    fun getPlayerByPhone(phone: String): Player {
        val player = dao.getPlayerByPhone(phone)
        if (player.isEmpty) {
            throw PlayerNotFoundException("Can't find player by phone: $phone")
        }
        return mapper.toPlayer(player.get())
    }

    @Transactional
    fun create(player: Player): Player {
        val entity = mapper.toEntity(player)
        val savedEntity = dao.save(entity)
        logger.info("Saved player: $savedEntity")
        return mapper.toPlayer(entity)
    }

    fun getById(id: Long): Player {
        val player = dao.findById(id)
        if (player.isEmpty) {
            throw PlayerNotFoundException("Can't find player by id: $id")
        }
        return mapper.toPlayer(player.get())
    }

    companion object {
        private val logger = LoggerFactory.getLogger(PlayerService::class.java)
    }
}
