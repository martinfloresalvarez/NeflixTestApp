//
//  Token.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation

struct Token: Codable{
  var success: Bool
  var expires_at: String
  var request_token: String  
}
