//
//  File.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation
import UIKit


class MoviesViewController : UIViewController {
  
  var categoriesTopCollection:UICollectionView?
  let categoriesTopCollectionCell = "categoriesTopCollectionCell"
  
  var moviesTopCollection:UICollectionView?
  let moviesTopCollectionCell = "categoriesTopCollectionCell"
  
  var categoriasTop: [CategoriesTop] = []
  var movies: [Movies] = []

  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "TV Shows"
    let button = UIButton.NanigationBarButton()
    button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    let barButton = UIBarButtonItem(customView: button)
    self.navigationItem.rightBarButtonItem = barButton
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.titleNavigationBar]
    

    ApiManager.shared.getCategoriesTop(param: [:]) { (response) in
      DispatchQueue.main.async {
        
        self.categoriasTop = [response]
        
        
        let categoriesLayout = UICollectionViewFlowLayout.CategoriesCollectionLayout()
        self.categoriesTopCollection = UICollectionView(frame: self.view.frame, collectionViewLayout: categoriesLayout)
        self.categoriesTopCollection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.categoriesTopCollectionCell)
        self.categoriesTopCollection?.backgroundColor = UIColor.backgroundAppColor
        self.categoriesTopCollection?.dataSource = self
        self.categoriesTopCollection?.delegate = self
        
        self.view.addSubview(self.categoriesTopCollection ?? UICollectionView())
        self.loadMovies(categories: "movie/popular")
      }
    } fail: {
      print("fail")
    }
    
    
}

  func loadMovies(categories:String){
  let parametros: [String: Any] = ["page": 1,"categories": categories]
  
  ApiManager.shared.getMoviesByCategories(param: parametros) { (response) in
    DispatchQueue.main.async {
      self.movies = [response]

      let moviesLayout = UICollectionViewFlowLayout.MoviesCollectionLayout()
      self.moviesTopCollection = UICollectionView(frame: CGRect(x: 0, y: 160, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: moviesLayout)
      self.moviesTopCollection?.backgroundColor = UIColor.backgroundAppColor
      self.moviesTopCollection?.delegate = self
      self.moviesTopCollection?.dataSource = self
      self.moviesTopCollection?.register(MoviesViewControllerCell.self, forCellWithReuseIdentifier: MoviesViewControllerCell.identifier)

      self.moviesTopCollection?.layer.zPosition = 9999
      self.view.addSubview(self.moviesTopCollection ?? UICollectionView())
    }
  } fail: {
    print("fail")
  }
}
  
@objc func addTapped() {
  
 
  
  let alert = UIAlertController(title: "",
                                message: "¿Que quieres hacer?",
                                preferredStyle: .actionSheet)
  
  alert.addAction(UIAlertAction(title: "Ver perfil",
                                style: .default,
                                handler: { _ in
    //let mvc = UserViewController()
    //self.navigationController?.pushViewController(mvc, animated: true)
    let modalStyle = UIModalTransitionStyle.crossDissolve
    let mvc = UserViewController()
    mvc.modalPresentationStyle = .popover
    mvc.modalTransitionStyle = modalStyle
    self.present(mvc, animated: true, completion: nil)
    
  }))
  alert.addAction(UIAlertAction(title: "Cerrar sesion",
                                style: .destructive,
                                handler: { _ in
    UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.isLoggedIn.rawValue)
    UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultsKeys.userID.rawValue)
    
    let modalStyle = UIModalTransitionStyle.crossDissolve
    let mvc = LoginViewController()
    mvc.modalPresentationStyle = .fullScreen
    mvc.modalTransitionStyle = modalStyle
    self.present(mvc, animated: true, completion: nil)
    
    
  }))
  alert.addAction(UIAlertAction(title: "Cancelar",
                                style: .cancel,
                                handler: { _ in
    
  }))
  
  present(alert, animated: true, completion: nil)
}

}

extension MoviesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.categoriesTopCollection {
      return categoriasTop[0].results.count // How many cells to display
    }
    return movies[0].results.count // How many cells to display
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == self.categoriesTopCollection {
      let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesTopCollectionCell, for: indexPath)
      
      let titleLabel = UILabel.CategoriesLabel(text: categoriasTop[0].results[indexPath.row].name)
      Cell.contentView.addSubview(titleLabel)
      Cell.backgroundColor = UIColor.categoriesMainBackground
      UIView.CategoriesLabelConstraint(titleLabel: titleLabel, Cell: Cell)
      return Cell
    }
   
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesViewControllerCell.identifier, for: indexPath) as! MoviesViewControllerCell
    let profile = movies[0].results[indexPath.row]
    cell.setup(with: profile)    
    return cell
  }
}
extension MoviesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == self.categoriesTopCollection {
      
      self.loadMovies(categories: categoriasTop[0].results[indexPath.row].id)
      
    }else{
      print("User tapped on item \(indexPath.row)")
      let mvc = MoviesDetailViewController()
      self.navigationController?.pushViewController(mvc, animated: true)
    }
    
  }
}
