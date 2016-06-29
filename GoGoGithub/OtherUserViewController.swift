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
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLogin: UILabel!

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
        self.userLogin.text = self.otherUser?.login
        if let url = NSURL(string: otherUser!.avatar!) {
            NSOperationQueue().addOperationWithBlock({ () -> Void in
                let imageData = NSData(contentsOfURL: url)!
                let image = UIImage(data: imageData)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.userImage.image = image
                })
            })
        }
    }
    
}
