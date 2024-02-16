//
//  URLs.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 12.02.2024.
//

import Foundation

struct URLs {
    static let v2 = "https://api.openweathermap.org/data/2.5/onecall?units=metric&appid=89575d3c850c4fe09a01e9aedf6aec9e&"
    static let withCity = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=89575d3c850c4fe09a01e9aedf6aec9e&q="
    static let cordinateToCity = "https://api.openweathermap.org/geo/1.0/reverse?appid=89575d3c850c4fe09a01e9aedf6aec9e&limit=1&"
}
