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

class HabitEntities {
    
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

extension HabitEntities {
    
    //works
    func saveHabit(name: String, icon: String, frequency: Int16, gradient: Int16, dateCreated: Date, notificationBool: Bool) {
        let habit = HabitEntity(context: persistentContainer.viewContext)
        habit.name = name
        habit.icon = icon
        habit.frequency = frequency
        habit.gradient = gradient
        habit.dateCreated = dateCreated
        habit.notificationBool = notificationBool
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    //works. need a fetch request for habit dates?
    func loadHabitArray() -> [HabitEntity] {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to load \(error)")
            return []
        }
    }
    
    //works
    func deleteHabit(_ habit: HabitEntity) {
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
    
    func setUserNotifications(_ habit: HabitEntity, days: String, time: String) {
        if habit.notificationBool == true {
            habit.notificationDays = days
            habit.notificationTime = time
            updateHabit()
        }
    }

    
    
    func addDate(habit: HabitEntity, date: Date) {
        let dates = habit.datesSaved
        let newDate = HabitDates()
        newDate.date = date
        dates?.adding(newDate)
        updateHabit()
        
        //alternative option
//        let myFetch:NSFetchRequest<entity2> = entity2.fetchRequest()
//            let myPredicate = NSPredicate(format: "toEntity1-relationship == %@", (myTransferdObject?.name!)!)
//            myFetch.predicate = myPredicate
//            do {
//                usersList = try myContext.fetch(myFetch)
//            }catch{
//                print(error)
//            }
    }
    
    func removeDate(habit: HabitEntity, date: Date) {
// for this to work I need to loop through all habit dates and if the date matches remove that one
    }
    
    func loadHabitDates(habit: HabitEntity) -> [Date] {
        let dates = habit.datesSaved
        let set = dates as? Set<HabitDates> ?? []
        let dateSet = set.map {$0.date!}
        return dateSet
    }
    
    func addHabitDate(index: Int) {
        //how do we ensure this saves to right habit?
        let habitDates = HabitDates(context: persistentContainer.viewContext)
         habitDates.date = Date()
        habitDates.dates?.addToDatesSaved(habitDates)
        
        let habitEntity = loadHabitArray()
        habitEntity[index].addToDatesSaved(habitDates)
        
    }
     
    func removeHabitDate(index: Int) {
        let entityArray = loadHabitArray()
        
    }
    
    
  
        
        
        
    }
    

