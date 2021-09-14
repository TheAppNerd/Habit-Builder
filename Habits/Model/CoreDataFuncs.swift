//
//  CoreDataFuncs.swift
//  Habits
//
//  Created by Alexander Thompson on 5/8/21.
//

import UIKit

struct CoreDataFuncs {
    
 
    
    static func saveCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }

    
    
    public func loadData() {
        
    }
    
    

}
