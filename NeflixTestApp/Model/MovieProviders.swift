//
//  MovieProviders.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 18/08/22.
//

import Foundation

struct MovieProviders: Codable{
  let results: [results_providers]
  var status_message: String?
  var status_code: String?
  
  enum CodingKeys: String, CodingKey {
    case results = "results"
    case status_message = "status_message"
    case status_code = "status_code"

  }
}

struct results_providers: Codable {
  let display_priority:Int
  let logo_path: String
  let provider_name: String
  let provider_id: Int

  enum CodingKeys: String, CodingKey {
    case display_priority = "display_priority"
    case logo_path = "logo_path"
    case provider_name = "provider_name"
    case provider_id = "provider_id"

  }
}
