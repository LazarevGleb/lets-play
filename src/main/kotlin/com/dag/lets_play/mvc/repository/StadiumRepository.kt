package com.dag.lets_play.mvc.repository

import com.dag.lets_play.mvc.entity.StadiumEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface StadiumRepository : JpaRepository<StadiumEntity, Long>
