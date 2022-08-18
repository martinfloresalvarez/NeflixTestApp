//
//  UserDefaults.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation

extension UserDefaults{
  
  enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
  }
  func setLoggedIn(value: Bool) {
    set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }
  
  func isLoggedIn()-> Bool {
    return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
  }
  
  func setUserID(value: String){
    set(value, forKey: UserDefaultsKeys.userID.rawValue)
  }
  
  func getUserID() -> String{
    return string(forKey: UserDefaultsKeys.userID.rawValue)!
  }
}
