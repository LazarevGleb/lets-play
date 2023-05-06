package com.dag.lets_play.stadium

import com.dag.lets_play.utils.BaseRepository
import org.locationtech.jts.geom.Point
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository

@Repository
interface StadiumRepository : BaseRepository<StadiumEntity> {

    @Query(
        value = """
            SELECT s.id, s.location FROM stadium s
            WHERE ST_DistanceSphere(location, :point) <= :distance
            """,
        nativeQuery = true
    )
    fun findStadiumsWithinDistance(point: Point, distance: Double): List<IStadiumIdLocation>

    @Modifying(clearAutomatically = true)
    @Query(
        value = """
            UPDATE stadium
            SET address = :address,
            capacity = :capacity,
            description = :description,
            data = :data
            WHERE location = :location
        """,
        nativeQuery = true
    )
    fun update(
        address: String?,
        location: Point?,
        capacity: String?,
        description: String?,
        data: Map<String, Any>?
    ): Int


    @Modifying(clearAutomatically = true)
    @Query(
        value = """
            UPDATE stadium
            SET removed_at = now()
            WHERE location = :location
                AND removed_at is NULL
        """,
        nativeQuery = true
    )
    fun deleteByPoint(location: Point): Int
}
