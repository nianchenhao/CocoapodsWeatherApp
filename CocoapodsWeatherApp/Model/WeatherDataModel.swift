//
//  WeatherDataModel.swift
//  CocoapodsWeatherApp
//
//  Created by 粘辰晧 on 2021/5/14.
//

import Foundation

class WeatherDataModel {
    var temp: Int = 0
    var condition: Int = 0
    var cityName: String = ""
    
    var weatherIconName: String = ""
    
    
    func updateIcon(conditionID: Int) -> String {
        switch conditionID {
        case 0...232:
            return "thunderstorm"
        case 300...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...731:
            return "mist"
        case 800:
            return "sunny"
        case 801...804:
            return "clouds"
        default:
            return "mist"
        }
    }
    
}
