//
//  RoundedButton.swift
//  Smack
//
//  Created by Mohammad Adil on 14/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

@IBDesignable //we are using this annotation to update our story board whenever we make changes to this
              //layout builder class
class RoundedButton: UIButton {

    //@IBInspectable provide us the properties changning ability into the property viewer
    @IBInspectable var cornerRadius: CGFloat = 3.0{
        //whenever we set the values of this variable then didSet will be called
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    //when this view comes into existance then the function awakeFromNib is being called
    override func awakeFromNib() {
        self.setupView()
    }
    
    //whenever we make any changes in interface builder it will be called
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
