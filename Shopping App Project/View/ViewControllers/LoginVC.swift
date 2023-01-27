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
    let activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkCheck.shared.checkIt(presenter: self)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        view.addSubview(activityIndicator)
    }
    
    func startActivity() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        startActivity()
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error {
                    print(error.localizedDescription)
                }else {
                    let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
                    self.navigationController!.pushViewController(mainScreen, animated: true)
                }
            }
        }
    }
}
