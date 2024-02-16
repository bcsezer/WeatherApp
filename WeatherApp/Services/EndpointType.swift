//
//  EndpointType.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 11.02.2024.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
