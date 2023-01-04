package com.dag.lets_play.player

import com.dag.lets_play.position.PositionEntity
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table
import java.util.Date

@Entity
@Table(name = "player")
open class PlayerEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    open var id: Long? = null

    @Column(nullable = false)
    open var name: String? = null

    @Column(nullable = false, unique = true, columnDefinition = "phone")
    open var phone: String? = null

    @Column(nullable = false, unique = true)
    open var nickname: String? = null

    @Column(nullable = false)
    open var age: Int? = null

    @Column(name = "birth_date", nullable = false, columnDefinition = "date")
    open var birthDate: Date? = null

    @Column
    open var rank: Float? = null

    @ManyToOne
    @JoinColumn(name = "primary_position", nullable = false)
    open var primaryPosition: PositionEntity? = null

    @ManyToOne
    @JoinColumn(name = "secondary_position")
    open var secondaryPosition: PositionEntity? = null

    @Column
    open var avatar: String? = null
}
