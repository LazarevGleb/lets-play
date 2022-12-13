package com.dag.lets_play.stadium

import org.springframework.stereotype.Service

@Service
class StadiumService {
    fun getStadiums(request: GetStadiumRequest): Set<Stadium> {
        // TODO
        return setOf(
            Stadium("Тестовый 1", Location("Где-то рядом", "Где-то здесь"))
        )
    }

}
