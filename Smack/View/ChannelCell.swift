//
//  ChannelCell.swift
//  Smack
//
//  Created by Mohammad Adil on 19/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func ConfigureCell(channel: Channel){
        let title = channel.channelTitle ?? ""
        channelLabel.text = title
    }

}
