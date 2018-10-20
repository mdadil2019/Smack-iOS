//
//  MessageService.swift
//  Smack
//
//  Created by Mohammad Adil on 19/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNEL,method: .get, parameters: nil, encoding:JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                guard let data = response.data else {return}
                
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LODED, object: nil)
                        completion(true)
                    }
                }catch{
                    
                }
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGE)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                self.clearMessages()
                
                guard let data = response.data else {return}
                do{
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userId: id, channelId: channelId, userName: userName, avatarName: userAvatar, avatarColor: userAvatarColor, timeStamp: timeStamp)
                            
                            self.messages.append(message)
                            
                        }
                        print(self.messages)
                        completion(true)
                    }
                }catch{
                    
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearMessages(){
        messages.removeAll()
    }
    func clearChannels(){
        channels.removeAll()
    }
    
    
}
