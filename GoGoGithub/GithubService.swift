//
//  GithubService.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/9/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit


class GithubService {
    
    
    class func getReposWithSearch(text: String, completion: (repositoryArray: [Repository]) -> Void) {
        
        //https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc
        if let token = OAuthClient.shared.accessToken() {
            guard let baseURL = NSURL(string: "https://api.github.com/search/repositories?access_token=\(token)&q=\(text)") else {return}
            print(baseURL)
            let request = NSMutableURLRequest(URL: baseURL)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                }
                if let data = data {
                    //print(data)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        if let repoArray = Repository.parseJSONToRepositoryWithSearch(data) {
                            completion(repositoryArray: repoArray)
                        }
                    })
                }
                if let _ = response {
                    //print(response)
                }
            }.resume()
        
        }
    }
    
    class func getUser(completion: (user: User) -> ())  {
        
        if let token = OAuthClient.shared.accessToken() {
            print(token)
            guard let baseURL = NSURL(string: "https://api.github.com/user?access_token=\(token)") else {return}
            let request = NSMutableURLRequest(URL: baseURL)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            //request.setValue(" token \(token)", forHTTPHeaderField: "Authorization:")

            
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                }
                if let data = data {
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        if let user = User.getUser(data) {
                            completion(user: user)
                        }
                    })
        
                }
                if let _ = response {
                    //print(response)
                }
            }.resume()
        }
    }
    
    class func postRepo(name: String) {
        do {
        
            if let token = OAuthClient.shared.accessToken() {
                guard let baseURL = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)") else {return}
                print(baseURL)
                let request = NSMutableURLRequest(URL: baseURL)
                
                var parameters = [String: String]()
                parameters["name"] = name
                
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.HTTPMethod = "POST"
                print(request)
            
                let parameterJSON = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted)
                request.HTTPBody = parameterJSON
            
                NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                    if let error = error {
                        print(error)
                    }
                    if let response = response as? NSHTTPURLResponse {
                        print(response)
                        print(response.statusCode)
                    }
                    if let data = data {
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            print(data)
                        })
                    }

                }.resume()
            }
        }catch _ {}
            
    }
    
    class func getRepos(completion: (repositoryArray: [Repository]) -> Void) {
        
        guard let baseURL = NSURL(string: "https://api.github.com/repositories?") else {return}
        let request = NSMutableURLRequest(URL: baseURL)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let error = error {
                print(error)
            }
            if let data = data {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    if let repoArray = Repository.parseJSONToRepository(data) {
                        completion(repositoryArray: repoArray)
                    }
                })

            }
            if let _ = response {
                //print(response)
            }
        }.resume()
        
        
    }

}
