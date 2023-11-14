//
//  ViewController.swift
//  WeatherApp
//
//  Created by anna.zubakina on 10/11/2023.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherConditions: UILabel!
    @IBOutlet weak var enterCityLabel: UILabel!
    @IBOutlet weak var weatherButton: UIButton!
    
        let apiKey:String = "c1a47d0ee6mshe50743f395f8652p10f154jsn9e62646a01a2"
        let apiHost:String = "weatherapi-com.p.rapidapi.com"
        let apiUrl:String = "https://weatherapi-com.p.rapidapi.com/current.json"
        let city: String = "Riga"
        
        var currentWeather:CurrentWeather?
        let locationManager = CLLocationManager()
        var locationString: String?
    
    
    @IBAction func getWeatherButtonTapped(_ sender: Any) {
 //       loadWeatherData()
        self.locationString = self.cityTextField.text!
        self.loadWeatherData()
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            enterCityLabel.text = "Please enter a City name:"
            weatherConditions.text = ""
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            loadWeatherData()
        }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[locations.count - 1]
            if location.horizontalAccuracy > 0 {
                self.locationManager.stopUpdatingLocation()
                let long = String(location.coordinate.longitude)
                let lat = String(location.coordinate.latitude)
                self.locationString = lat + "," + long
                self.loadWeatherData()
            }
            
        }
    
        func loadWeatherData(){
            
   /*         guard let city = cityTextField.text, !city.isEmpty else {
                weatherConditions.text = "We need a City name"
                        return
                    } */
            
            guard let location = self.locationString, !location.isEmpty else {
                weatherConditions.text = "We need a location"
                return
            }
            
            let headers:[String:String] = ["X-RapidAPI-Key": apiKey,
                "X-RapidAPI-Host": apiHost]
       //     let params:[String:String] = ["q":city]
            let params:[String:String] = ["q":location]
            AF.request(apiUrl,method: .get,parameters: params,headers: HTTPHeaders(headers)).responseDecodable(of:CurrentWeather.self){
                response in
                switch response.result{
                case .success(let value):
                    self.currentWeather = value
                    self.updateUI()
                    case .failure(let error):
            //        self.weatherConditions.text = "City not found. Please enter a valid City name"
                    self.weatherConditions.text = "Error fetching weather data. Please try again."
                    print(error)
                }
            }
        }
    
    
        
    func updateUI() {
      //      if let current = self.currentWeather?.current {
        guard let current = self.currentWeather?.current else {
                weatherConditions.text = ""
                return
            }
         /*       let weatherText = "Location: \(cityTextField.text ?? "")\nTemperature: \(current.tempC ?? 0)°C\nFeels Like: \(current.feelslikeC ?? 0)°C\nWind Speed: \(current.windKph ?? 0) km/h\nWind Direction: \(current.windDir ?? "")\nHumidity: \(current.humidity ?? 0)%"
                weatherConditions.text = weatherText
            } */
        
        
        var locationText = ""
            
            if let city = cityTextField.text, !city.isEmpty {
                locationText = "Location: \(city)\n"
            } else if let currentLocation = self.locationString, !currentLocation.isEmpty {
                locationText = "Current Location: \(currentLocation)\n"
            }
            
            let weatherText = "\(locationText)Temperature: \(current.tempC ?? 0)°C\nFeels Like: \(current.feelslikeC ?? 0)°C\nWind Speed: \(current.windKph ?? 0) km/h\nWind Direction: \(current.windDir ?? "")\nHumidity: \(current.humidity ?? 0)%"
            
            weatherConditions.text = weatherText
        }
        
        }

    
