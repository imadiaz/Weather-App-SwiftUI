//
//  WeatherRepositoryImplement.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import Foundation
import Combine
protocol WeatherRepository {
    func getWeatherByCity(city: String) -> AnyPublisher<City,Error>
    func getCities() -> [LocationEntity]
    func saveCity(city: City)
    func deleteCity(city: City)
}
struct WeatherRepositoryImplement:WeatherRepository {
    static let shared:WeatherRepositoryImplement = {
        return WeatherRepositoryImplement()
    }()
    private let remoteDataSource: RemoteWeatherDataSource = RemoteWeatherDataSource.shared
    private let localDataSource: LocalWeatherDataSource = LocalWeatherDataSource.shared

    
    func getWeatherByCity(city: String) -> AnyPublisher<City, Error> {
        return self.remoteDataSource.getWeatherByCity(city: city)
    }
    
    func getCities() -> [LocationEntity] {
        return self.localDataSource.getCities()
    }
    func saveCity(city: City){
        self.localDataSource.saveCity(city: city)
    }
    func deleteCity(city: City) {
        self.localDataSource.deleteCity(city: city)
    }
}
