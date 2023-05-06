package com.dag.lets_play.utils

import com.dag.lets_play.stadium.Location
import org.geolatte.geom.Position
import org.geolatte.geom.crs.CoordinateSystemAxis
import org.locationtech.jts.geom.Coordinate
import org.locationtech.jts.geom.GeometryFactory
import org.locationtech.jts.geom.Point
import org.locationtech.jts.geom.PrecisionModel

open class BaseMapper {

    fun locationToPoint(location: Location): Point {
        val coordinate = Coordinate(location.longitude, location.latitude)
        return geometryFactory.createPoint(coordinate)
    }

    fun pointToLocation(point: Point) = Location(point.y, point.x)

    fun positionToLocation(position: Position) = Location(
        position.getCoordinate(CoordinateSystemAxis.mkLatAxis()),
        position.getCoordinate(CoordinateSystemAxis.mkLonAxis())
    )

    companion object {
        private const val SRID = 4326
        val geometryFactory = GeometryFactory(PrecisionModel(), SRID)
    }
}
