//
//  Constants.swift
//  Smack
//
//  Created by mugish on 02/10/18.
//  Copyright © 2018 mdadil2019. All rights reserved.
//

import Foundation

//URL Constants
let BASE_URL = "https://adilchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register/"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_CREATE = "\(BASE_URL)user/add"
//typealias is used for creating our own types
typealias CompletionHandler = (_ Success: Bool) -> ()

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE = "toCreate"
let UNWIND = "unwindToChannel"


//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers

let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]
