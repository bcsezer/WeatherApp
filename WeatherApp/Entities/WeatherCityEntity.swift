//
//  WeatherCityEntity.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 16.02.2024.
//

import Foundation

// MARK: - Welcome
struct WeatherCityEntity: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let main: Main?
    let name: String?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
}
