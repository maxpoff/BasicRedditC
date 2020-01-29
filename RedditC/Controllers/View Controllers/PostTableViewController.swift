//
//  PostTableViewController.swift
//  RedditC
//
//  Created by Maxwell Poffenbarger on 1/29/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchposts()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MOPPostController.sharedInstance().posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}

        let post = MOPPostController.sharedInstance().posts[indexPath.row]
        
        cell.postTitleLabel.text = post.title
        MOPPostController.sharedInstance().fetchImage(for: post) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.postImageView.image = image
                }
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 7
    }
    
    //MARK: - Private Methods
    func fetchposts() {
        MOPPostController.sharedInstance().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Post was empty")
            }
        }
    }
    
}//End of class
