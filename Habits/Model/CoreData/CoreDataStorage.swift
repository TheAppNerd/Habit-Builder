//
//  CoreDataClass.swift
//  Habits
//
//  Created by Alexander Thompson on 13/12/21.
//

import UIKit
import CoreData

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
    
}
