//
//  APIClient.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import Foundation

protocol WeatherServiceProtocol {
    func getCityWeather(completion: @escaping (_ success: Bool, _ results: Cities) -> ())
    func getCities(completion: @escaping (_ success: Bool, _ results: CityResults) -> ())
}

class WeatherService: WeatherServiceProtocol {
    func getCityWeather(completion: @escaping (Bool, Cities) -> ()) {
        HttpRequestHelper().GET(url: "http://api.openweathermap.org/data/2.5/group?id=4163971,2147714,2174003&units=metric&APPID=4c1b3c8789d7cdd231c34e869738f403", params: ["": ""]) { success, cities in
            if success {
                do {
                    completion(true, cities)
                } catch {
                    completion(false, [City]())
                }
            } else {
                completion(false, [City]())
            }
        }
    }
    
    func getCities(completion: @escaping (Bool, CityResults) -> ()){
        if let path = Bundle.main.path(forResource: "current.city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
                var entryArray = [CitySearch]()
                for obj in jsonArray {
                    let cityId = obj["id"] as! Int
                    let cityName = obj["name"] as! String
                    let entry = CitySearch(id: cityId, name: cityName)
                    entryArray.append(entry)
                }
                completion(true, entryArray)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                completion(false, [CitySearch]())
            }
        } else {
            print("Invalid filename/path.")
            completion(false, [CitySearch]())
        }
    }
}
