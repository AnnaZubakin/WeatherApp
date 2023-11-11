//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by anna.zubakina on 10/11/2023.
//

import Foundation

struct CurrentWeather:Codable{
    let location:Location
    let current:Current
}
