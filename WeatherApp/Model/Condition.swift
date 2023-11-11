//
//  Condition.swift
//  WeatherApp
//
//  Created by anna.zubakina on 10/11/2023.
//


import Foundation

struct Condition: Codable {

  var text : String?
  var icon : String?
  var code : Int?

  enum CodingKeys: String, CodingKey {

    case text = "text"
    case icon = "icon"
    case code = "code"
  
  }

}
