//
//  WeatherTypeIcon.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 13.02.2024.
//

import Foundation

struct WeatherTypeIcon {
    var weatherId: Int?
    
    func getIcon() -> String {
        switch weatherId {
        case 200, 201, 202, 210, 211, 212, 221, 230,231,232:
            return "cloud.bolt.rain"
        case 300, 301, 302, 310, 311, 312, 313, 314, 321, 520, 521, 522, 531:
            return "cloud.drizzle"
        case 500, 501, 502, 503, 504:
            return "cloud.sun.rain"
        case 511, 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622:
            return "snow"
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801, 803, 804:
            return "cloud.sun"
        case 802:
            return "cloud"
        default:
            return ""
        }
    }
}
