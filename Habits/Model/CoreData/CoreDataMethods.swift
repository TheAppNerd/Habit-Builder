//
//  CoreDataClass.swift
//  Habits
//
//  Created by Alexander Thompson on 13/12/21.
//

import UIKit
import CoreData


final class CoreDataMethods {

    // MARK: - Properties

    static let shared = CoreDataMethods()

    // MARK: - Class Methods

    private init() {}

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "HabitEntities")
        container.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error)")
            }
        }

        return container
    }()
}

extension CoreDataMethods {

    // MARK: - Methods

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
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }

    /// Loads array of all saved habits in core data. Uses sort descriptor to load them in correct order user has saved them as order can be manually altered.
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

    /// Deletes all record of saved habit from core data including all saved dates.
    func deleteHabit(_ habit: HabitEnt) {
        persistentContainer.viewContext.delete(habit)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save:\(error)")
        }
    }

    /// Updates a previously existing habit in core data weith new values.
    func updateHabit() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }

    /// Func which allows the user to change the order of habits & save that new order to core data.
    func updateHabitOrder(sourceIndex: Int, destinationIndex: Int) {
        var array = loadHabitArray()
        let mover = array.remove(at: sourceIndex)
        array.insert(mover, at: destinationIndex)

        for (index, habit) in array.enumerated() {
            habit.habitOrder = Int16(index)
        }
        updateHabit()
    }

    /// Saves date to habit entity.
    func addHabitDate(habit: HabitEnt, date: Date) {
        let dateArray = loadHabitDates(habit: habit)

        if !dateArray.contains(date) {
            let habitDate = HabitDates(context: persistentContainer.viewContext)
            habitDate.date = date
            habit.addToDatesSaved(habitDate)
            updateHabit()
        }
    }

    /// Removes date from habit entity.
    func removeHabitDate(habit: HabitEnt, date: Date) {
        let dateArray = loadHabitDates(habit: habit)

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

    /// A method to convert days of the week for alarms into a single string in order to save to Core Data more efficiently.
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

    /// Retrieves dates with a relationship to specific habit and adds them to an array.
    func loadHabitDates(habit: HabitEnt) -> [Date] {
        let dates   = habit.datesSaved
        let set     = dates as? Set<HabitDates> ?? []
        let dateSet = set.map {$0.date!}
        return dateSet
    }

    /// Saves alarm data to activate alarmas for a habit if user has opted to.
    func saveAlarmData(habit: HabitEnt, alarmItem: AlarmItem) {
        if alarmItem.alarmActivated  == true {
            habit.notificationBool   = true
            habit.notificationDays   = alarmItem.days
            habit.notificationHour   = Int16(alarmItem.hour)
            habit.notificationMinute = Int16(alarmItem.minute)
        }
    }

    /// Determines whether a specific date is already saved to a habits dates & either adds or removes the date from the list.
    func updateDates(selectedDate: Date, index: Int) {
        let habit = loadHabitArray()[index]
        let dates = loadHabitDates(habit: habit)
        if dates.contains(selectedDate) {
            removeHabitDate(habit: habit, date: selectedDate)
        } else {
            addHabitDate(habit: habit, date: selectedDate)
        }
    }

}
