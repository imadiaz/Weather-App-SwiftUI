//
//  LocalWeatherDataSource.swift
//  weather
//
//  Created by Ancient on 07/05/21.
//

import Foundation
import Combine
struct LocalWeatherDataSource {
    static let shared: LocalWeatherDataSource = {
        return LocalWeatherDataSource()
    }()
    private let coreData: PersistenceController = PersistenceController.shared
    
    func getCities() -> [LocationEntity]{
        return self.coreData.getLocations()
    }
    func saveCity(city: City){
        self.coreData.saveLocation(city: city)
    }
    func deleteCity(city: City){
        self.coreData.deleteCity(city: city)
    }
}
