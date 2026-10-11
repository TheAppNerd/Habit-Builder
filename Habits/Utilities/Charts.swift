//
//  ChartModel.swift
//  Habits
//
//  Created by Alexander Thompson on 15/12/21.
//

import UIKit

enum Charts {

    /// Creates an array of chartYears. It loads all the dates saved to a habit,  breaks each date down into which year it was completed and which month and adds 1 count for that month.
    /// Appends into an array of chartYears representing each year. If a date for a new year is added, this function will automatically add another chartYear for that new year into the dict.
    ///
    /// ```
    /// let chartYears = ChartModel.setChartData(habit: habitEntity)
    /// ```
    ///
    /// - Parameter habit: Returns habit saved in core data to pull its array of saved dates.
    /// - Returns: an array of Chartyears representing each year habits have been completed.
    static func setChartData(habit: HabitEnt) -> [ChartYear] {
        let calendar                 = Calendar.current
        let currentYear              = Date().getYear()
        var chartYears: [Int: [Int]] = [:]

        chartYears[currentYear]      = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        chartYears[currentYear-1]    = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        let habitDates               = CoreDataMethods.shared.loadHabitDates(habit: habit)
        
        for date in habitDates {
            let monthCalc            = calendar.dateComponents([.month], from: date)
            let yearCalc             = calendar.dateComponents([.year], from: date)
            let year                 = yearCalc.year!
            let month                = monthCalc.month!-1

            // Adds new year if year not currently in dict is added to.
            if !chartYears.keys.contains(year) {
                chartYears[year] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            }
            chartYears[year]?[month] += 1
        }
        var chartArray: [ChartYear] = []
        for year in chartYears {
            let chartYear = ChartYear(year: year.key, monthCount: year.value, color: Gradients.array[Int(habit.gradient)])
            chartArray.append(chartYear)
        }
        chartArray = chartArray.sorted { $0.year < $1.year }

        return chartArray
    }
}
