//
//  WeatherData.swift
//  Clima
//
//  Created by Apple M1 on 18.01.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    var temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
