//
//  MADCalendarMonthModel.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

enum MADCalndarWeek: Int {
    case sunday     = 0
    case monday     = 1
    case thuesday   = 2
    case wednesday  = 3
    case thursday   = 4
    case friday     = 5
    case saturday   = 6
}

enum MADDayTag: Int {
    case currentMonth   = 0
    case perviousMonth  = 1
    case nextMonth      = 2
}

class MADCalendarDayModel: NSObject {
    
    var day: Int = 0
    
    var isToday: Bool = false
    
    var dayTag: MADDayTag = MADDayTag.currentMonth
    
    var isSelected: Bool = false
}

class MADCalendarMonthModel: NSObject {

    var date: Date? {
        willSet {
            if let _ = newValue {
                // privious date
                guard let priviousDate = newValue!.mad_previousMonthDate() else {
                    return
                }
//                // next date
//                guard let nextDate = newValue!.mad_nextMonthDate() else {
//                    return
//                }
                
                self.totalDays = newValue!.mad_daysInMonth()
                self.firstWeakdays = newValue!.mad_firstWeekDayInMonth()
                self.year = newValue!.mad_year()
                self.month = newValue!.mad_month()

                var totalNums = self.totalDays+self.firstWeakdays
                totalNums = (totalNums % 7) == 0 ? totalNums : (totalNums + 7 - (totalNums % 7))
                for index in 0..<totalNums {
                    
                    let model = MADCalendarDayModel.init()
                    
                    // if is pervious days
                    if index < self.firstWeakdays {
                        model.day = priviousDate.mad_daysInMonth() - (self.firstWeakdays - index) + 1
                        model.dayTag = MADDayTag.perviousMonth
                    }
                    // next month days
                    else if index >= (firstWeakdays + self.totalDays) {
                        
                        model.day = index - self.totalDays - self.firstWeakdays + 1
                        model.dayTag = MADDayTag.nextMonth
                    }
                    // current month days
                    else {
                        model.day = index - self.firstWeakdays + 1
                        model.dayTag = MADDayTag.currentMonth
                        
                        let currentDate = Date()
                        // current day
                        if  self.month == currentDate.mad_month(),
                            self.year == currentDate.mad_year(),
                            index == currentDate.mad_day() + self.firstWeakdays - 1 {
                            model.isToday = true
                        }
                    }
                    
                    self.dayArr.append(model)
                }
            }
        }
    }

    /// the num of days of this month
    var totalDays: Int = 0
    
    var firstWeakdays: Int = 0
    
    var year: Int = 0
    
    var month: Int = 0
    
    var dayArr = [MADCalendarDayModel]()
    
    static func modelWithDate(date: Date?) -> MADCalendarMonthModel {
     
        let model = MADCalendarMonthModel.init()
        model.date = date
        return model
    }
}
