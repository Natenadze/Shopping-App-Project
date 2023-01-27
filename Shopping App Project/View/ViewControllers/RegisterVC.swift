//
//  RegisterVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
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
    
    @IBAction func registerPressed(_ sender: UIButton) {
        startActivity()
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    print("there was an error: \(error.localizedDescription)")
                }else {
                    
                    let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
                    self.navigationController!.pushViewController(mainScreen, animated: true)
                    
                    
                }
            }
        }
    }
}
