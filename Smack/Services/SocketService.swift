//
//  SocketService.swift
//  Smack
//
//  Created by Mohammad Adil on 19/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import UIKit
import SocketIO

let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = manager.defaultSocket
    
    func estanlishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName : String , channelDescription : String, completion : @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
        
    }
    
    func getChannel(completion : @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDescription = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion : @escaping CompletionHandler){
        
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        
        completion(true)
    }
    
    func getChatMessage(completion : @escaping CompletionHandler){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
             let userAvatarColor = dataArray[5] as? String 
            guard let userId = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                
                let newMessage = Message(message: msgBody, userId: userId, channelId: channelId, userName: userName, avatarName: userAvatar, avatarColor: userAvatarColor, timeStamp: timeStamp)
                
                MessageService.instance.messages.append(newMessage)
                NotificationCenter.default.post(name: Notification.Name("messageArrived"), object: nil)
                
                completion(true)
            } else{
                completion(true)
            }
        }
    }

}
