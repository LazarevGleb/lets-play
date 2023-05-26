package com.dag.lets_play.player

import com.dag.lets_play.image.ImageProcessor
import org.springframework.stereotype.Component
import java.time.LocalDate
import java.time.Period

@Component
class PlayerMapper(
    private val imageProcessor: ImageProcessor
) {

    fun toPlayer(entity: PlayerEntity) = Player(
        id = entity.id!!,
        phone = entity.phone!!,
        name = entity.name!!,
        nickname = entity.nickname!!,
        age = Period.between(entity.birthDate!!, LocalDate.now()).years,
        birthDate = entity.birthDate!!,
        rank = entity.rank,
        primaryPosition = Position.valueOf(entity.primaryPosition!!),
        secondaryPosition = entity.secondaryPosition?.let { Position.valueOf(it) },
        avatar = entity.avatar?.let { imageProcessor.loadImage(it) }
    )

    fun toEntity(player: CreatePlayerRequest): PlayerEntity {
        return PlayerEntity().apply {
            name = player.name
            phone = player.phone
            nickname = player.nickname
            birthDate = player.birthDate
            rank = player.rank
            primaryPosition = player.primaryPosition.name
            secondaryPosition = player.secondaryPosition?.name
            avatar = player.avatar?.let { imageProcessor.saveImage(it) }
        }
    }
}
