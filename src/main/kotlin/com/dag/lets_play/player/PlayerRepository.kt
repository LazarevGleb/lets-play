package com.dag.lets_play.player

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.Optional

@Repository
interface PlayerRepository : JpaRepository<PlayerEntity, Long> {

    @Query(
        value = """
            SELECT * FROM player
            WHERE player.phone = :phone
            """,
        nativeQuery = true
    )
    fun findByPhone(phone: String): Optional<PlayerEntity?>
}
