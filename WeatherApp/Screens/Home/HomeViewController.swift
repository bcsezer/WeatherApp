//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 11.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation

protocol HomeDisplayLogic: AnyObject {
    func display(viewModel: Home.GetLocation.ViewModel)
    func display(viewModel: Home.GetWeatherWithCity.ViewModel)
    func display(viewModel: Home.GetWeatherWithLoc.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic, LocationManagerDelegate {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic)?
    let locationServiceManager = LocationServiceManager.shared
    let loadingManager = LoadingManager()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var search: UITextField!
    @IBOutlet private weak var locationName: UILabel!
    @IBOutlet private weak var degreeLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var weatherIcon: UIImageView!
    
    private let placeHolder = "Enter the city name"
    private var rows: [Home.Rows] = []
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        search.delegate = self
        apperance()
        DailyWeatherCell.registerWithNib(to: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineLocationUsage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func determineLocationUsage() {
        if locationServiceManager.checkLocationManagerAuthorization() {
            locationServiceManager.userLocationDelegate = self
        }
    }
    
    // MARK: Requests
    func userLocationUpdate(location: CLLocation?) {
        guard let location = location else { return }
        let lat = location.coordinate.latitude.description
        let lon = location.coordinate.longitude.description
        loadingManager.showUniversalLoadingView(true)
        interactor?.handle(request: Home.GetLocation.Request(lat: lat, lon: lon))
    }
    
    func display(viewModel: Home.GetLocation.ViewModel) {
        DispatchQueue.main.async {
            self.locationName.text = viewModel.name
        }
        interactor?.handle(request: Home.GetWeatherWithLoc.Request(lat: viewModel.lat, lon: viewModel.lon))
    }
    
    func display(viewModel: Home.GetWeatherWithCity.ViewModel) {
        DispatchQueue.main.async {
            self.loadingManager.showUniversalLoadingView(false)
            self.descLabel.text = viewModel.desc
            self.degreeLabel.text = viewModel.temp
            self.locationName.text = viewModel.name
            self.weatherIcon.image = viewModel.image
            self.search.text = ""
            self.search.placeholder = self.placeHolder
        }
        interactor?.handle(request: Home.GetWeatherWithLoc.Request(lat: viewModel.lat, lon: viewModel.lon))
    }
    
    func display(viewModel: Home.GetWeatherWithLoc.ViewModel) {
        DispatchQueue.main.async {
            self.loadingManager.showUniversalLoadingView(false)
            self.descLabel.text = viewModel.desc
            self.degreeLabel.text = viewModel.temp
            self.weatherIcon.image = viewModel.image
            self.rows = viewModel.cells
            self.tableView.reloadData()
        }
    }
    
    @IBAction func tapSearch(_ sender: Any) {
        self.view.endEditing(true)
        self.loadingManager.showUniversalLoadingView(true)
        interactor?.handle(request: Home.GetWeatherWithCity.Request(city: search.text ?? ""))
    }
    
    private func apperance() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: search.frame.height - 1, width: search.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        search.borderStyle = UITextField.BorderStyle.none
        search.layer.addSublayer(bottomLine)
        search.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3])
    }
}

extension HomeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if search.text != "" {
            return true
        } else {
            search.placeholder = placeHolder
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        search.text = textField.text
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier())
        
        switch row {
        case .dailyWeatherInfo(let weather):
            guard let cell = cell as? DailyWeatherCell else { return UITableViewCell() }
            cell.willDisplay(weather: weather, index: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        
        switch row {
        case .dailyWeatherInfo(let weather):
            guard let daily = weather.daily?[indexPath.row] else { return }
            router?.routeToDetail(weather: daily, name: self.locationName.text ?? "-")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
