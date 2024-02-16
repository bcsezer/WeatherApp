//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 16.02.2024.
//

import Foundation

extension Double {
    func toString() -> String {
        return String(format: "%.0f°",self)
    }
}
