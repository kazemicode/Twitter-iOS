//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sara Kazemi on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    
    var favorited: Bool = false
    var retweeted: Bool = false
    var tweetId: Int = -1
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // helper function for favoriteTweet
    func setFavorite(_isFavorited:Bool){
        favorited = _isFavorited
        // toggle image to red version if user has favorited tweet
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        // toggle image to grey version if user has unfavorited tweet
        else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    // need tweet ID
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(_isFavorited: true)
            }, failure: { (error) in
                print("Favoriting action did not succeed: \(error)" )
            })
        }
        else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(_isFavorited: false)
            }, failure: { (error) in
                print("Unfavoriting action did not succeed: \(error)" )
            })
        }
    }
    
    //helper function for retweet
    func setRetweet(_isRetweeted:Bool){
        retweeted = _isRetweeted
        // toggle retweet image to filled version if user retweets
        if(retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            //retweetButton.isEnabled = false
        } else {
            // toggle retweet icon to greyed out version if user unretweets
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            //retweetButton.isEnabled = true
        }
        
    }
    
    @IBAction func retweet(_ sender: Any) {
        let toBeReteeted = !retweeted
        if(toBeReteeted){
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweet(_isRetweeted: true)
            }, failure: { (error) in
                print("Retweeting action did not succeed: \(error)" )
            })
        }
        else {
            TwitterAPICaller.client?.unRetweet(tweetId: tweetId, success: {
                self.setRetweet(_isRetweeted: false)
            }, failure: { (error) in
                print("Unretweet action did not succeed: \(error)" )
            })
        }
    }
    
}
