//
//  CustomRepoCell.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/11/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit


class CustomRepoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    var repo: Repository? {
        didSet {
            self.titleLabel.text = repo?.name
            self.detailLabel.text = repo?.description
        }
    }
    
    class func identifier() -> String {
        return "CustomRepoCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
