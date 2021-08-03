//
//  Data + Ext.swift
//  Habits
//
//  Created by Alexander Thompson on 3/8/21.
//

import Foundation
import UIKit

extension Data {
    
    func decode() -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(self) as? UIColor
    }
    
}
