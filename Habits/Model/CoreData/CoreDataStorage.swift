//
//  CoreDataClass.swift
//  Habits
//
//  Created by Alexander Thompson on 13/12/21.
//

import UIKit
import CoreData

//all data connections should use the core data funcs
//look at saved website for proper way to connect these.
//need to find optimal way to update and save dates and notifications to the correct habit
//notifications dont need to be seperate from habit entity. move them back and just make days and time optional

class CoreDataStorage {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataStorage")
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error)")
            }
        }
    }
}

extension CoreDataStorage {
    
    func saveHabit(name: String, icon: String, frequency: Int16, gradient: Int16, dateCreated: Date) {
        let habit = HabitEntity(context: persistentContainer.viewContext)
        habit.name = name
        habit.icon = icon
        habit.frequency = frequency
        habit.gradient = gradient
        habit.dateCreated = dateCreated
    
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save: \(error)")
        }
    }
    
    func loadHabit() -> [HabitEntity] {
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to load \(error)")
            return []
        }
    }
    
    func deleteHabit(_ habit: HabitEntity) {
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
    
    func setNotifications(index: Int) {
        let entityArray = loadHabit()
        let notifications = entityArray[index].notifications
        
        
    }
    
    func addHabitDate(index: Int) {
        //how do we ensure this saves to right habit?
        let habitDates = HabitDates(context: persistentContainer.viewContext)
         habitDates.date = Date()
        habitDates.dates?.addToDatesSaved(habitDates)
        
    }
     
    func removeHabitDate(index: Int) {
        let entityArray = loadHabit()
        
    }
    
}
