//
//  Respository.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/11/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import Foundation

class Repository {
    
    var owner: Owner?
    var name: String?
    var description: String?
    
    init(owner: Owner?, name: String, description: String?) {
        self.owner = owner
        self.name = name
        self.description = description
    }
}