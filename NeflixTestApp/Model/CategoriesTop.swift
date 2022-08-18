//
//  CategoriesTop.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 17/08/22.
//

import Foundation

struct CategoriesTop: Codable {
  let results: [results]
  
  enum CodingKeys: String, CodingKey {
    case results = "results"
  }
}

struct results: Codable {
  let name:String
  let id: String
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case id = "id"
    
  }
}




