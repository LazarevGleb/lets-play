package com.dag.lets_play.position

import org.springframework.stereotype.Component

@Component
class PositionMapper {
    fun toPosition(entity: PositionEntity) = Position(
        title = entity.title!!,
        description = entity.description!!
    )

    fun toPosition(position: Position): PositionEntity {
        return PositionEntity().apply {
            title = position.title
            description = position.description
        }
    }
}
