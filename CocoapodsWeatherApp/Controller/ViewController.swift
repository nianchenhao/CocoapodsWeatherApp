//
//  ViewController.swift
//  CocoapodsWeatherApp
//
//  Created by 粘辰晧 on 2021/5/7.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class ViewController: UIViewController, delegateProtocol {
    func newCityName(city: String) {
        print(city)
        
        //"q": city , "appid": apikey
        let keys: [String : String] = ["q" : city, "appid" : apiKey]
        
        getWeather(url: owLinkage, keys: keys)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSecondView"{
            let destVC = segue.destination as! SecViewController
            destVC.delegate = self
        }
    }
    
    
    @IBOutlet weak var tempLab: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLab: UILabel!
    
    let owLinkage = "http://api.openweathermap.org/data/2.5/weather"
    let apiKey = "9062feb07823a70cda2b3859c796714b"
    
    let weatherDataModel = WeatherDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 9062feb07823a70cda2b3859c796714b
        // api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
        // 22.666142890257017, 120.5048623548156
        // http://api.openweathermap.org/data/2.5/weather?lat=22.666142890257017&lon=120.5048623548156&appid=9062feb07823a70cda2b3859c796714b

        let latitude = 22.666142890257017
        let longtitude = 120.5048623548156
        
        let inputs: [String : String] = ["lat" : String(latitude), "lon" : String(longtitude), "appid" : apiKey ]
        
        SVProgressHUD.showInfo(withStatus: "loading")
        
        getWeather(url: owLinkage, keys: inputs)
        
    }

    func getWeather(url: String, keys: [String : String]) {
        
//        AF.request(url, method: .get, parameters: keys, encoder: URLEncodedFormParameterEncoder.default, headers: nil).responseJSON { (response) in
//
//            if response.value == nil{
//
//                print("Get data Error!")
//            }else{
//
//                //print(response.value)
//                // process JSON data
//                let weatherJSONData: JSON = JSON(response.value)
//
//                self.updateWeatherData(json: weatherJSONData)
//            }
//
//            }
        
        AF.request(url, method: .get, parameters: keys, encoder: URLEncodedFormParameterEncoder.default, headers: nil).responseJSON { response in
            let result = response.result
            print(response)
            //print(result)
            
            switch result{
            case .success(let value):
//                print("success")
//                let weatherJSONData: JSON = JSON(data: result)
//                self.updateWeatherData(json: weatherJSONData)
            
                let weatherJSONData: JSON = JSON(response.value)
                self.updateWeatherData(json: weatherJSONData)
//                if let JSON = value as? [String: Any] {
//
//                }
            case .failure(let error):
                
                if let underlyingError = error.underlyingError {
                    if let urlError = underlyingError as? URLError {
                        switch urlError.code {
                        case .timedOut:
                            print("Timed out error")
                        case .notConnectedToInternet:
                            print("Not connected")
                        default:
                            // Do something
                        print("Unmanaged error")
                        }
                    }
                }
                
            }
            
            
            
        }
    }
    
    
    func updateWeatherData(json: JSON) { //Data-->Model, View-->StoryBoard, Controller-->ViewController (MVC)
        if let temp = json["main"]["temp"].double {
            //print(temp)
            weatherDataModel.temp = Int(temp - 273.15)
            weatherDataModel.cityName = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateIcon(conditionID: weatherDataModel.condition)
            
            updateView()
        }else{
            print(json["message"])
        }
    }
 
    func updateView() {
        tempLab.text = String(weatherDataModel.temp) + "˚"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        cityLab.text = weatherDataModel.cityName
        
        SVProgressHUD.dismiss()
    }
    
    
    
}


