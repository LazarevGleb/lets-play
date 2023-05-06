package com.dag.lets_play.event

import com.dag.lets_play.utils.BaseEntity
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Table
import java.time.LocalDateTime

@Entity
@Table(name = "event")
open class EventEntity : BaseEntity() {

    @Column(name = "stadium_id", nullable = false)
    open var stadiumId: Long? = null

    @Column(name = "begin_at", nullable = false)
    open var beginAt: LocalDateTime? = null

    @Column(name = "is_finished", nullable = false)
    open var isFinished: Boolean? = null

    @Column(name = "is_cancelled", nullable = false)
    open var isCancelled: Boolean? = null

    @Column(name = "min_players")
    open var minPlayers: Int? = null

    @Column(name = "min_age")
    open var minAge: Int? = null

    @Column(name = "max_age")
    open var maxAge: Int? = null

    @Column(name = "min_rank")
    open var minRank: Double? = null

    @Column(name = "max_rank")
    open var maxRank: Double? = null

    @Column(name = "created_at", nullable = false)
    open var createdAt: LocalDateTime? = null
}

interface IEventToStadium {
    val eventId: Long?
    val stadiumId: Long?
}
