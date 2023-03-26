package com.dag.lets_play.event

import com.dag.lets_play.utils.BaseRepository
import org.locationtech.jts.geom.Point
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.time.LocalDateTime

@Repository
interface EventRepository : BaseRepository<EventEntity> {

    @Query(
        value = """
            SELECT e.id AS eventId, e.stadium_id AS stadiumId
            FROM event e
            LEFT JOIN stadium s on s.id = e.stadium_id
            WHERE ST_DistanceSphere(s.location, :point) <= :distance
                AND e.begin_at BETWEEN :beginFrom AND :beginTill
                AND (:age IS NULL OR e.min_age <= :age)
                AND (:rank IS NULL OR e.min_rank <= :rank)
        """,
        nativeQuery = true
    )
    fun findEventToStadiumRelations(
        point: Point,
        distance: Double,
        beginFrom: LocalDateTime,
        beginTill: LocalDateTime,
        age: Int?,
        rank: Double?
    ): List<IEventToStadium>
}
