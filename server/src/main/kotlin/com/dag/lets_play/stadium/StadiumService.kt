package com.dag.lets_play.stadium

import com.dag.lets_play.csv.CsvHelper
import com.dag.lets_play.exception.StadiumNotFoundException
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.multipart.MultipartFile

@Service
class StadiumService(
    private val dao: StadiumDao,
    private val mapper: StadiumMapper,
    private val csvHelper: CsvHelper
) {

    fun getStadiumById(id: Long): Stadium {
        val entity = dao.findById(id)
        if (entity.isEmpty) {
            throw StadiumNotFoundException("Can't find stadium by id: $id")
        }
        return mapper.toStadium(entity.get())
    }

    fun getStadiumPreviews(request: GetStadiumRequest): List<StadiumPreview> {
        val point = mapper.locationToPoint(request.location)
        val resultSet = dao.getStadiumsWithinDistance(point, request.distance)
        return resultSet.map {
            val position = it.location.position
            StadiumPreview(it.id!!, mapper.positionToLocation(position))
        }.toList()
    }

    @Transactional
    fun create(stadium: Stadium): Stadium {
        val entity = mapper.toEntity(stadium)
        val savedEntity = dao.create(entity)
        logger.info("Saved stadium: $savedEntity")
        return mapper.toStadium(savedEntity)
    }

    @Transactional
    fun update(id: Long, stadium: Stadium): Int {
        val entity = mapper.toEntity(stadium, id)
        val rowsUpdated = dao.update(entity)
        if (rowsUpdated > 0) {
            logger.info("Updated stadium: $stadium")
        }
        return rowsUpdated
    }

    @Transactional
    fun deleteByLocation(location: Location): Int {
        val point = mapper.locationToPoint(location)
        val rowsDeleted = dao.deleteByPoint(point)
        if (rowsDeleted > 0) {
            logger.info("Removed stadium in location: $location")
        }
        return rowsDeleted
    }

    fun uploadStadiums(file: MultipartFile) {
        if ("text/csv" != file.contentType) {
            throw IllegalArgumentException("File must be csv")
        }

        val entities = csvHelper.parseStadiums(file.inputStream).map { mapper.toEntity(it) }

        logger.info("Parsed ${entities.size} rows")
        for (batch in entities.chunked(100)) {
            try {
                dao.create(batch)
            } catch (ignoreException: Exception) {
                // Одна ошибка не должна сломать загрузку всего списка
            }
        }
        logger.info("File successfully processed.")
    }

    companion object {
        private val logger = LoggerFactory.getLogger(StadiumService::class.java)
    }
}
