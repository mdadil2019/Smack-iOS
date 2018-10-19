//
//  LoginVC.swift
//  Smack
//
//  Created by mugish on 02/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var spinnerLogin: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closedPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if userNameTxt.text != "" && passwordTxt.text != ""{
            spinnerLogin.isHidden = false
            spinnerLogin.startAnimating()
            AuthService.instance.loginUser(email: userNameTxt.text!, password: passwordTxt.text!)       { (sucess) in
                AuthService.instance.findUserByEmail(completion: { (sucess) in
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                    self.spinnerLogin.isHidden = true
                    self.spinnerLogin.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                    
                })
            }
        }else{
            
        }
    }
    func setupView(){
        spinnerLogin.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
    }
    

}
