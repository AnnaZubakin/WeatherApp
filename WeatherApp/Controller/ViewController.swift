//
//  ViewController.swift
//  WeatherApp
//
//  Created by anna.zubakina on 10/11/2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherConditions: UILabel!
    @IBOutlet weak var enterCityLabel: UILabel!
    @IBOutlet weak var weatherButton: UIButton!
    
    let apiKey:String = "c1a47d0ee6mshe50743f395f8652p10f154jsn9e62646a01a2"
        let apiHost:String = "weatherapi-com.p.rapidapi.com"
        let apiUrl:String = "https://weatherapi-com.p.rapidapi.com/current.json"
        let city: String = "Riga"
        
        var currentWeather:CurrentWeather?
    
    
    @IBAction func getWeatherButtonTapped(_ sender: Any) {
        loadWeatherData()
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            enterCityLabel.text = "Please enter a City"
//            loadWeatherData()
        }
        
        func loadWeatherData(){
            
            guard let city = cityTextField.text, !city.isEmpty else {
                weatherConditions.text = "We need a City name"
                        return
                    }
            
            let headers:[String:String] = ["X-RapidAPI-Key": apiKey,
                "X-RapidAPI-Host": apiHost]
            let params:[String:String] = ["q":city]
            AF.request(apiUrl,method: .get,parameters: params,headers: HTTPHeaders(headers)).responseDecodable(of:CurrentWeather.self){
                response in
                switch response.result{
                case .success(let value):
                    self.currentWeather = value
                    self.updateUI()
                    case .failure(let error):
                    self.weatherConditions.text = "City not found. Please enter a valid city name"
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
                let weatherText = "Location: \(cityTextField.text ?? "")\nTemp: \(current.tempC ?? 0)°C\nWind Speed: \(current.windKph ?? 0) km/h"
                weatherConditions.text = weatherText
            }
        }

    
