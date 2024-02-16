//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 11.02.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func present(response: Home.GetLocation.Response)
    func present(request: Home.GetWeatherWithLoc.Response)
    func present(request: Home.GetWeatherWithCity.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Home.GetLocation.Response) {
        let viewModel = Home.GetLocation.ViewModel(lat: response.lat, lon: response.lon, name: response.name)
        viewController?.display(viewModel: viewModel)
    }
    
    func present(request: Home.GetWeatherWithLoc.Response) {
        let rows = rowBuilder(weather: request.mainWeatherEntity)
        
        viewController?.display(
            viewModel: Home.GetWeatherWithLoc.ViewModel(
                cells: rows,
                temp: (request.mainWeatherEntity.current?.temp ?? 0.0).toString(),
                image: UIImage(systemName: WeatherTypeIcon(weatherId: request.mainWeatherEntity.current?.weather?.first?.id ?? 0).getIcon()) ?? UIImage(),
                desc: request.mainWeatherEntity.current?.weather?.first?.description ?? "-"
            )
        )
    }
    
    func present(request: Home.GetWeatherWithCity.Response) {
        viewController?.display(
            viewModel: Home.GetWeatherWithCity.ViewModel(
                name: request.search.name ?? "-",
                temp: (request.search.main?.temp)?.toString() ?? "-",
                image: UIImage(systemName: WeatherTypeIcon(weatherId: request.search.weather?.first?.id ?? 0).getIcon()) ?? UIImage(),
                desc: request.search.weather?.first?.description ?? "-",
                lat: request.search.coord?.lat?.description ?? "",
                lon: request.search.coord?.lon?.description ?? ""
            )
        )
    }
    
    private func rowBuilder(weather: MainWeatherEntity) -> [Home.Rows] {
        var rows: [Home.Rows] = []
        
        for item in weather.daily ?? [] {
            rows.append(.dailyWeatherInfo(
                weather: MainWeatherEntity(
                    lat: weather.lat,
                    lon: weather.lon,
                    timezone: weather.timezone,
                    timezoneOffset: weather.timezoneOffset,
                    current: Current(
                        dt: weather.current?.dt,
                        sunrise: weather.current?.sunrise,
                        sunset: weather.current?.sunset,
                        temp: weather.current?.temp,
                        feelsLike: weather.current?.feelsLike,
                        pressure: weather.current?.pressure,
                        humidity: weather.current?.humidity,
                        dewPoint: weather.current?.dewPoint,
                        uvi: weather.current?.uvi,
                        clouds: weather.current?.clouds,
                        visibility: weather.current?.visibility,
                        windSpeed: weather.current?.windSpeed,
                        windDeg: weather.current?.windDeg,
                        windGust: weather.current?.windGust,
                        weather: getWeather(weather: item.weather ?? []),
                        pop: weather.current?.pop,
                        snow: weather.current?.snow,
                        rain: weather.current?.rain
                    ),
                    hourly: getHourlyWeather(hourlyWeather: weather.hourly ?? []),
                    daily: getDaily(weather: weather.daily ?? [])
                )
            )
            )
        }
        
        return rows
    }
    
    private func getHourlyWeather(hourlyWeather: [Current]) -> [Current] {
        var hourlyArray: [Current] = []
        
        for hourlyWeather in hourlyWeather {
            hourlyArray.append(
                Current(
                    dt: hourlyWeather.dt,
                    sunrise: hourlyWeather.sunrise,
                    sunset: hourlyWeather.sunset,
                    temp: hourlyWeather.temp,
                    feelsLike: hourlyWeather.feelsLike,
                    pressure: hourlyWeather.pressure,
                    humidity: hourlyWeather.humidity,
                    dewPoint: hourlyWeather.dewPoint,
                    uvi: hourlyWeather.uvi,
                    clouds: hourlyWeather.clouds,
                    visibility: hourlyWeather.visibility,
                    windSpeed: hourlyWeather.windSpeed,
                    windDeg: hourlyWeather.windDeg,
                    windGust: hourlyWeather.windGust,
                    weather: hourlyWeather.weather,
                    pop: hourlyWeather.pop,
                    snow: hourlyWeather.snow,
                    rain: hourlyWeather.rain
                )
            )
        }
        return hourlyArray
    }

    private func getDaily(weather: [Daily]) -> [Daily] {
        var dailyArray: [Daily] = []
        
        for item in weather {
            dailyArray.append(
                Daily(dt: item.dt,
                      sunrise: item.sunrise,
                      sunset: item.sunset,
                      moonrise: item.moonset,
                      moonset: item.moonrise,
                      moonPhase: item.moonPhase,
                      temp: item.temp,
                      feelsLike: item.feelsLike,
                      pressure: item.pressure,
                      humidity: item.humidity,
                      dewPoint: item.dewPoint,
                      windSpeed: item.windSpeed,
                      windDeg: item.windDeg,
                      windGust: item.windGust,
                      weather: item.weather,
                      clouds: item.clouds,
                      pop: item.pop,
                      snow: item.snow,
                      uvi: item.uvi,
                      rain: item.rain
                     )
            )
        }
        return dailyArray
    }
    
    private func getWeather(weather: [Weather]) -> [Weather] {
        var weatherArray: [Weather] = []
        
        for item in weather {
            weatherArray.append(
                Weather(id: item.id,
                        description: item.description
                       )
            )
        }
        
        return weather
    }
}
