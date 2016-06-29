//
//  UserCollectionViewCell.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/12/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    
    var user: User! {
        didSet {
            if let url = NSURL(string: user.avatar!) {
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
    
    class func identifier() -> String {
        return "UserCollectionViewCell"
    }

}
