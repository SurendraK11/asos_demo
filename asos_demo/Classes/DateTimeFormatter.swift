//
//  DateTimeFormatter.swift
//  asos_demo
//
//  Created by Surendra on 10/10/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

///
/// This is helper struct to format given date/ time
///
struct DateTimeFormatter {
    
    static let dateFormat = "yyyy-MM-dd HH:mm:ss +SSSS"
    

    /// This is helper method to format date in expected format
    ///
    /// - Parameters:
    ///   - date: date which needs to be formated
    ///   - expectedFormat: expected date format
    ///   - dateFormat: format of given date
    /// - Returns: return date (string) in expected format
    static func UTCToLocal(date: String, expectedFormat: String, dateFormat: String = dateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let tempDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = expectedFormat
        let time = tempDate != nil ? dateFormatter.string(from: tempDate!) : ""
        return time
    }
    
}
