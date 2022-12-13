package com.dag.lets_play.mvc.dao

import com.dag.lets_play.mvc.model.Location
import com.dag.lets_play.mvc.model.Stadium
import com.dag.lets_play.mvc.repository.StadiumRepository
import org.springframework.stereotype.Component

@Component
class StadiumDao(private val repo: StadiumRepository) {
    fun getStadiums(location: Location, radius: Double): Set<Stadium> {
        return setOf(
            Stadium("Тестовый 1", Location("Где-то рядом", "Где-то здесь"))
        )
    }

}
