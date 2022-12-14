package com.dag.lets_play.stadium

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table

@Entity
@Table(name = "stadium")
open class StadiumEntity {

    @Id
    @Column
    open var id: Long? = null

    @Column
    open var address: String? = null

    @Column
    open var longitude: Float? = null

    @Column
    open var latitude: Float? = null

    @Column
    open var capacity: Int? = null

    @Column
    open var description: String? = null

    @Column
    open var data: String? = null
}
