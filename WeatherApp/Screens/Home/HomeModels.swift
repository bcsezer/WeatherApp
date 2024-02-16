//
//  HomeModels.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 11.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Home {

    // MARK: Use cases
    enum GetLocation {
        struct Request {
            let lat: String
            let lon: String
        }
        struct Response {
            let lat: String
            let lon: String
            let name: String
        }
        struct ViewModel {
            let lat: String
            let lon: String
            let name: String
        }
    }
    
    enum GetWeatherWithLoc {
        struct Request {
            let lat: String
            let lon: String
        }
        struct Response {
            let mainWeatherEntity: MainWeatherEntity
        }
        struct ViewModel {
            let cells: [Rows]
            let temp: String
            let image: UIImage
            let desc: String
        }
    }
    
    enum GetWeatherWithCity {
        struct Request {
            let city: String
        }
        struct Response {
            let search: WeatherCityEntity
        }
        struct ViewModel {
            let name: String
            let temp: String
            let image: UIImage
            let desc: String
            let lat: String
            let lon: String
        }
    }
    
    enum Rows {
        case dailyWeatherInfo(weather: MainWeatherEntity)
        
        func identifier() -> String {
            switch self {
            case .dailyWeatherInfo:
                return DailyWeatherCell.identifier
            }
        }
    }
}
