//
//  UIColor + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 26/11/21.
//

import UIKit

//change file name to cgcolor

extension CGColor {
    
    func encodeColor() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        
        func decodeColor(data: Data) -> UIColor? {
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
        }
    }
    
}
