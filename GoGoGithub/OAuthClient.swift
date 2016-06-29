//
//  OAuthClient.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/9/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

let kClientId = "client_id=d325e72fb3250a427806"
let kClientSecret = "client_secret=98c8c84c3c978c39977a5fc877e5ff0a2365de16"
let kOAuthAuthorize = "https://github.com/login/oauth/authorize"
let kOAuthTokenAccess = "https://github.com/login/oauth/access_token"
let kAccessTokenKey = "blah"


class OAuthClient {
    
    static let shared = OAuthClient()
    
    func requestGithubAccess(parameters: [String: String]) {
        
        var requestString = ""
        
        print(parameters)
        
        for (index, value) in parameters {
            print(index)
            print(value)
            requestString = requestString.stringByAppendingString("\(index)=\(value)")
        }
        
        print(requestString)
        
        guard let requestURL = NSURL(string: "\(kOAuthAuthorize)?\(kClientId)&scope=\(requestString)") else {return}
        UIApplication.sharedApplication().openURL(requestURL)
        
    }
    
    func exchangeForToken(code: String, completion: (success: Bool) -> ()) {
        // Once you get code, exchange for token
        // Add completion once you get a token

        print(code)
        
        guard let exchangeURL = NSURL(string: "\(kOAuthTokenAccess)?\(kClientId)&\(kClientSecret)&code=\(code)") else {return}
        let requestToken = NSMutableURLRequest(URL: exchangeURL)
        requestToken.HTTPMethod = "POST"
        requestToken.setValue("application/json", forHTTPHeaderField: "Accept")
        NSURLSession.sharedSession().dataTaskWithRequest(requestToken) { (data, response, error) -> Void in
            if let _ = error {
                print("this sucks")
            }
            if let data = data {
                do {
                    if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] {
                        if let accessToken = rootObject["access_token"] as? String {
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                let defaults = NSUserDefaults.standardUserDefaults()
                                defaults.setObject(accessToken, forKey: kAccessTokenKey)
                                completion(success: defaults.synchronize())
                            })
                        }
                    }
                    
                }catch _ {}
            }
            
            if let _ = response {
                print(":)")
            }
            
        }.resume()
        
    
    }
    
    func extractTemporaryCode(url: NSURL) -> String {
        guard let returnedURL = url.absoluteString.componentsSeparatedByString("=").last else {return "error"}
        return returnedURL
        
    }
    
    func accessToken() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(kAccessTokenKey)
    }
    

}
