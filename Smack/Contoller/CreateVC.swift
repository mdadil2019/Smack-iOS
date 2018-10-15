//
//  CreateVC.swift
//  Smack
//
//  Created by mugish on 02/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

class CreateVC: UIViewController {

    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let password = passTxt.text, passTxt.text != "" else {return}
        guard let name = userNameTxt.text, userNameTxt.text != "" else {return}
        var avatarName = "profileDefault"
        var avatarColor = "[0.5, 0.5, 0.5, 1]"
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success{
                print("registered user!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success{
                        print("User has been successfully logged in",AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: avatarName, avatarColor: avatarColor, completion: { (success) in
                            if success{
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                print(avatarName)
                                
                            }
                        })
                    }
                })
            }
        }
        
    }
    @IBAction func closedPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
