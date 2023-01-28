//
//  RegisterVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let activityIndicator2 = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        NetworkCheck.shared.checkIt(presenter: self)
        activityIndicator2.center = view.center
        activityIndicator2.hidesWhenStopped = true
        activityIndicator2.style = .medium
        activityIndicator2.transform = CGAffineTransform(scaleX: 3, y: 3)
        view.addSubview(activityIndicator2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func startActivity(completion: @escaping () -> Void) {
        activityIndicator2.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator2.stopAnimating()
            completion()
        }
    }
    
    func register() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                
                if let error = error as? NSError  {
                    
                    if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                        switch errorCode {
                        case .weakPassword:
                            self?.errorLabel.text = "Password must be 6 or more characters"
                        case .invalidEmail:
                            self?.errorLabel.text = "Invalid email address"
                        case .emailAlreadyInUse:
                            self?.errorLabel.text = "Email address already in use"
                        default:
                            self?.errorLabel.text = "Error: \(error.localizedDescription)"
                        }
                    }
                    self?.emailTextField.text = ""; self?.passwordTextField.text = ""
                } else {
                    self?.startActivity() {
                        let mainScreen = self?.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
                        self?.navigationController!.pushViewController(mainScreen, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        register()
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        register()
        return true
    }
}
