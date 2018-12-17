//
//  Duration.swift
//  CarPooling
//
//  Created by archit rai saxena on 29/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import Foundation

prefix func - (duration: Duration) -> (Duration) {
    return Duration(value: -duration.value, unit: duration.unit)
}

class Duration {
    let value: Int
    let unit: NSCalendar.Unit
    fileprivate let calendar = (Calendar.autoupdatingCurrent as NSCalendar)
    
    /**
     Initialize a date before a duration.
     */
    var ago: Date {
        return ago(from: Date())
    }
    
    func ago(from date: Date) -> Date {
        return calendar.dateByAddingDuration(-self, toDate: date, options: .searchBackwards)!
    }
    
    /**
     Initialize a date after a duration.
     */
    var later: Date {
        return later(from: Date())
    }
    
    func later(from date: Date) -> Date {
        return calendar.dateByAddingDuration(self, toDate: date, options: .searchBackwards)!
    }
    
    init(value: Int, unit: NSCalendar.Unit) {
        self.value = value
        self.unit = unit
    }
}
