package com.dag.lets_play.utils

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.NoRepositoryBean

@NoRepositoryBean
interface BaseRepository<T : BaseEntity> : JpaRepository<T, Long>
