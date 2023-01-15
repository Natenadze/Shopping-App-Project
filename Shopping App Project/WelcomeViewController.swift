//
//  ViewController.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginPressed (_ sender: UIButton) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
        
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func RegistrationPressed (_ sender: UIButton) {
        let registerVC = storyboard?.instantiateViewController(withIdentifier: "registerVC") as! RegisterVC
        
        navigationController?.pushViewController(registerVC, animated: true)
    }

}

