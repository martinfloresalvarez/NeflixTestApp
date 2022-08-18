//
//  ServiceManager.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation

class ServiceManager{
  
  public static let shared = ServiceManager()
  let idioma = langApp()
  
  func callService<T: Codable>(urlString: String, parametros: [String : Any], method: String, success: @escaping ((T) -> Void), fail: @escaping(() -> Void)){
    
    var animDictionary: [String: Any] = [:]
    animDictionary["idioma"] = idioma
    animDictionary.merge(parametros) {(current,_) in current}
    
    print("urlstring \(urlString)")
    
    let url = URL(string: urlString)
    guard let urlObj = url else { return }
    let session = URLSession.shared
    var request = URLRequest(url: urlObj)
    request.httpMethod = method
   
    if method == "POST"{
      request.addValue("application/json",forHTTPHeaderField: "Content-Type")
      request.addValue("application/json", forHTTPHeaderField: "Accpet")
      do {
        request.httpBody = try? JSONSerialization.data(withJSONObject: parametros)
      } catch let error {
        print("errorjson \(error.localizedDescription)")
      }
    }else{
      
    }
      
    let task: URLSessionDataTask = session.dataTask(with: request , completionHandler: {
      data, response, error in
      
      guard error == nil else { return }
      guard let data = data else { return }
      //print("url: \(urlString)")

      do {
        if let jsonString = String(data: data, encoding: .utf8) {
          print("success \(jsonString)")
        }
        let decoded = try JSONDecoder().decode(T.self, from: data)
        success(decoded)
      } catch {
        
        print("Error al decodificar JSON \(String(describing: error))")
        if let jsonString = String(data: data, encoding: .utf8) {
          print("jsonString \(jsonString)")
        }
        fail()
      }
    })
    task.resume()
    
  }
  
  /*func callService(urlFile: String, param: [String : Any], completion: @escaping (Data) -> Void) {
    
    let urlFind = URL(string: urlFile)
    var request = URLRequest(url: urlFind!)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: param)
    
    print("request: \(request)")
    
    URLSession.shared.dataTask(with:request, completionHandler: { (data, response, error) in
      guard let data = data, error == nil else { return }
      do {
        
        completion(data)
      } catch {
        print("error: \(error.localizedDescription)")
        
        completion(data)
      }
    }).resume()
  }*/
  
}
