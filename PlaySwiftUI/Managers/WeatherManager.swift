//
//  WeatherManager.swift
//  PlaySwiftUI
//
//  Created by Dhruv on 10/29/22.
//

import Foundation
import CoreLocation
import DBWeatherKit

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        
        let result = try await DBWeatherKit().getCurrentWeather(latitude: latitude, longitude: longitude) as? Data
                
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: result!)
        
        return decodedData
    }
}

// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Codable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Codable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Codable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Codable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Codable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
