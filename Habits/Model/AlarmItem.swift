//
//  AlarmItem.swift
//  Habits
//
//  Created by Alexander Thompson on 10/12/21.
//

import UIKit

struct AlarmItem {
    var alarmActivated: Bool
    var title: String
    var days: [Bool]
    var hour: Int
    var minute: Int
}

struct habitStruct {
    var dateCreated: Date
    var frequency: Int16
    var gradientIndex: Int16
    var icon: String
    var name: String
    var notificationActivated: Bool
    var notificationDays: [Bool]?
    var notificationHour: Int16?
    var notificationMinute: Int16?
}
