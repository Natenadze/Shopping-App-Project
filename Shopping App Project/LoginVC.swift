//
//  LoginVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
        self.navigationController!.pushViewController(mainScreen, animated: true)
    }
}
