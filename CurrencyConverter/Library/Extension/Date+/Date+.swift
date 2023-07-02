//
//  Date+.swift
//  CurrencyConverter
//
//  Created by APPLE on 23.05.2023.
//

import Foundation

extension Date {
    
    func offsetFrom(date: Date) -> Int {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        
        let minutes = Int(difference.minute ?? 0)
        
        if let minute = difference.minute, minute > 0 {
            return minutes
        }
        return 0
    }
}
