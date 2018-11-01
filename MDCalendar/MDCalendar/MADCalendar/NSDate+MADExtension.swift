//
//  NSDate+MADExtension.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

extension Date {
    
    func mad_previousMonthDate() -> Date? {
        
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([Calendar.Component.year,
                                                  Calendar.Component.month,
                                                  Calendar.Component.day,], from: self)
        components.day = 15
        if components.month == 1 {
            components.month = 12
            
            guard let _ = components.year else {
                return nil
            }
            components.year = components.year! - 1
        }else {
            
            guard let _ = components.month else {
                return nil
            }
            components.month = components.month! - 1
        }
        
        return calendar.date(from: components)
    }
    
    func mad_nextMonthDate() -> Date? {
        
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([Calendar.Component.year,
                                                  Calendar.Component.month,
                                                  Calendar.Component.day,], from: self)
        components.day = 15

        if components.month == 12 {
            components.month = 1
            guard let _ = components.year else {
                return nil
            }
            
            components.year = components.year! + 1
        }else {
            guard let _ = components.month else {
                return nil
            }
            components.month = components.month! + 1

        }
        return calendar.date(from: components)
    }
    
    func mad_daysInMonth() -> Int {
        
        if let range = NSCalendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self) {
            
            return range.count
        }
        return 0
    }
    
    func mad_firstWeekDayInMonth() -> Int {
        
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([Calendar.Component.year,
                                                  Calendar.Component.month,
                                                  Calendar.Component.day,], from: self)
        components.day = 1
        
        guard let firstDay = calendar.date(from: components) else {
            return 1
        }

        guard let num = calendar.ordinality(of: Calendar.Component.weekday, in: Calendar.Component.weekOfMonth, for: firstDay)  else {
            return 1
        }
        
        return num - 1
    }
    
    func mad_year() -> Int {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([Calendar.Component.year], from: self)
        return components.year ?? 0
    }
    
    func mad_month() -> Int {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([Calendar.Component.month], from: self)
        return components.month ?? 0
    }
    
    func mad_day() -> Int {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([Calendar.Component.day], from: self)
        return components.day ?? 0
    }
}
