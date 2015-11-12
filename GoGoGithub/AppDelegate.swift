//
//  AppDelegate.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/9/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginViewController: LoginViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.presentLoginViewController()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let code = OAuthClient.shared.extractTemporaryCode(url)
    
        OAuthClient.shared.exchangeForToken(code) { (success) -> () in
            if success {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    
                    self.loginViewController!.view.alpha = 0.0
                    }, completion: { (finished) -> Void in
                        
                        self.loginViewController!.removeFromParentViewController()
                        self.loginViewController = nil
                        
                })
                
            }
        }
        
        return true
    }
    
    func presentLoginViewController() {
        
        if let token = OAuthClient.shared.accessToken() {
            print(token)
        } else {
            guard let mainViewController = self.window?.rootViewController as? UITabBarController, storyboard = mainViewController.storyboard else {return}
            guard let authViewController = storyboard.instantiateViewControllerWithIdentifier(LoginViewController.identifier()) as? LoginViewController else {return}
            
            self.loginViewController = authViewController
            
            mainViewController.addChildViewController(authViewController)
            mainViewController.view.addSubview(authViewController.view)
            authViewController.didMoveToParentViewController(mainViewController)
        }
        
    }

    

}

