//
//  UserViewController.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/11/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit
    
class UserViewController: UIViewController {
        
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    var user: User? {
        didSet {
            self.nameLabel.text = user?.name
            self.loginLabel.text = user?.login
        }
    }
    
    class func identifier() -> String {
        return "UserViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getUser()
    }
    
    func getUser() {
        GithubService.getUser { (user) -> () in
            self.user = user
        }
    }
    
}
