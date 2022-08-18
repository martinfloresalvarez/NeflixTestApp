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
  var moviesTopCollection:UICollectionView?
  
  var categoriasTop: [CategoriesTop] = []
  var movies: [Movies] = []
  var categoryMovieSelected: String = "movie/popular"
  var categoryMovieType: String = "movie"

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
        self.categoriesTopCollection?.register(MoviesTopViewControllerCell.self, forCellWithReuseIdentifier: MoviesTopViewControllerCell.identifier)
        
        self.categoriesTopCollection?.backgroundColor = UIColor.backgroundAppColor
        self.categoriesTopCollection?.dataSource = self
        self.categoriesTopCollection?.delegate = self
        
        self.view.addSubview(self.categoriesTopCollection ?? UICollectionView())
        self.loadMovies()
      }
    } fail: {
      print("fail")
    }
    
    
}

  func loadMovies(){
  let parametros: [String: Any] = ["page": 1,"categories": categoryMovieSelected]
  
  ApiManager.shared.getMoviesByCategories(param: parametros) { (response) in
    DispatchQueue.main.async {
      self.categoriesTopCollection?.reloadData()
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
            
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesTopViewControllerCell.identifier, for: indexPath) as! MoviesTopViewControllerCell
      let categorias = categoriasTop[0].results[indexPath.row]
      cell.setup(with: categorias)
      
      if categoriasTop[0].results[indexPath.row].id == categoryMovieSelected{
        print("id: \(categoriasTop[0].results[indexPath.row].id)")
        cell.contentView.backgroundColor = UIColor.categoriesMainBackgroundSelected
      }else{
        cell.contentView.backgroundColor = UIColor.categoriesMainBackground
      }
      
      return cell
    }
   
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesViewControllerCell.identifier, for: indexPath) as! MoviesViewControllerCell
    let movie = movies[0].results[indexPath.row]
    cell.setup(with: movie)    
    return cell
  }
}
extension MoviesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == self.categoriesTopCollection {
      categoryMovieSelected = categoriasTop[0].results[indexPath.row].id
      categoryMovieType = categoriasTop[0].results[indexPath.row].type

      self.loadMovies()
      
    }else{
      print("User tapped on item \(indexPath.row)")
      let mvc = MoviesDetailViewController()
      mvc.movie_id = movies[0].results[indexPath.row].id
      mvc.type = categoryMovieType

      self.navigationController?.pushViewController(mvc, animated: true)
    }
    
  }
}
