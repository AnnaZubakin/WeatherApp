//
//  Location.swift
//  WeatherApp
//
//  Created by anna.zubakina on 10/11/2023.
//


import Foundation

struct Location: Codable {

  var name           : String?
  var region         : String?
  var country        : String?
  var lat            : Double?
  var lon            : Double?
  var tzId           : String?
  var localtimeEpoch : Int?
  var localtime      : String?

  enum CodingKeys: String, CodingKey {

    case name           = "name"
    case region         = "region"
    case country        = "country"
    case lat            = "lat"
    case lon            = "lon"
    case tzId           = "tz_id"
    case localtimeEpoch = "localtime_epoch"
    case localtime      = "localtime"
  
  }

}
