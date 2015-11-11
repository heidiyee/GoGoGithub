//
//  User.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/11/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import Foundation


class Owner {
    
    var id: Int?
    var login: String?
    var url: String?
    
    init(id: Int?, login: String?, url: String?) {
        self.id = id
        self.login = login
        self.url = url
    }
}