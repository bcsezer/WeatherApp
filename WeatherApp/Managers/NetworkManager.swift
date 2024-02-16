//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 16.02.2024.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    let provider = NetworkProvider<RemoteEndpoint>()
    
    func getWeather(lat: String, lon: String, completion: @escaping ClosureType<MainWeatherEntity>, failure: @escaping Failure) {
        provider.request(
            .getWeather(lan: lon, lat: lat),
            model: MainWeatherEntity.self,
            completion: completion,
            failure: failure
        )
    }
    
    func getWeatherWith(city: String, completion: @escaping ClosureType<WeatherCityEntity>, failure: @escaping Failure) {
        provider.request(
            .getWeatherByName(city: city),
            model: WeatherCityEntity.self,
            completion: completion,
            failure: failure
        )
    }
    
    func getNameFromCoordinates(lat: String, lon: String, completion: @escaping ClosureType<[CoordinateToNameEntity]>, failure: @escaping Failure) {
        provider.request(
            .getNameWithCoordinate(lan: lon, lat: lat),
            model: [CoordinateToNameEntity].self,
            completion: completion,
            failure: failure
        )
    }
}

