package com.dag.lets_play.csv

import com.opencsv.CSVReader
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import java.io.InputStream
import java.io.InputStreamReader


@Component
class CsvHelper {
    fun parseStadiums(inputStream: InputStream): MutableList<CsvStadium> {
        val csvStadiums = mutableListOf<CsvStadium>()
        CSVReader(InputStreamReader(inputStream)).use { reader ->
            try {
                var row: Array<String>?
                // Логика на котлине аналогичная на java:
                // while ((row = reader.readNext()) != null)
                while (reader.readNext().also { row = it ?: null } != null) {
                    val rowElements = row!![0].split(";")
                    val csvStadium = CsvStadium(
                        rowElements[0].toDouble(),
                        rowElements[1].toDouble(),
                        rowElements[2],
                        if (rowElements.size > 3) rowElements[3] else null
                    )
                    csvStadiums.add(csvStadium)
                }
            } catch (e: Exception) {
                logger.error("Error during reading ${reader.recordsRead - 1} line. ", e)
            }
        }
        return csvStadiums
    }

    companion object {
        private val logger = LoggerFactory.getLogger(CsvHelper::class.java)
    }
}
