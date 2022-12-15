package com.dag.lets_play.stadium

import org.springframework.stereotype.Service

@Service
class StadiumService(
    private val dao: StadiumDao,
    private val mapper: StadiumMapper
) {
    fun getStadiums(request: GetStadiumRequest): List<Stadium> {
        val stadiumEntities = dao.getStadiumsWithinDistance(request.location, request.distance)
        return stadiumEntities.map { e -> mapper.toStadium(e) }
    }
}
