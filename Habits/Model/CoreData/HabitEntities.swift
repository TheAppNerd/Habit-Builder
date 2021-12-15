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

//things the funcs need to do across app
//1. load up data for tableview
//2. add or remove a date then save
//3. set notifications on or off
//4. distinguish between new habit or existing habit
//5 delete habit

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

    func createHabit() {
        
        
    }
    
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
    
    func loadHabitArray() -> [HabitEntity] {
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
//
//    func setNotifications(index: Int) {
//        let entityArray = loadHabit()
//        let notifications = entityArray[index].notifications
//
//
//    }
    
    
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
//        let dates = habit.datesSaved
//       let set = dates as? Set<HabitDates> ?? []
//        let dateSet = set.map {$0.date}
//        return dateSet
//
//        updateHabit()
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
    

