package com.dag.lets_play.stadium

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface StadiumRepository : JpaRepository<StadiumEntity, Long> {
}
