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
    var repoURL: String!
    
    init(owner: Owner?, name: String, description: String?, repoURL: String!) {
        self.owner = owner
        self.name = name
        self.description = description
        self.repoURL = repoURL
    }
}