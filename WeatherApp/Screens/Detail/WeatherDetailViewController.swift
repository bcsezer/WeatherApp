//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 14.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeatherDetailDisplayLogic: AnyObject {
    func display(viewModel: WeatherDetail.GetData.ViewModel)
}

class WeatherDetailViewController: UIViewController, WeatherDetailDisplayLogic {
    var interactor: WeatherDetailBusinessLogic?

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var feelsLike: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = WeatherDetail.GetData.Request()
        interactor?.handle(request: request)
    }

    // MARK: Requests

    func display(viewModel: WeatherDetail.GetData.ViewModel) {
        nameLabel.text = viewModel.name
        temperatureLabel.text = viewModel.temp
        humidityLabel.text = viewModel.humidity
        feelsLike.text = viewModel.feelsLike
        windLabel.text = viewModel.wind
        pressureLabel.text = viewModel.pressure
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
