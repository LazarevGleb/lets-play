package com.dag.lets_play.stadium

import com.dag.lets_play.utils.BaseEntity
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Table
import org.geolatte.geom.Position
import org.hibernate.annotations.JdbcTypeCode
import org.hibernate.type.SqlTypes
import org.locationtech.jts.geom.Point
import java.time.LocalDateTime

@Entity
@Table(name = "stadium")
open class StadiumEntity : BaseEntity() {

    @Column(nullable = false)
    open var address: String? = null

    @Column(columnDefinition = "geometry(Point,4326)", nullable = false)
    @JdbcTypeCode(SqlTypes.GEOMETRY)
    open var location: Point? = null

    @Column
    open var capacity: String? = null

    open var description: String? = null

    open var avatar: String? = null

    @JdbcTypeCode(SqlTypes.JSON)
    open var data: Map<String, Any>? = null

    @Column(name = "created_at", nullable = false)
    open var createdAt: LocalDateTime? = null

    @Column(name = "removed_at")
    open var removedAt: LocalDateTime? = null
}

interface IStadiumIdLocation {
    val id: Long?
    val location: org.geolatte.geom.Point<Position>
}
