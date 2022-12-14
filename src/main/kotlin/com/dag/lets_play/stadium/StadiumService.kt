package com.dag.lets_play.stadium

import org.springframework.stereotype.Service

@Service
class StadiumService(private val dao: StadiumDao) {
    fun getStadiums(request: GetStadiumRequest): Set<Stadium> {
        return dao.getStadiums(request.location, request.radius)
    }

}
