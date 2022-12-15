package com.dag.lets_play.stadium

import org.springframework.stereotype.Component

@Component
class StadiumMapper {
    fun toStadium(entity: StadiumEntity) = Stadium(
        address = entity.address!!,
        location = Location(entity.location!!.x, entity.location!!.y),
        capacity = Capacity.ofDescription(entity.capacity!!),
        description = entity.description,
        data = entity.data
    )
}
