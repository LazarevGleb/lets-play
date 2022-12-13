package com.dag.lets_play.stadium

data class GetStadiumRequest(val location: Location, val radius: Double)

data class Location(val latitude: String, val longitude: String)

data class Stadium(val name: String, val location: Location)
