//
//  AvatarCell.swift
//  Smack
//
//  Created by Mohammad Adil on 15/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell(int: Int, type: AvatarType){
        if type == AvatarType.dark{
            imageView.image = UIImage(named: "dark\(int)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else{
            imageView.image = UIImage(named: "light\(int)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
