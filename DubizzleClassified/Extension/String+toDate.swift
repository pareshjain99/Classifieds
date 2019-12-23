//
//  String+toDate.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation

extension String {
    
    func toDate(withFormat format: String = Constants.dateFormat)-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from:self)
        return date
        
    }
}
