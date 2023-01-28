//
//  ViewController.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
            navigationController?.pushViewController(vc, animated: true)
        }

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titleLabel.animateTitle()
    }
    
    @IBAction func loginPressed (_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func RegistrationPressed (_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "registerVC") as! RegisterVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

