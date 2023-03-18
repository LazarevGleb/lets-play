package com.dag.lets_play.stadium

import com.dag.lets_play.csv.CsvHelper
import jakarta.transaction.Transactional
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile

@Service
class StadiumService(
    private val dao: StadiumDao,
    private val mapper: StadiumMapper,
    private val csvHelper: CsvHelper
) {
    fun getStadiums(request: GetStadiumRequest): List<Stadium> {
        val point = mapper.locationToPoint(request.location)
        val stadiumEntities = dao.getStadiumsWithinDistance(point, request.distance)
        return stadiumEntities.map { mapper.toStadium(it) }
    }

    @Transactional
    fun create(stadium: Stadium): Stadium {
        val entity = mapper.toEntity(stadium)
        val savedEntity = dao.create(entity)
        logger.info("Saved stadium: $savedEntity")
        return mapper.toStadium(savedEntity)
    }

    @Transactional
    fun update(stadium: Stadium): Int {
        val entity = mapper.toEntity(stadium)
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
