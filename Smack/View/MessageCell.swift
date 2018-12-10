//
//  MessageCell.swift
//  Smack
//
//  Created by Mohammad Adil on 20/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userImage: CircleImage!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var messageBodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCell(message: Message){
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.avatarName)
        if message.avatarColor != nil && message.avatarColor != "" {
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.avatarColor)
        }
    }
}
