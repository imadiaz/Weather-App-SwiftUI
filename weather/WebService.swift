//
//  WebService.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import Foundation
import Combine
class WebService {
    static let shared: WebService = {
        return WebService()
    }()
            
    var components: URLComponents  = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        return components
    }()
    
    func getWeatherByCity(city: String) -> AnyPublisher<City,Error>{
        self.components.path = "/data/2.5/weather"
        self.components.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: AppConstants.API_KEY),
                URLQueryItem(name: "units", value: "metric"),
        ]
        var request = URLRequest(url: self.components.url!)
        request.httpMethod = "GET"
        return URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            .decode(type: City.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
