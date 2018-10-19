//
//  AuthService.swift
//  Smack
//
//  Created by Mohammad Adil on 13/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    
    //creating singleton pattern
    static let instance = AuthService()
    
    //object to refer local preferences
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        //getter to check that if UserDefaults has key named with LOGGED_IN_KEY
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        //setter to set the value of the key LOGGED_IN_KEY as passed by user
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let body = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let body = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                //using SwiftyJSON to parse our json response
                do{
                    guard let data = response.data else {return}
               
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                
                }catch let error as NSError{
                    print(error)
                }
                self.isLoggedIn = true
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        Alamofire.request(URL_CREATE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                    guard let data = response.data else {return}
                    self.setUserInfo(data: data)
                    completion(true)
                }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func setUserInfo(data: Data){
        do{
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let email = json["email"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            let name = json["name"].stringValue
            UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    
}
