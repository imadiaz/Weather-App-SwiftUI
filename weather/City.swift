//
//  City.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import Foundation
import SwiftUI
// MARK: - City
struct City: Codable,Hashable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
}

extension City{
    func getTemp() -> String {
        return "\(Int(self.main.temp)) ºC"
    }
    func getMaxTemp() -> String {
        return "\(Int(self.main.tempMax)) ºC"
    }
    func getMinTemp() -> String {
        return "\(Int(self.main.tempMin)) ºC"
    }
    
    func getDescription() -> String {
        return self.weather[0].weatherDescription.capitalized 
    }
    
    func getHumidity() -> String {
        return "\(self.main.humidity) %"
    }
    
    func getVisibility() -> String {
        return "\(self.visibility) Km"
    }
    
    func getClouds() -> String {
        return "\(self.clouds.all) %"
    }
    
    func getWind() -> String {
        return "\(self.wind.speed) Km/h"
    }
    func getPressure() -> String {
        return "\(self.main.pressure) Km/h"
    }
    
    func getImage() -> String {
        switch self.weather[0].main {
        case "Clear":
            return AppConstants.SUNNY
        case "Clouds":
            return AppConstants.CLOUDY
        case "Snow":
            return AppConstants.SNOW
        case "Rain":
            return AppConstants.CLOUDY
        case "Drizzle":
            return AppConstants.THUNDERSTORM
        case "Thunderstore":
            return AppConstants.THUNDERSTORM
        default:
            return AppConstants.SUNNY
        }
    }
    
    func getIcon() -> String {
        switch self.weather[0].main {
        case "Clear":
            return "sun.max"
        case "Clouds":
            return "cloud"
        case "Snow":
            return "snow"
        case "Rain":
            return "cloud.rain"
        case "Drizzle":
            return "cloud.drizzle"
        case "Thunderstore":
            return "cloud.bolt"
        default:
            return "sun.max"
        }
    }
}


// MARK: - Clouds
struct Clouds: Codable,Hashable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable,Hashable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable,Hashable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable,Hashable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable,Hashable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable,Hashable {
    let speed: Double
    let deg: Int
}
