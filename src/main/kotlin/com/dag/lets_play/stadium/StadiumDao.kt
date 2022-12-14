package com.dag.lets_play.stadium

import org.locationtech.jts.geom.Point
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Repository

@Repository
class StadiumDao(private val repository: StadiumRepository) {
    fun getStadiumsWithinDistance(point: Point, distance: Double): List<StadiumEntity> {
        return repository.findStadiumsWithinDistance(point, distance)
    }

    fun create(entity: StadiumEntity): StadiumEntity {
        try {
            return repository.save(entity)
        } catch (e: Exception) {
            logger.error("Cannot save stadium=$entity due to error. ", e)
            throw e
        }
    }

    fun update(entity: StadiumEntity): Int {
        try {
            return repository.update(entity.address, entity.location, entity.capacity, entity.description, entity.data)
        } catch (e: Exception) {
            logger.error("Cannot update stadium=$entity due to error. ", e)
            throw e
        }
    }

    fun deleteByPoint(point: Point): Int {
        try {
            return repository.deleteByPoint(point)
        } catch (e: Exception) {
            logger.error("Cannot remove stadium in location=$point due to error. ", e)
            throw e
        }
    }

    companion object {
        private val logger = LoggerFactory.getLogger(StadiumDao::class.java)
    }
}
