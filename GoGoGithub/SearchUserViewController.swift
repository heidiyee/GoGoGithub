//
//  SearchUserViewController.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/12/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

let kUserRegexPattern = "[ ]"

//protocol SearchUserViewControllerDelegate {
//    func searchUserViewControllerDidFinish()
//}

class SearchUserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UIViewControllerTransitioningDelegate, OtherUserViewControllerDelegate{
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    
//    let customTransition = CustomTransition(duration: 2.0)
    
    var userArray = [User]() {
        didSet {
            self.userCollectionView.reloadData()
        }
    }
    //var delegate: SearchUserViewControllerDelegate?
    
    class func identifier() -> String {
        return "SearchUserViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userCollectionView.delegate = self
        self.userCollectionView.dataSource = self
        self.userSearchBar.delegate = self
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = userCollectionView.dequeueReusableCellWithReuseIdentifier(UserCollectionViewCell.identifier(), forIndexPath: indexPath) as! UserCollectionViewCell
        let user = self.userArray[indexPath.row]
        cell.user = user
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.userArray = []
        
        do {
            let regex = try NSRegularExpression(pattern: kUserRegexPattern, options: .CaseInsensitive)
            if let text = userSearchBar.text {
                let matchCount = regex.numberOfMatchesInString(text, options: [], range: NSRange.init(location: 0, length: text.characters.count))
                print(matchCount)
                if matchCount > 0 {
                    let alertView = UIAlertController(title: "Error", message: "Username cannot include spaces", preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                        print("User selected Cancel...")
                    }
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                        print("User selected OK...")
                    }
                    
                    alertView.addAction(cancelAction)
                    alertView.addAction(okAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                } else {
                    GithubService.getUserWithSearch(text) { (userArray) -> () in
                        self.userArray = userArray
                    }
                }
            }
        } catch _ {}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == OtherUserViewController.identifier() {
            if let detailedViewController = segue.destinationViewController as? OtherUserViewController {
                
                guard let indexPaths = self.userCollectionView.indexPathsForSelectedItems() else {return}
                guard let myIndexPath = indexPaths.first else {return}
                let user = self.userArray[myIndexPath.row]
                detailedViewController.otherUser = user
                detailedViewController.delegate = self
                detailedViewController.transitioningDelegate = self
                
            }
        }
    }
    
//    @IBAction func doneWithViewController(sender: UIStoryboardSegue) {
//        if let delegate = self.delegate {
//            delegate.searchUserViewControllerDidFinish()
//        }
//    }
    
    func otherViewControllerDidFinish() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition(duration: 2.0)
    }

}
