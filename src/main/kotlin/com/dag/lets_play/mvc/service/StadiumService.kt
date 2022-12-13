package com.dag.lets_play.mvc.service

import com.dag.lets_play.mvc.dao.StadiumDao
import com.dag.lets_play.mvc.model.GetStadiumRequest
import com.dag.lets_play.mvc.model.Stadium
import org.springframework.stereotype.Service

@Service
class StadiumService(private val dao: StadiumDao) {
    fun getStadiums(request: GetStadiumRequest): Set<Stadium> {
        return dao.getStadiums(request.location, request.radius)
    }

}
