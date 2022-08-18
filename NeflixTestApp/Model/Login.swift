//
//  User.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation

struct Login: Codable{
  var success: Bool
  var expires_at: String
  var request_token: String
  var status_code: Int
  var status_message: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.success = try container.decodeIfPresent(Bool.self, forKey: .success) ?? false
    self.expires_at = try container.decodeIfPresent(String.self, forKey: .expires_at) ?? "Default"
    self.request_token = try container.decodeIfPresent(String.self, forKey: .request_token) ?? "Default"
    self.status_code = try container.decodeIfPresent(Int.self, forKey: .status_code) ?? 0
    self.status_message = try container.decodeIfPresent(String.self, forKey: .status_message) ?? "Default"

  }
  
}
