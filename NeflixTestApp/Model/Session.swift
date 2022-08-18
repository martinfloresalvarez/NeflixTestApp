//
//  Session.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation

struct Session: Codable{
  var success: Bool
  var session_id: String
  var status_message: String
  var status_code: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.success = try container.decodeIfPresent(Bool.self, forKey: .success) ?? false
    self.session_id = try container.decodeIfPresent(String.self, forKey: .session_id) ?? "Default"
    self.status_message = try container.decodeIfPresent(String.self, forKey: .status_message) ?? "Default"
    self.status_code = try container.decodeIfPresent(String.self, forKey: .status_code) ?? "Default"

  }
}
