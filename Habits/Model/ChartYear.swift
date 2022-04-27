//
//  ChartYear.swift
//  Habits
//
//  Created by Alexander Thompson on 28/9/21.
//

import UIKit

///Struct to hold collection view data on how many times habits were completed within a month. The monthCount includes 12 Ints which indicate the amount of times habit was completed each month.
struct ChartYear {
    var year: Int
    var monthCount: [Int]
    var color: [CGColor]
}
