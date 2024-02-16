//
//  HomeInteractor.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 11.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func handle(request: Home.GetLocation.Request)
    func handle(request: Home.GetWeatherWithCity.Request)
    func handle(request: Home.GetWeatherWithLoc.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Home.GetLocation.Request) {
        NetworkManager.shared.getNameFromCoordinates(lat: request.lat, lon: request.lon) { [weak self] result in
            self?.presenter?.present(response: Home.GetLocation.Response(lat: request.lat, lon: request.lon, name: result.first?.name ?? "-"))
        } failure: { error in
            print(error)
        }
    }
    
    func handle(request: Home.GetWeatherWithLoc.Request) {
        NetworkManager.shared.getWeather(lat: request.lat, lon: request.lon) { [weak self] result in
            self?.presenter?.present(request: Home.GetWeatherWithLoc.Response(mainWeatherEntity: result))
        } failure: { error in
            print(error)
        }
    }
    
    func handle(request: Home.GetWeatherWithCity.Request) {
        let editedText = request.city.replacingOccurrences(of: " ", with: "")
        NetworkManager.shared.getWeatherWith(city: editedText) { [weak self] result in
            self?.presenter?.present(request: Home.GetWeatherWithCity.Response(search: result))
        } failure: { error in
            print(error)
        }
    }
}
