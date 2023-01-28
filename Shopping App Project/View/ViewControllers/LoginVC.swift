//
//  LoginVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit
import FirebaseAuth


class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkCheck.shared.checkIt(presenter: self)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        view.addSubview(activityIndicator)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
            self.view.endEditing(true)
    }
    
    func startActivity(completion: @escaping () -> Void) {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator.stopAnimating()
            completion()
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {[weak self] authResult, error in
                if let error {
                    print(error.localizedDescription)
                    if self?.emailTextField.text == "" || self?.passwordTextField.text == "" {
                        self?.errorLabel.text = "fill in the required fields"
                    }else {
                        self?.errorLabel.text = "email or password is incorrect"
                    }
                    self?.emailTextField.text = ""
                    self?.passwordTextField.text = ""
                }else {
                    self?.errorLabel.text = ""
                    self?.startActivity() {
                        let mainScreen = self?.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
                        self?.navigationController!.pushViewController(mainScreen, animated: true)
                    }
                }
            }
        }
    }
}
