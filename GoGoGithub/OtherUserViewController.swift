//
//  OtherUserViewController.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/12/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

protocol OtherUserViewControllerDelegate  {
    func otherViewControllerDidFinish()
}

class OtherUserViewController: UIViewController {
    
    var otherUser: User?
    var delegate: OtherUserViewControllerDelegate?
    

    class func identifier() -> String {
        return "OtherUserViewController"
    }
    
    @IBAction func doneWithViewController (sender: UIStoryboardSegue){
        if let delegate = self.delegate {
            delegate.otherViewControllerDidFinish()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.otherUser?.login)
    }
    
}
