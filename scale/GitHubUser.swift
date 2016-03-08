//
//  GitHubUser.swift
//  scale
//
//  Created by Johannes Boß on 08.03.16.
//  Copyright © 2016 Johannes Boß. All rights reserved.
//

import Foundation

class GitHubUser {
    var id : Int
    var login : String?

    init(jsonObject :AnyObject) {
        id = 0
        login = "test"
    }
}