//
//  Date+FormattedTime.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation

extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"
            
        }
    }
}
