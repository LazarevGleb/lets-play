package com.dag.lets_play.stadium

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class StadiumService(
    private val dao: StadiumDao,
    private val mapper: StadiumMapper
) {
    fun getStadiums(request: GetStadiumRequest): List<Stadium> {
        val stadiumEntities = dao.getStadiumsWithinDistance(request.location, request.distance)
        return stadiumEntities.map { e -> mapper.toStadium(e) }
    }

    fun create(stadium: Stadium): Stadium {
        val entity = mapper.toEntity(stadium)
        val savedEntity = dao.save(entity)
        logger.info("Saved stadium: $savedEntity")
        return mapper.toStadium(entity)
    }

    companion object {
        private val logger = LoggerFactory.getLogger(StadiumService::class.java)
    }
}
