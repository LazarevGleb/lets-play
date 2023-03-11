package com.dag.lets_play.player

import com.dag.lets_play.image.ImageProcessor
import org.springframework.stereotype.Component
import java.time.LocalDate
import java.time.Period
import java.time.ZoneId

@Component
class PlayerMapper(
    private val imageProcessor: ImageProcessor
) {

    fun toPlayer(entity: PlayerEntity) = Player(
        id = entity.id!!,
        phone = entity.phone!!,
        name = entity.name!!,
        nickname = entity.nickname!!,
        age = Period.between(entity.birthDate!!.toInstant().atZone(ZoneId.systemDefault()).toLocalDate(), LocalDate.now()).years,
        birthDate = entity.birthDate!!,
        rank = entity.rank,
        primaryPosition = entity.primaryPosition!!,
        secondaryPosition = entity.secondaryPosition,
        avatar = entity.avatar?.let { imageProcessor.loadImage(it) }
    )

    fun toEntity(player: Player): PlayerEntity {
        return PlayerEntity().apply {
            name = player.name
            phone = player.phone
            nickname = player.nickname
            birthDate = player.birthDate
            rank = player.rank
            primaryPosition = player.primaryPosition
            secondaryPosition = player.secondaryPosition
            avatar = player.avatar?.let { imageProcessor.saveImage(it) }
        }
    }
}
