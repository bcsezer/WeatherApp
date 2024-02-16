//
//  Date+Extensions.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 15.02.2024.
//

import Foundation

extension Int {
    
    func dateAsString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
