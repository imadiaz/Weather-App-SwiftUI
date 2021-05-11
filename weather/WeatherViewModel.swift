//
//  WeatherViewModel.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation
class WeatherViewModel: ObservableObject {
    private let repository: WeatherRepositoryImplement =  WeatherRepositoryImplement.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var city: City?
    @Published var cityResult: City?
    @Published var cities: [City] = []
    @Published var citiesResult: [City] = []
    @Published var isSearching: Bool = false
    @Published var isLoading: Bool = false
    
    func getWeatherByCity(name: String){
        self.repository.getWeatherByCity(city: name)
            .sink(receiveCompletion: { completion in
                print("completion::")
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { response in
                self.cities.append(response)
                self.checkData()
            }).store(in: &cancellables)
    }
    
    func searchCity(city: String){
        if !self.isSearching {
            self.repository.getWeatherByCity(city: city)
                .sink(receiveCompletion: { completion in
                    print("completion::")
                    print(completion)
                    self.isSearching = false
                }, receiveValue: { response in
                    self.cityResult = response
                }).store(in: &cancellables)
        }
    }
    func addToList(city: City){
        self.repository.saveCity(city: city)
        self.citiesResult.append(city)
    }
    func isLocationsEmpty() -> Bool {
        self.isLoading = true
        let data =  self.repository.getCities()
        let myGroup = DispatchGroup()
        data.forEach{ element in
            myGroup.enter()
            self.getWeatherByCity(name: element.name!)
            myGroup.leave()
        }
        return !data.isEmpty
    }
    
    func checkData(){
        let data =  self.repository.getCities()
        if data.count == self.cities.count {
            self.isLoading = false
        }
    }
    func loadCities(){
        self.citiesResult = self.cities
    }
    
    func refreshCities(){
        self.isLoading = true
        let data =  self.repository.getCities()
        print(data.count)
        self.cities = []
        let myGroup = DispatchGroup()
        data.forEach{ element in
            myGroup.enter()
            self.getWeatherByCity(name: element.name!)
            myGroup.leave()
        }
        if data.isEmpty{
            self.isLoading = false
        }
    }
    func deleteCity(city: City){
        self.repository.deleteCity(city: city)
        self.citiesResult = self.citiesResult.filter { element in
            element.name != city.name
        }
        
    }
   
}



// @Published private var coordinates: CLLocationCoordinate2D?
// private var locationService: LocationManagerService?

//    init() {
//        self.locationService = LocationManagerService(completion: { value in
//            self.coordinates = value
//            self.getLocationWeather()
//        })
//    }
//
//
//func getLocationWeather(){
//    print("Cordinatess")
//   // print(self.coordinates)
//}

class LocationManagerService: NSObject,CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var completion: (CLLocationCoordinate2D) -> Void
    init(completion: @escaping (CLLocationCoordinate2D) -> Void) {
        self.completion = completion
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        super.init()
            
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates: CLLocationCoordinate2D =  manager.location?.coordinate else {return}
        print("Locattions:: \(coordinates)")
        self.completion(coordinates)
        
    }
    
    
}
