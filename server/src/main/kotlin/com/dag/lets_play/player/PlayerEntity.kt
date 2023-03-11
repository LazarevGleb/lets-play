package com.dag.lets_play.player

import com.dag.lets_play.utils.BaseEntity
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Table
import java.util.Date

@Entity
@Table(name = "player")
open class PlayerEntity : BaseEntity() {

    @Column(nullable = false)
    open var name: String? = null

    @Column(nullable = false, unique = true, columnDefinition = "phone")
    open var phone: String? = null

    @Column(nullable = false, unique = true)
    open var nickname: String? = null

    @Column(name = "birth_date", nullable = false, columnDefinition = "date")
    open var birthDate: Date? = null

    @Column
    open var rank: Double? = null

    @Column(name = "primary_position", nullable = false)
    open var primaryPosition: String? = null

    @Column(name = "secondary_position")
    open var secondaryPosition: String? = null

    @Column
    open var avatar: String? = null
}
