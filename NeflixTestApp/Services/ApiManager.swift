//
//  ApiManager.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation

class ApiManager{
  public static let shared = ApiManager()
  let apiKey = apiKey_themoviedb.develop.rawValue
  let versionApi = versionApi_themoviedb.latest.rawValue
  let lang = langApp()
  
  /*func getMoviesTop(param: [String : Any], success: @escaping (([Movies]) -> Void), fail: @escaping (() -> Void)){
    ServiceManager.shared.callService(urlString: "https://api.themoviedb.org/\(versionApi)/movie/popular?api_key=\(apiKey)&page=1&language=\(lang)", parametros: param, method: "POST"){
      (response: [Movies]) in
      success(response)
    } fail:{
      fail()
    }
  }*/
    
  func loginUser(param: [String : Any], success: @escaping ((Login) -> Void), fail: @escaping (() -> Void)){
    ServiceManager.shared.callService(urlString: "https://api.themoviedb.org/\(versionApi)/authentication/token/validate_with_login?api_key=\(apiKey)&language=\(lang)", parametros: param , method: "POST"){
      (response: Login) in
      success(response)
    } fail:{
      fail()
    }
  }
  
  func getToken2(param: [String : Any], success: @escaping ((Token) -> Void), fail: @escaping (() -> Void)){
    ServiceManager.shared.callService(urlString: "https://api.themoviedb.org/\(versionApi)/authentication/token/new?api_key=\(apiKey)&language=\(lang)", parametros: param , method: "GET"){
      (response: Token) in
      success(response)
    } fail:{
      fail()
    }
  }
  
  func getSession(param: [String : Any], success: @escaping ((Session) -> Void), fail: @escaping (() -> Void)){
    ServiceManager.shared.callService(urlString: "https://api.themoviedb.org/\(versionApi)/authentication/session/new?api_key=\(apiKey)&language=\(lang)", parametros: param , method: "POST"){
      (response: Session) in
      success(response)
    } fail:{
      fail()
    }
  }
  
  func getCategoriesTop(param: [String : Any], success: @escaping ((CategoriesTop) -> Void), fail: @escaping (() -> Void)){
    ServiceManager.shared.callService(urlString: "https://explormahahual.com/app/categories.php", parametros: param , method: "GET"){
      (response: CategoriesTop) in
      success(response)
    } fail:{
      fail()
    }
  }
  
  func getMoviesByCategories(param: [String : Any], success: @escaping ((Movies) -> Void), fail: @escaping (() -> Void)){
    
    let page = param["page"] ?? "1"
    let categories = param["categories"] ?? "movie/popular"

    ServiceManager.shared.callService(urlString: "https://api.themoviedb.org/3/\(categories)?api_key=\(apiKey)&language=\(lang)&page=\(page)", parametros: param , method: "GET"){
      (response: Movies) in
      success(response)
    } fail:{
      fail()
    }
  }
  

  
  func GetMovieDetail(param: [String : Any], success: @escaping ((MoviesDetail) -> Void), fail: @escaping (() -> Void)){
    let id = param["id"] ?? "1"
    let type = param["type"] ?? "movies"

      //https://api.themoviedb.org/3/tv/{tv_id}?api_key=<<api_key>>&language=en-US

    ServiceManager.shared.callService(urlString: "https://api.themoviedb.org/3/\(type)/\(id)?api_key=\(apiKey)&language=\(lang)&append_to_response=\(lang)", parametros: param , method: "GET"){
      (response: MoviesDetail) in
      success(response)
    } fail:{
      fail()
    }
  }
  
  
  //compañias productoras
  func getMoviesProviders(param: [String : Any], success: @escaping ((MovieProviders) -> Void), fail: @escaping (() -> Void)){
    
    ServiceManager.shared.callService(urlString: "https://api.themoviedb.org/3/watch/providers/movie?api_key=\(apiKey)&language=\(lang)", parametros: param , method: "GET"){
      (response: MovieProviders) in
      success(response)
    } fail:{
      fail()
    }
  }

  
  

  

  

}
