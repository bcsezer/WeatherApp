//
//  WeatherDetailModels.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 14.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum WeatherDetail {
    
    // MARK: Use cases
    enum GetData {
        struct Request {
        }
        struct Response {
            let weatherEntity: Daily
            let name: String
        }
        struct ViewModel {
            let temp: String
            let feelsLike: String
            let humidity: String
            let wind: String
            let pressure: String
            let name: String
        }
    }
}
