package com.dag.lets_play.stadium

import jakarta.transaction.Transactional
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class StadiumService(
    private val dao: StadiumDao,
    private val mapper: StadiumMapper
) {
    fun getStadiums(request: GetStadiumRequest): List<Stadium> {
        val stadiumEntities = dao.getStadiumsWithinDistance(request.location, request.distance)
        return stadiumEntities.map { mapper.toStadium(it) }
    }

    @Transactional
    fun create(stadium: Stadium): Stadium {
        val entity = mapper.toEntity(stadium)
        val savedEntity = dao.create(entity)
        logger.info("Saved stadium: $savedEntity")
        return mapper.toStadium(savedEntity)
    }

    @Transactional
    fun update(stadium: Stadium): Int {
        val entity = mapper.toEntity(stadium)
        val rowsUpdated = dao.update(entity)
        if (rowsUpdated > 0) {
            logger.info("Updated stadium: $stadium")
        }
        return rowsUpdated
    }

    @Transactional
    fun deleteByLocation(location: Location): Int {
        val point = mapper.locationToPoint(location)
        val rowsDeleted = dao.deleteByPoint(point)
        if (rowsDeleted > 0) {
            logger.info("Removed stadium in location: $location")
        }
        return rowsDeleted
    }

    companion object {
        private val logger = LoggerFactory.getLogger(StadiumService::class.java)
    }
}
