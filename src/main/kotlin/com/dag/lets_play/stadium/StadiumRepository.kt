package com.dag.lets_play.stadium

import org.locationtech.jts.geom.Point
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

@Repository
interface StadiumRepository : JpaRepository<StadiumEntity, Long> {

    @Query(
        value = """
            SELECT * FROM stadium
            WHERE ST_DistanceSphere(location, :point) < :distance
            """,
        nativeQuery = true
    )
    fun findStadiumsWithinDistance(point: Point, distance: Double): List<StadiumEntity>
}
