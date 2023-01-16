//
//  RegisterVC.swift
//  Shopping App Project
//
//  Created by Davit Natenadze on 15.01.23.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
//    let navigation = UINavigationController()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    print("there was an error: \(error.localizedDescription)")
                }else {
                    
                    let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! ShoppingPage
                    self.navigationController!.pushViewController(mainScreen, animated: true)

//                    self.performSegue(withIdentifier: "mainScreenFromRegister", sender: self)
                }
            }
        }
        
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
