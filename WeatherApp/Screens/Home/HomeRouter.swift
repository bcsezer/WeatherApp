//
//  HomeRouter.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 11.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic {
    func routeToDetail(weather: Daily, name: String)
}

class HomeRouter: NSObject, HomeRoutingLogic {
    weak var viewController: HomeViewController?

    // MARK: Routing Logic
    
    func routeToDetail(weather: Daily, name: String) {
        let detailVC = ViewControllerFactory.shared.makeWeatherDetail(weather: weather, name: name)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
