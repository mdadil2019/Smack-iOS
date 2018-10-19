//
//  ChatVC.swift
//  Smack
//
//  Created by mugish on 26/09/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //we are adding target to the menu btn by specifying the
        //what action to perform (selector) when user interact(for) with menuBtn
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        
        //adding gesture recognizers(built in -- pan and tap) so that we can respond to gesture reactions
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail { (sucess) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
            }
        }
        
    }

}
