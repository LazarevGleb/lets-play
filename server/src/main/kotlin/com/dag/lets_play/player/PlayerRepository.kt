package com.dag.lets_play.player

import com.dag.lets_play.utils.BaseRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.Optional

@Repository
interface PlayerRepository : BaseRepository<PlayerEntity> {

    fun findByPhone(phone: String): Optional<PlayerEntity?>

    @Query(
        value = """
            SELECT 
                p.id,
                p.phone,
                p.name,
                p.nickname,
                p.birth_date,
                p.rank,
                p.primary_position,
                p.secondary_position,
                p.avatar FROM player p
            JOIN player_event pe on p.id = pe.player_id
            WHERE pe.event_id = :eventId
        """,
        nativeQuery = true
    )
    fun findByEventId(eventId: Long): List<PlayerEntity?>
}
