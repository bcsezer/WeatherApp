//
//  WeatherDetailInteractor.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 14.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherDetailBusinessLogic {
    func handle(request: WeatherDetail.GetData.Request)
}

class WeatherDetailInteractor: WeatherDetailBusinessLogic {
    var presenter: WeatherDetailPresentationLogic?
    var weather: Daily?
    var name: String?
    
    // MARK: Business Logic

    func handle(request: WeatherDetail.GetData.Request) {
        guard let name = name,
              let weather = self.weather
        else { return}
        
        
        let response = WeatherDetail.GetData.Response(weatherEntity: weather, name: name)
        presenter?.present(response: response)
    }
}
