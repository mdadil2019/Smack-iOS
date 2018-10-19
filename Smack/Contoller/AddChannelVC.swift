//
//  AddChannelVC.swift
//  Smack
//
//  Created by Mohammad Adil on 19/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


    @IBAction func createButtonPressed(_ sender: Any) {
        
        
    }
    @IBAction func closedButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    func setupView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: smackPurpleColor])
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

}
