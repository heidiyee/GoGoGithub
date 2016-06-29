//
//  SearchTableViewCell.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/11/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit


class SearchTableViewCell: UITableViewCell {
    
    var repo: Repository? {
        didSet {
            self.titleLabel.text = repo?.name
            self.subtitleLabel.text = repo?.description
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    class func identifier() -> String {
        return "SearchTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
