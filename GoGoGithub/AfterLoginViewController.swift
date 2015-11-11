//
//  AfterLoginViewController.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/10/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class AfterLoginViewController: UIViewController {
    
    var user: String?
    class func identifier() -> String {
        return "AfterLoginViewController"
    }
    
    @IBAction func getReposWithSearchOption(sender: UIButton) {
        GithubService.getUser { (user) -> () in
            self.user = user
            print(self.user)
        }
    }
    
    @IBAction func postRepo(sender: UIButton) {
        
        GithubService.postRepo("blah")
    }
    
}
