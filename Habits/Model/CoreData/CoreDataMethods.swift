//
//  CoreDataClass.swift
//  Habits
//
//  Created by Alexander Thompson on 13/12/21.
//

import UIKit
import CoreData


class CoreDataMethods {
    
    //MARK: - Constants
    
    let persistentContainer: NSPersistentCloudKitContainer
    
    
    //MARK: - Initialiser
    
    init() {
        print("object was allocated in memory")
        persistentContainer = NSPersistentCloudKitContainer(name: "HabitEntities")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error)")
            }
        }
    }
}

extension CoreDataMethods {

    //MARK: - Funcs
    
    func saveHabit(name: String, icon: String, frequency: Int16, index: Int,  gradient: Int16, dateCreated: Date, notificationBool: Bool, alarmItem: AlarmItem) {
        let habit              = HabitEnt(context: persistentContainer.viewContext)
        habit.name             = name
        habit.icon             = icon
        habit.habitOrder       = Int16(index)
        habit.frequency        = frequency
        habit.gradient         = gradient
        habit.dateCreated      = dateCreated
        habit.notificationBool = notificationBool
        saveAlarmData(habit: habit, alarmItem: alarmItem)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    
    func loadHabitArray() -> [HabitEnt] {
        let fetchRequest: NSFetchRequest<HabitEnt> = HabitEnt.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "habitOrder", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to load \(error)")
            return []
        }
    }
    
    
    func deleteHabit(_ habit: HabitEnt) {
        persistentContainer.viewContext.delete(habit)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save:\(error)")
        }
    }
    
    
    func updateHabit() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    
    func updateHabitOrder(sourceIndex: Int, destinationIndex: Int) {
        var array = loadHabitArray()
        let mover = array.remove(at: sourceIndex)
        array.insert(mover, at: destinationIndex)
        
        for (index, habit) in array.enumerated() {
            habit.habitOrder = Int16(index)
        }
        updateHabit()
    }
    
    
    func addHabitDate(habit: HabitEnt, date: Date) {
        let dateArray = fetchHabitDates(habit: habit)
        
        if !dateArray.contains(date) {
            let habitDate = HabitDates(context: persistentContainer.viewContext)
            habitDate.date = date
            habit.addToDatesSaved(habitDate)
            updateHabit()
        }
    }
    
    
    func removeHabitDate(habit: HabitEnt, date: Date) {
        let dateArray = fetchHabitDates(habit: habit)
        
        if dateArray.contains(date) {
            let habitDate = HabitDates(context: persistentContainer.viewContext)
            habitDate.date = date
            for dateItem in habit.datesSaved?.allObjects as! [HabitDates] {
                if dateItem.date == date {
                    habit.removeFromDatesSaved(dateItem)
                }
            }
            updateHabit()
        }
    }
    
    
    
    func fetchHabitDates(habit: HabitEnt) -> [Date] {
        let dates = habit.datesSaved?.allObjects as! [HabitDates]
        var dateArray: [Date] = []
        for attrib in dates {
            if let date = attrib.date {
                dateArray.append(date)
            }
        }
        return dateArray
    }
    
    
    //A method to convert days of the week for alarms into a single string in order to save to Core Data
    func convertStringArraytoBoolArray(alarmItem: AlarmItem) -> [Bool] {
        var boolArray: [Bool] = []
        let dayString = alarmItem.days
        let dayArray = Array(dayString)
        
        for day in dayArray {
            if day == "t" {
                boolArray.append(true)
            } else {
                boolArray.append(false)
            }
        }
        return boolArray
    }
    
    
    func loadHabitDates(habit: HabitEnt) -> [Date]{
        let dates = habit.datesSaved
        let set = dates as? Set<HabitDates> ?? []
        let dateSet = set.map {$0.date!}
        return dateSet
    }
    
    func saveAlarmData(habit: HabitEnt, alarmItem: AlarmItem) {
        if alarmItem.alarmActivated  == true {
            habit.notificationBool   = true
            habit.notificationDays   = alarmItem.days
            habit.notificationHour   = Int16(alarmItem.hour)
            habit.notificationMinute = Int16(alarmItem.minute)
        }
    }
    
    
}



