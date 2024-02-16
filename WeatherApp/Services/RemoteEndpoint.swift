//
//  RemoteEndpoint.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 12.02.2024.
//

import Foundation

enum RemoteEndpoint {
    case getWeather(lan: String, lat: String)
    case getWeatherByName(city: String)
    case getNameWithCoordinate(lan: String, lat: String)
}

extension RemoteEndpoint: EndpointType {
    var baseURL: URL {
        switch self {
        case .getWeather:
            guard let url = URL(string: URLs.v2) else { fatalError("baseURL could not be configured.")}
            return url
        case .getWeatherByName:
            guard let url = URL(string: URLs.withCity) else { fatalError("baseURL could not be configured.")}
            return url
        case .getNameWithCoordinate:
            guard let url = URL(string: URLs.cordinateToCity) else { fatalError("baseURL could not be configured.")}
            return url
        }
    }
    
    var path: String {
        switch self {
        case let .getWeather(lan, lat):
            return "lat=\(lat)&lon=\(lan)"
        case .getWeatherByName(let cityName):
            return cityName
        case let .getNameWithCoordinate(lan, lat):
            return "lat=\(lat)&lon=\(lan)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        case .getWeatherByName:
            return .get
        case .getNameWithCoordinate:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getWeather:
            return .requestParameters(
                bodyEncoding: .urlEncoding,
                urlParameters: .none
            )
        case .getWeatherByName:
            return .requestParameters(
                bodyEncoding: .urlEncoding,
                urlParameters: .none
            )
        case .getNameWithCoordinate:
            return .requestParameters(
                bodyEncoding: .urlEncoding,
                urlParameters: .none
            )
        }
    }
}
