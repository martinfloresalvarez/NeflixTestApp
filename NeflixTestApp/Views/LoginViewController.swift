//
//  ViewController.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import UIKit

class LoginViewController: UIViewController {
      
  let loginContentView:UIView = {
    let view = UIView()
    view.backgroundColor = .green
    return view
  }()
  
  let userTextField: UITextField = {
    let textField = UITextField()
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.placeholder = "Nombre de usuario"
    return textField
  }()
  
  let passwordTextField: UITextField = {
    let textField = UITextField()
    textField.autocapitalizationType = .none
    textField.isSecureTextEntry = true
    textField.autocorrectionType = .no
    textField.placeholder = "Contraseña"
    return textField
  }()
  
  let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Entrar", for: .normal)
    button.addTarget(
      self,
      action: #selector(loginButtonPressed),
      for: UIControl.Event.touchUpInside)
    return button
  }()
  
  let statusLoginLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textAlignment = .center
    return label
  }()
  
  let loginSpinner: UIActivityIndicatorView = {
    let loginSpinner = UIActivityIndicatorView(style: .large)
    loginSpinner.translatesAutoresizingMaskIntoConstraints = false
    loginSpinner.hidesWhenStopped = true
    return loginSpinner
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.backgroundAppColor
    setupLoginContentView()
  }
  
  @objc func loginButtonPressed(sender: UIButton!) {
    guard let user = userTextField.text,
          !user.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
      return
    }
    guard let password = passwordTextField.text,
          !password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
      return
    }
    statusLoginLabel.text = "Comprobando datos"
    statusLoginLabel.textColor = .black
    
    loginButton.addSubview(loginSpinner)
    loginSpinner.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
    loginSpinner.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
    loginSpinner.startAnimating()
    
    ApiManager.shared.getToken2(param: [:]) { (response) in
      let parametros: [String: Any] = [
        "username": user,
        "password": password,
        "request_token": response.request_token
      ]
      
      ApiManager.shared.loginUser(param: parametros) { (response) in
        
        DispatchQueue.main.async {
          self.loginSpinner.stopAnimating()
        }
          if response.success{
            
            ApiManager.shared.getSession(param: ["request_token":response.request_token]) { (response) in
              DispatchQueue.main.async {
                self.statusLoginLabel.text = "Datos de acceso validos!"
                UserDefaults.standard.setLoggedIn(value: true)
                UserDefaults.standard.setUserID(value: response.session_id) // String
                
                self.isLoged(viewController: self)
                
              }
            } fail: {
              print("fail")
            }
            
          }else{
            DispatchQueue.main.async {
              self.statusLoginLabel.text = "Usuario o contraseña incorrectos"
              self.statusLoginLabel.textColor = .red
            }
          }
        
        
      } fail: {
        print("fail")
      }
    } fail: {
      print("fail token")
    }
  }
  
  
  func isLoged(viewController: UIViewController){
    let modalStyle = UIModalTransitionStyle.crossDissolve
    let mvc = RootViewController()
    mvc.modalPresentationStyle = .fullScreen
    mvc.modalTransitionStyle = modalStyle
    viewController.present(mvc, animated: true, completion: nil)
  }
  
}

extension LoginViewController {
  
  
  func setupLoginContentView() {
    view.addSubview(loginContentView)
    
    loginContentView.addSubview(userTextField)
    loginContentView.addSubview(passwordTextField)
    loginContentView.addSubview(loginButton)
    loginContentView.addSubview(statusLoginLabel)
    
    loginContentView.translatesAutoresizingMaskIntoConstraints = false //set this for Auto Layout to work!
    loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
    
    loginContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    loginContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    setupuserTextField()
    setupPasswordTextField()
    setupLoginButton()
    setuoStatusLabel()
    
  }
  
  func setupuserTextField() {
    userTextField.translatesAutoresizingMaskIntoConstraints = false
    userTextField.isUserInteractionEnabled = true
    userTextField.backgroundColor = .white
    
    userTextField.frame.size.width = 200
    userTextField.frame.size.height = 20
    
    userTextField.topAnchor.constraint(equalTo: loginContentView.topAnchor, constant: 40).isActive = true
    userTextField.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
    
    userTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    userTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  func setupPasswordTextField() {
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.isUserInteractionEnabled = true
    passwordTextField.backgroundColor = .white
    
    passwordTextField.frame.size.width = 200
    passwordTextField.frame.size.height = 20
    
    passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 40).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
    
    passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
  
  func setupLoginButton() {
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.isUserInteractionEnabled = true
    loginButton.backgroundColor = .white
    
    loginButton.frame.size.width = 100
    loginButton.frame.size.height = 30
    
    loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
    
    loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  
  func setuoStatusLabel(){
    statusLoginLabel.translatesAutoresizingMaskIntoConstraints = false
    statusLoginLabel.isUserInteractionEnabled = false
    
    statusLoginLabel.frame.size.width = 300
    statusLoginLabel.frame.size.height = 30
    
    statusLoginLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
    statusLoginLabel.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
    
    statusLoginLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    statusLoginLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
}
