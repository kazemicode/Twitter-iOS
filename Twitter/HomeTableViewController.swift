//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sara Kazemi on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
   
    let twitterAPI = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    let params = ["count": 20]
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    
    @objc func loadTweets() {
        TwitterAPICaller.client?.getDictionariesRequest(url: twitterAPI, parameters: params, success: { (tweets: [NSDictionary]) in
            
            //  clean up tweetArray
            self.tweetArray.removeAll()
            // Append retrieved Tweets to tweetArray
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData() // repopulate tableView when array is updated
            // end refreshing
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("could not retrieve tweets!")
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        // pull to refresh
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }

    
    // Create an action for a logout button to perform logout
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        // set value for userLoggedIn to false
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cast our cell as a TweetCellTableViewCell to access our outlets
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        let user = tweetArray[indexPath.row]["user"] as? NSDictionary
        let imageUrl = URL(string: (user!["profile_image_url_https"]) as! String)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.userHandleLabel.text =  "@" + ((user!["screen_name"] as? String)!)
        cell.userNameLabel.text = user!["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
       
        return cell
    }
 

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    
}
