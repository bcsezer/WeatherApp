//
//  WeatherDetailPresenter.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 14.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherDetailPresentationLogic {
    func present(response: WeatherDetail.GetData.Response)
}

class WeatherDetailPresenter: WeatherDetailPresentationLogic {
    weak var viewController: WeatherDetailDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: WeatherDetail.GetData.Response) {
        let viewModel = WeatherDetail.GetData.ViewModel(
            temp: response.weatherEntity.temp?.min?.toString() ?? "-",
            feelsLike: response.weatherEntity.feelsLike?.day?.description ?? "-",
            humidity: response.weatherEntity.humidity?.description ?? "-",
            wind: response.weatherEntity.windSpeed?.toString() ?? "-",
            pressure: (response.weatherEntity.pressure ?? 0).description,
            name: response.name
        )
        viewController?.display(viewModel: viewModel)
    }
}
