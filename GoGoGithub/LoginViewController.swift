//
//  ViewController.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/9/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    class func identifier() -> String {
        return "LoginViewController"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "femalecoder.png")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonPressed(sender: UIButton) {
        OAuthClient.shared.requestGithubAccess(["scope" : "user,repo"])
        spinner.startAnimating()
    }

}

