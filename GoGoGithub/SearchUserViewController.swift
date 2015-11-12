//
//  SearchUserViewController.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/12/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    var userArray = [User]()
    
    class func identifier() -> String {
        return "SearchUserViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GithubService.getUserWithSearch("heidi") { (userArray) -> () in
            self.userArray = userArray
        }
    }
    
    
    
    
    
}
