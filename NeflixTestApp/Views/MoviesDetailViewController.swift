//
//  MoviesDetailViewController.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation
import UIKit

class MoviesDetailViewController : UIViewController {
  
  var providersCollection:UICollectionView?
  var providers: [MovieProviders] = []
  var movie_id = Int()
  var type = String()

  let DetailView = MoviesDetailView()

  override func viewDidLoad() {
    super.viewDidLoad()

    loadMovieDetail()
    loadProviders()
  }
  
  func loadMovieDetail(){
    let parametros: [String: Any] = ["id":movie_id, "type" : type]
    
    ApiManager.shared.GetMovieDetail(param: parametros) { (response) in
      DispatchQueue.main.async {
        
        //let myView = UIView(frame: CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: 300)) as! MoviesDetailView
        
        
        var myView = UIView(frame: CGRect(x: 0, y: 130, width: UIScreen.main.bounds.width, height: 300))
        
        self.DetailView.setup(with: response)
        self.DetailView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        
        myView.backgroundColor = .red
        myView.addSubview(self.DetailView)
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesTopViewControllerCell.identifier, for: indexPath) as! MoviesTopViewControllerCell
        
        self.view.addSubview(myView)
        
        
        //UICollectionView(frame: CGRect(x: 0, y: 400, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: providersLayout)

        
      }
    } fail: {
      print("fail")
    }
  }
  
  func loadProviders(){
    
    ApiManager.shared.getMoviesProviders(param: [:]) { (response) in
      DispatchQueue.main.async {
        self.providers = [response]
        
        let providersLayout = UICollectionViewFlowLayout.ProvidersCollectionLayout()
        self.providersCollection = UICollectionView(frame: CGRect(x: 0, y: 400, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: providersLayout)
        self.providersCollection?.backgroundColor = UIColor.backgroundAppColor
        self.providersCollection?.delegate = self
        self.providersCollection?.dataSource = self
        self.providersCollection?.register(MoviesProvidersViewControllerCell.self, forCellWithReuseIdentifier: MoviesProvidersViewControllerCell.identifier)
        
        self.providersCollection?.layer.zPosition = 9999
        self.view.addSubview(self.providersCollection ?? UICollectionView())
      }
    } fail: {
      print("fail")
    }
  }
  
  
}


extension MoviesDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return providers[0].results.count // How many cells to display
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesProvidersViewControllerCell.identifier, for: indexPath) as! MoviesProvidersViewControllerCell
    let provider = providers[0].results[indexPath.row]
    cell.setup(with: provider)
    
    return cell
    
    
  }
}

extension MoviesDetailViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if collectionView == self.providersCollection {
      
    }
    
  }
}

