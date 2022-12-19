package com.dag.lets_play.stadium

import org.locationtech.jts.geom.Coordinate
import org.locationtech.jts.geom.GeometryFactory
import org.locationtech.jts.geom.PrecisionModel
import org.springframework.stereotype.Repository

@Repository
class StadiumDao(private val repository: StadiumRepository) {
    fun getStadiumsWithinDistance(location: Location, distance: Double): List<StadiumEntity> {
        val coordinate = Coordinate(location.longitude, location.latitude)
        val point = geometryFactory.createPoint(coordinate)
        return repository.findStadiumsWithinDistance(point, distance)
    }

    fun save(entity: StadiumEntity): StadiumEntity {
        return repository.save(entity)
    }

    companion object {
        private const val SRID = 4326
        private val geometryFactory = GeometryFactory(PrecisionModel(), SRID)
    }
}
