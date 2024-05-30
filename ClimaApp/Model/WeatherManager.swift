//
//  WeatherManager.swift
//  Clima
//
//  Created by Apple M1 on 17.01.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=7d777f010144ab86975255e987edd841&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        perfromRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        perfromRequest(with: urlString)
    }
    
    func perfromRequest(with urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession.shared
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in

                if let error {
                    delegate?.didFailWithError(error: error)
                    return
                }

                guard let safeData = data else { return }
                guard let weather = parseJSON(safeData) else { return }
                
                delegate?.didUpdateWeather(weather)
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = WeatherModel(weatherData: decodedData)

            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
