package com.dag.lets_play.stadium

import org.springframework.stereotype.Repository

@Repository
class StadiumDao() {
    fun getStadiums(location: Location, radius: Double): Set<Stadium> {
        return setOf(
            Stadium("Тестовый 1", Location("Где-то рядом", "Где-то здесь"))
        )
    }

}
