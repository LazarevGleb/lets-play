package com.dag.lets_play.player

import com.dag.lets_play.utils.BaseRepository
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.Optional

@Repository
interface PlayerRepository : BaseRepository<PlayerEntity> {
    fun findByPhone(phone: String): Optional<PlayerEntity?>
}
