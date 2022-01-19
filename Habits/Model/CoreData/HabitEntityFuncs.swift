//
//  CoreDataClass.swift
//  Habits
//
//  Created by Alexander Thompson on 13/12/21.
//

import UIKit
import CoreData

//Habit Home - load array of habits, add or remove dates from habits
//new habit - save new habit or edit existing habit
//habit details - add or remove dates. load array of dates

class HabitEntityFuncs {
    
    let persistentContainer: NSPersistentContainer

    
    init() {
        persistentContainer = NSPersistentContainer(name: "HabitEntities")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error)")
            }
        }
    }
}

extension HabitEntityFuncs {
    
    //works
    
    //MAKE A HABIT STRUCT AND ELIMINATE NEED FOR DATE STRUCT
    func saveHabit(habitStruct: habitStruct) {
        let habit = HabitEnt(context: persistentContainer.viewContext)
        habit.dateCreated = habitStruct.dateCreated
        habit.frequency = habitStruct.frequency
        habit.gradient = habitStruct.gradientIndex
        habit.icon = habitStruct.icon
        habit.name = habitStruct.name
        
        habit.notificationBool = habitStruct.notificationActivated
        //habit.notificationDays = //convert Array to string
        habit.notificationHour = habitStruct.notificationHour!
        habit.notificationMinute = habitStruct.notificationMinute!
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    //works
    func loadHabitArray() -> [HabitEnt] {
        let fetchRequest: NSFetchRequest<HabitEnt> = HabitEnt.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to load \(error)")
            return []
        }
    }
    
    //works
    func deleteHabit(_ habit: HabitEnt) {
        persistentContainer.viewContext.delete(habit)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save:\(error)")
        }
    }
    
    //works
    func updateHabit() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    //works. need to make sure date saved is start of day
    func addHabitDate(habit: HabitEnt, date: Date) {
        
        let dateArray = fetchHabitDates(habit: habit)
        
        if !dateArray.contains(date) {
        let habitDate = HabitDates(context: persistentContainer.viewContext)
        habitDate.date = date
        habit.addToDatesSaved(habitDate)
        updateHabit()
    }
    }
    
    
    //works
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
    
    
    func convertStringToBoolArray(string: String) -> [Bool] {
        var boolArray: [Bool] = []
        let dayArray = Array(string)
        
        for day in dayArray {
            if day == "T" {
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
    
    
    
  
        
        
        
    }
    


