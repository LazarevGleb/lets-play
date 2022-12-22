package com.dag.lets_play.position

import jakarta.persistence.*

@Entity
@Table(name = "position")
open class PositionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    open var id: Long? = null

    @Column(nullable = false, unique = true)
    open var title: String? = null

    @Column
    open var description: String? = null
}
