package com.dag.lets_play.player

import com.dag.lets_play.image.ImageProcessor
import com.dag.lets_play.position.PositionMapper
import org.springframework.stereotype.Component

@Component
class PlayerMapper(
    private val positionMapper: PositionMapper,
    private val imageProcessor: ImageProcessor
) {

    fun toPlayer(entity: PlayerEntity) = Player(
        phone = entity.phone!!,
        name = entity.name!!,
        nickname = entity.nickname!!,
        age = entity.age!!,
        birthDate = entity.birthDate!!,
        rank = entity.rank,
        primaryPosition = positionMapper.toPosition(entity.primaryPosition!!),
        secondaryPosition = entity.secondaryPosition?.let { positionMapper.toPosition(it) },
        avatar = entity.avatar?.let { imageProcessor.loadImage(it) }
    )

    fun toEntity(player: Player): PlayerEntity {
        return PlayerEntity().apply {
            name = player.name
            phone = player.phone
            nickname = player.nickname
            age = player.age
            birthDate = player.birthDate
            rank = player.rank
            primaryPosition = positionMapper.toPosition(player.primaryPosition)
            secondaryPosition = player.secondaryPosition?.let { positionMapper.toPosition(it) }
            avatar = player.avatar?.let { imageProcessor.saveImage(it) }
        }
    }
}
