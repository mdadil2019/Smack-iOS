//
//  GradiantView.swift
//  Smack
//
//  Created by mugish on 27/09/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit


@IBDesignable //live rendering of this view inside of the storyboard
class GradiantView: UIView {

    //creating properties that can be changed from storyboard
    //so when user select color then setNeedLayout will be called
    //that will eventually trigger a method layoutSubview()
    @IBInspectable var topColor: UIColor = UIColor.blue{
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.green{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    //after updating layout this function is called
    override func layoutSubviews() {
        let gradiantLayer = CAGradientLayer()
        
        //we can add as many colors as we want
        gradiantLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        gradiantLayer.startPoint = CGPoint(x: 0, y: 0)
        gradiantLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradiantLayer.frame = self.bounds
        
        //adding layers into the view we are creating
        self.layer.insertSublayer(gradiantLayer, at: 0)
        
    }
    

}
