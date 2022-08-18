//
//  RootViewController.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation
import UIKit

class RootViewController : UINavigationController {

  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.backgroundAppColor
    let MoviesViewController = MoviesViewController()
    let navigationController = self
    navigationController.setViewControllers([MoviesViewController], animated: false)
    self.navigationBar.backgroundColor = UIColor.navigationBarColor
  }
  
}
