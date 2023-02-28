package com.dag.lets_play.stadium

import org.locationtech.jts.geom.Coordinate
import org.locationtech.jts.geom.GeometryFactory
import org.locationtech.jts.geom.Point
import org.locationtech.jts.geom.PrecisionModel
import org.springframework.stereotype.Component

@Component
class StadiumMapper {
    fun toStadium(entity: StadiumEntity) = Stadium(
        address = entity.address!!,
        location = Location(entity.location!!.y, entity.location!!.x),
        capacity = Capacity.of(entity.capacity!!),
        description = entity.description,
        data = entity.data,
        createdAt = entity.createdAt,
        removedAt = entity.removedAt
    )

    fun toEntity(stadium: Stadium): StadiumEntity {
        val coordinate = Coordinate(stadium.location.longitude, stadium.location.latitude)
        val point = geometryFactory.createPoint(coordinate)

        return StadiumEntity().apply {
            address = stadium.address
            location = point
            capacity = stadium.capacity.value
            description = stadium.description
            data = stadium.data
            createdAt = stadium.createdAt
            removedAt = stadium.removedAt
        }
    }

    fun locationToPoint(location: Location): Point {
        val coordinate = Coordinate(location.longitude, location.latitude)
        return geometryFactory.createPoint(coordinate)
    }

    companion object {
        private const val SRID = 4326
        private val geometryFactory = GeometryFactory(PrecisionModel(), SRID)
    }
}
