//
//  RemoteWeatherDataSource.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import Foundation
import Combine
struct RemoteWeatherDataSource {
    static let shared: RemoteWeatherDataSource = {
        return RemoteWeatherDataSource()
    }()
    private let webService: WebService = WebService.shared
    
    func getWeatherByCity(city: String) -> AnyPublisher<City,Error> {
        return self.webService.getWeatherByCity(city: city)
    }
}
