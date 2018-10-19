//
//  SocketService.swift
//  Smack
//
//  Created by Mohammad Adil on 19/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }

    var socket : SocketIOClient = SocketIOClient(
}
