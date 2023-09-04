//
//  String+Extension.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import Foundation

extension String {
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en-US")
        let date = dateFormatter.date(from: self)
        
        return date
    }
}

extension Date {
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
