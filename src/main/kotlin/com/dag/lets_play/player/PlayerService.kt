package com.dag.lets_play.player

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class PlayerService(
    private val dao: PlayerDao,
    private val mapper: PlayerMapper
) {

    fun getPlayerByPhone(phone: String): Player {
        val player = dao.getPlayerByPhone(phone)
        return mapper.toPlayer(player.get())
    }

    fun getAllPlayers(): List<Player> {
        return dao.getAllPlayers().stream().map { mapper.toPlayer(it) }.toList()
    }

    fun create(player: Player): Player {
        val entity = mapper.toEntity(player)
        val savedEntity = dao.save(entity)
        logger.info("Saved player: $savedEntity")
        return mapper.toPlayer(entity)
    }

    companion object {
        private val logger = LoggerFactory.getLogger(PlayerService::class.java)
    }
}
