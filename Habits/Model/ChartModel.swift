//
//  ChartModel.swift
//  Habits
//
//  Created by Alexander Thompson on 15/12/21.
//

import UIKit

class ChartModel {
    
    let chartYears: [Int: [Int]]
    
    init() {
        chartYears = [:]
    
    //goal. needs to take datecount for each month and year and be accessable
        static func setChartData(chartYears: ChartModel().chartYears) {
        var chartYears: [Int: [Int]] = [:]
        let currentYear = DateModel.getYear()
        
//        if chartYears.count == 0
//            let calendar = Calendar.current
//
//            //resets all charts to 0
//            for year in chartYears.keys {
//                chartYears[year] = [0,0,0,0,0,0,0,0,0,0,0,0]
//            }
//
//            guard habitCoreData?.habitDates != nil else { return }
//            for date in habitCoreData!.habitDates! {
//
//                let monthCalc = calendar.dateComponents([.month], from: date)
//                let yearCalc = calendar.dateComponents([.year], from: date)
//                let year = yearCalc.year!
//                let month = monthCalc.month!-1
//                //add if statement here to check if year in dict
//                if !chartYears.keys.contains(year) {
//                    chartYears[year] = [0,0,0,0,0,0,0,0,0,0,0,0]
//                }
//                chartYears[year]![month] += 1
//            }
//            chartArray = []
//            for year in chartYears {
//                let chartYear = ChartYear(year: year.key, monthCount: year.value, color: GradientArray.array[Int(habitCoreData!.habitGradientIndex)])
//                chartArray.append(chartYear)
//            }
//            chartArray = chartArray.sorted { $0.year < $1.year }
//
//            DispatchQueue.main.async {
//                self.habitDetailsChartView.collectionView.reloadData()
            }
}
    
    func addNewYear()

}
