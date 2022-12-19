package com.dag.lets_play.stadium

import org.locationtech.jts.geom.Coordinate
import org.locationtech.jts.geom.GeometryFactory
import org.locationtech.jts.geom.PrecisionModel
import org.springframework.stereotype.Component

@Component
class StadiumMapper {
    fun toStadium(entity: StadiumEntity) = Stadium(
        address = entity.address!!,
        location = Location(entity.location!!.x, entity.location!!.y),
        capacity = Capacity.of(entity.capacity!!),
        description = entity.description,
        data = entity.data
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
        }
    }

    companion object {
        private const val SRID = 4326
        private val geometryFactory = GeometryFactory(PrecisionModel(), SRID)
    }
}
