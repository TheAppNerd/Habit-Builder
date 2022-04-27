//
//  AlarmItem.swift
//  Habits
//
//  Created by Alexander Thompson on 10/12/21.
//

import UIKit

///Item used to contain all relevent data to set up user notifications for a habit.
struct AlarmItem {
    var alarmActivated: Bool
    var title: String
    var days: String
    var hour: Int
    var minute: Int
}
