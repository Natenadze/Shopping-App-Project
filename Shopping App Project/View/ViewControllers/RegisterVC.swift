//
//  RegisterVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let activityIndicator2 = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    print("there was an error: \(error.localizedDescription)")
                }else {
                    self.startActivity() {
                        let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
                        self.navigationController!.pushViewController(mainScreen, animated: true)
                    }
                    
                    
                    
                }
            }
        }
    }
}
