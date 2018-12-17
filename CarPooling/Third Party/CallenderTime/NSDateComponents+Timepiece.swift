//
//  NSDateComponents+Timepiece.swift
//  CarPooling
//
//  Created by archit rai saxena on 29/11/18.
//  Copyright © 2018 Ajay Vyas. All rights reserved.
//

import Foundation

extension NSDateComponents {
    convenience init(_ duration: Duration) {
        self.init()
        switch duration.unit{
        case NSCalendar.Unit.day:
            day = duration.value
        case NSCalendar.Unit.weekday:
            weekday = duration.value
        case NSCalendar.Unit.weekOfMonth:
            weekOfMonth = duration.value
        case NSCalendar.Unit.weekOfYear:
            weekOfYear = duration.value
        case NSCalendar.Unit.hour:
            hour = duration.value
        case NSCalendar.Unit.minute:
            minute = duration.value
        case NSCalendar.Unit.month:
            month = duration.value
        case NSCalendar.Unit.second:
            second = duration.value
        case NSCalendar.Unit.year:
            year = duration.value
        default:
            () // unsupported / ignore
        }
    }
}
