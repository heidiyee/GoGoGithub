//
//  GithubService.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/9/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit


class GithubService {
    
    class func getReposWithSearch(completion: (data: NSData?) -> Void) {
        
        //https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc

        let token = OAuthClient.shared.accessToken()
        guard let baseURL = NSURL(string: "/search/repositories?q=tetris+language:assembly&sort=stars&order=desc") else {return}
        let requestToken = NSMutableURLRequest(URL: baseURL)
        
        NSURLSession.sharedSession().dataTaskWithRequest(requestToken) { (data, response, error) -> Void in
            if let error = error {
                print(error)
            }
            if let data = data {
                print(data)
                completion(data: data)
            }
            if let response = response {
                print(response)
            }
        }
        

    }
    
}
