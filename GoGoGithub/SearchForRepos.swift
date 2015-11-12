//
//  SearchForRepos.swift
//  GoGoGithub
//
//  Created by Heidi Yee on 11/11/15.
//  Copyright © 2015 Heidi Yee. All rights reserved.
//

import UIKit

class SearchForRepos: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchReposBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    
    var array = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    class func identifier() -> String {
        return "SearchForRepos"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchReposBar.delegate = self
        self.tableView.dataSource = self
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(SearchTableViewCell.identifier(), forIndexPath: indexPath) as! SearchTableViewCell
        cell.repo = self.array[indexPath.row]
        
        return cell
        
    }
    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == "" {
//            isSearching = false
//            tableView.reloadData()
//        }
//    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.array = []
        if let text = searchReposBar.text{
            GithubService.getReposWithSearch(text, completion: { (array) -> Void in
                self.array = array
            })
            

        }
    }
    
}
