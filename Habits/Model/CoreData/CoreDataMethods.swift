//
//  CoreDataClass.swift
//  Habits
//
//  Created by Alexander Thompson on 13/12/21.
//

import UIKit
import CoreData


class CoreDataMethods {
    
    //MARK: - Properties
    
    let persistentContainer: NSPersistentCloudKitContainer
    
    
    //MARK: - Class Funcs
    
    init() {
        persistentContainer = NSPersistentCloudKitContainer(name: "HabitEntities")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error)")
            }
        }
    }
}

extension CoreDataMethods {
    
    //MARK: - Functions
    
    /// Creates and saves a new habit in core data
    ///
    /// ```
    /// saveHabit(name: "Workout", icon: "barbell", frequency: 5, index: 2,  gradient: 5, dateCreated: Date(), notificationBool: true, alarmItem: alarmItem)
    /// ```
    /// - Parameter name: The name of the habit
    /// - Parameter icon: String name of the icon in assets
    /// - Parameter frequency: How many times per week the user wishes to do the habit
    /// - Parameter index: Index of the habit in core data array. Used to alter the order of habits if user manually changes them
    /// - Parameter gradient: the index of the gradient array to select a specific colour
    /// - Parameter dateCreated: todays date
    /// - Parameter notificationBool: A bool to determine is user has user notifications on or off
    /// - Parameter alarmItem: an item which contains details on alarms including time of alarm and days of the week to set it for.
    ///
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
            //If core data unable to save rolls back to previous core data commit.
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    ///Loads array of all saved habits in core data. Uses sort descriptor to load them in correct order user has saved them as order can be manually altered.
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
    
    ///Deletes all record of saved habit from core data including all saved dates.
    func deleteHabit(_ habit: HabitEnt) {
        persistentContainer.viewContext.delete(habit)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save:\(error)")
        }
    }
    
    ///Updates a previously existing habit in core data weith new values.
    func updateHabit() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    ///Func which allows the user to change the order of habits & save that new order to core data.
    func updateHabitOrder(sourceIndex: Int, destinationIndex: Int) {
        var array = loadHabitArray()
        let mover = array.remove(at: sourceIndex)
        array.insert(mover, at: destinationIndex)
        
        for (index, habit) in array.enumerated() {
            habit.habitOrder = Int16(index)
        }
        updateHabit()
    }
    
    ///Saves date to habit entity.
    func addHabitDate(habit: HabitEnt, date: Date) {
        let dateArray = fetchHabitDates(habit: habit)
        
        if !dateArray.contains(date) {
            let habitDate = HabitDates(context: persistentContainer.viewContext)
            habitDate.date = date
            habit.addToDatesSaved(habitDate)
            updateHabit()
        }
    }
    
    ///Removes date from habit entity.
    func removeHabitDate(habit: HabitEnt, date: Date) {
        let dateArray = fetchHabitDates(habit: habit)
        
        if dateArray.contains(date) {
            let habitDate  = HabitDates(context: persistentContainer.viewContext)
            habitDate.date = date
            for dateItem in habit.datesSaved?.allObjects as! [HabitDates] {
                if dateItem.date == date {
                    habit.removeFromDatesSaved(dateItem)
                }
            }
            updateHabit()
        }
    }
    
    
    ///Retrieves dates with a relationship to specific habit and adds them to an array.
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
    
    
    ///A method to convert days of the week for alarms into a single string in order to save to Core Data more efficiently.
    func convertStringArraytoBoolArray(alarmItem: AlarmItem) -> [Bool] {
        var boolArray: [Bool] = []
        let dayString         = alarmItem.days
        let dayArray          = Array(dayString)
        
        for day in dayArray {
            if day == "t" {
                boolArray.append(true)
            } else {
                boolArray.append(false)
            }
        }
        return boolArray
    }
    
    // TODO: Detrmine if both load habit funcs required.
    
    ///Retrieves dates with a relationship to specific habit and adds them to an array.
    func loadHabitDates(habit: HabitEnt) -> [Date] {
        let dates   = habit.datesSaved
        let set     = dates as? Set<HabitDates> ?? []
        let dateSet = set.map {$0.date!}
        return dateSet
    }
    
    
    ///Saves alarm data to activate alarmas for a habit if user has opted to.
    func saveAlarmData(habit: HabitEnt, alarmItem: AlarmItem) {
        if alarmItem.alarmActivated  == true {
            habit.notificationBool   = true
            habit.notificationDays   = alarmItem.days
            habit.notificationHour   = Int16(alarmItem.hour)
            habit.notificationMinute = Int16(alarmItem.minute)
        }
    }
    
}


