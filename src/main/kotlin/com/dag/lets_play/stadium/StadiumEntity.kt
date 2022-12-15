package com.dag.lets_play.stadium

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table
import org.hibernate.annotations.JdbcTypeCode
import org.hibernate.type.SqlTypes
import org.locationtech.jts.geom.Point

@Entity
@Table(name = "stadium")
open class StadiumEntity {

    @Id
    @Column
    open var id: Long? = null

    @Column(nullable = false)
    open var address: String? = null

    @Column(columnDefinition = "geometry(Point,4326)")
    @JdbcTypeCode(SqlTypes.GEOMETRY)
    open var location: Point? = null
    
    open var capacity: String? = null

    open var description: String? = null

    @JdbcTypeCode(SqlTypes.JSON)
    open var data: Map<String, Any>? = null
}
