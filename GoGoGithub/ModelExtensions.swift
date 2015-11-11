//
//  JSONParser.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/10/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

extension Repository {
    
    class func parseJSONToRepository(data: NSData) -> [Repository]? {
        
        var repoArray = [Repository]()

        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]] {
                for objects in rootObject {
                    if let ownerDictionary = objects["owner"] as? [String: AnyObject], name = objects["full_name"] as? String, description = objects["description"] as? String {
                        
                        let owner = Owner.getOwner(ownerDictionary)
                        let repo = Repository(owner: owner, name: name, description: description)
                        
                        repoArray.append(repo)
                    }
                }
                return repoArray
            }
            
            
        } catch _ {}

        
        return repoArray
    }
}

extension Owner {
    
    class func getOwner(dictionary: [String: AnyObject]) -> Owner? {
        
        if let login = dictionary["login"] as? String, id = dictionary["id"] as? Int, url = dictionary["url"] as? String {
            return Owner(id: id, login: login, url: url)
        }
        return nil
    }
    
}
