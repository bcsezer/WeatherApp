//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 14.02.2024.
//

import UIKit

class DailyWeatherCell: UITableViewCell {
    static let identifier = "DailyWeatherCell"

    @IBOutlet weak var minMaxLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func willDisplay(weather: MainWeatherEntity, index: Int) {
        dayLabel.text = weather.daily?[index].dt?.dateAsString()
        minMaxLabel.text = weather.daily?[index].temp?.max?.toString()
        iconImage.image = getIcon(id: weather.daily?[index].weather?.first?.id ?? 0)
    }
    
    private func getIcon(id: Int) -> UIImage? {
        UIImage(systemName: WeatherTypeIcon(weatherId: id).getIcon())
    }
}
