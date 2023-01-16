//
//  ViewController.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTitle(with: "CITY MALL")
    }
    
    func animateTitle(with title: String) {
        titleLabel.text = ""
        var charIndex = 0.0
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { _ in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    @IBAction func loginPressed (_ sender: UIButton) {
     
    }
    
    @IBAction func RegistrationPressed (_ sender: UIButton) {
   
    }

}

