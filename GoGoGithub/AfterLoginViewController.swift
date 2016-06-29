//
//  AfterLoginViewController.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/10/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class AfterLoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var user: User?
    var array = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var searchArray = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepos()
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    class func identifier() -> String {
        return "AfterLoginViewController"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomRepoCell.identifier(), forIndexPath: indexPath) as! CustomRepoCell
        cell.repo = self.array[indexPath.row]
        
        return cell
        
    }
    
    func getRepos() {
        GithubService.getRepos { (repositoryArray) -> Void in
            self.array = repositoryArray
        }
    }
    
//    @IBAction func getReposWithSearchOption(sender: UIButton) {
//        GithubService.getUser { (user) -> () in
//            self.user = user
//            print(self.user?.name)
//        }
//    }
//    
    @IBAction func postRepo(sender: UIButton) {
        GithubService.postRepo("name")
    }
//
//    @IBAction func searchRepo(sender: UIButton) {
//        GithubService.getRepos { (repositoryArray) -> Void in
//            self.array = repositoryArray
//            print(self.array)
//        }
//    }
    
    
}
