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
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
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
