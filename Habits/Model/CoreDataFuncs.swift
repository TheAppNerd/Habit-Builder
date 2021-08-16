//
//  CoreDataFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 5/8/21.
//

import UIKit

struct CoreDataFuncs {
    
static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func saveData() {
        
    }
    
    public func loadData() {
        
    }
    
    func getYear() -> Int {
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: today)
      
        return year
    }
    
    public func createNewYears(newHabit: HabitCoreData) {
        let newYear = HabitCoreYear(context: CoreDataFuncs.context)
        newYear.year = Int16(getYear())
        newYear.parentYears = newHabit
        newYear.january = []
        newYear.february = []
        newYear.march = []
        newYear.april = []
        newYear.may = []
        newYear.june = []
        newYear.july = []
        newYear.august = []
        newYear.september = []
        newYear.october = []
        newYear.november = []
        newYear.december = []
        
        newHabit.addToYears(newYear)
        
        
        let newYear2 = HabitCoreYear(context: CoreDataFuncs.context)
        newYear2.year = Int16(getYear()-1)
        newYear2.parentYears = newHabit
       newYear2.january = []
       newYear2.february = []
       newYear2.march = []
       newYear2.april = []
       newYear2.may = []
       newYear2.june = []
       newYear2.july = []
       newYear2.august = []
       newYear2.september = []
       newYear2.october = []
       newYear2.november = []
       newYear2.december = []
        newHabit.addToYears(newYear2)
    }
    
    
    
    
    
}
