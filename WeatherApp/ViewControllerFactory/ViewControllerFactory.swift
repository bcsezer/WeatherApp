//
//  ViewControllerFactory.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 11.02.2024.
//

import UIKit

struct ViewControllerFactory {
    static let shared = ViewControllerFactory()
    
    func makeHome() -> UIViewController {
        let viewController = HomeViewController(nibName: "HomeView", bundle: nil)
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
    
    func makeWeatherDetail(weather: Daily, name: String) -> UIViewController {
        let viewController = WeatherDetailViewController(nibName: "WeatherDetailView", bundle: nil)
        let interactor = WeatherDetailInteractor()
        let presenter = WeatherDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.name = name
        interactor.weather = weather
        presenter.viewController = viewController
        return viewController
    }
}
