package com.dag.lets_play.utils

import java.util.Optional

open class BaseDao<T : BaseEntity>(
    private val repository: BaseRepository<T>
) {
    fun findById(id: Long): Optional<T> {
        return repository.findById(id)
    }

    fun findByIdList(ids: List<Long>): List<T> {
        return repository.findAllById(ids)
    }
}
