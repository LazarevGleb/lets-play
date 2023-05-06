package com.dag.lets_play.stadium

import com.dag.lets_play.csv.CsvStadium
import com.dag.lets_play.utils.BaseMapper
import org.locationtech.jts.geom.Coordinate
import org.springframework.stereotype.Component

@Component
class StadiumMapper: BaseMapper() {
    fun toStadium(entity: StadiumEntity) = Stadium(
        id = entity.id!!,
        address = entity.address!!,
        location = Location(entity.location!!.y, entity.location!!.x),
        capacity = Capacity.of(entity.capacity!!),
        description = entity.description,
        data = entity.data,
        createdAt = entity.createdAt,
        removedAt = entity.removedAt,
        avatar = entity.avatar,
    )

    fun toEntity(stadium: Stadium, _id: Long? = null): StadiumEntity {
        val coordinate = Coordinate(stadium.location.longitude, stadium.location.latitude)
        val point = geometryFactory.createPoint(coordinate)

        return StadiumEntity().apply {
            id = _id
            address = stadium.address
            location = point
            capacity = stadium.capacity.value
            description = stadium.description
            data = stadium.data
            createdAt = stadium.createdAt
            removedAt = stadium.removedAt
        }
    }

    fun toEntity(stadium: CsvStadium): StadiumEntity {
        val coordinate = Coordinate(stadium.longitude, stadium.latitude)
        val point = geometryFactory.createPoint(coordinate)

        return StadiumEntity().apply {
            address = stadium.address
            location = point
            capacity = stadium.capacity
        }
    }
}
