//
//  ChartModel.swift
//  Habits
//
//  Created by Alexander Thompson on 15/12/21.
//

import UIKit

class ChartModel {

    static func setChartData(habit: HabitEntity) -> [ChartYear] {
        let calendar = Calendar.current
        let currentYear = DateModel.getYear()
        var chartYears: [Int: [Int]] = [:]
        
        chartYears[currentYear] = [0,0,0,0,0,0,0,0,0,0,0,0]
        chartYears[currentYear-1] = [0,0,0,0,0,0,0,0,0,0,0,0]
        
        let habitDates = HabitEntities().loadHabitDates(habit: habit)
        
        for date in habitDates {
            let monthCalc = calendar.dateComponents([.month], from: date)
            let yearCalc = calendar.dateComponents([.year], from: date)
            let year = yearCalc.year!
            let month = monthCalc.month!-1
            
            //adds new year if year not currently in dict is added to.
            if !chartYears.keys.contains(year) {
                chartYears[year] = [0,0,0,0,0,0,0,0,0,0,0,0]
            }
            chartYears[year]![month] += 1
        }
        var chartArray: [ChartYear] = []
        for year in chartYears {
            let chartYear = ChartYear(year: year.key, monthCount: year.value, color: GradientArray.array[Int(habit.gradient)])
            chartArray.append(chartYear)
        }
        chartArray = chartArray.sorted { $0.year < $1.year }
        
        return chartArray
    }
}
