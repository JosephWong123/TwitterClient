//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Joseph Wong on 5/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var userInfo : User = User(name: "", desc: "", followers: -1, following: -1, tweets: -1, profileURL: URL(string: "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png")!)
    
    override func viewDidLoad() {// Do any additional setup after loading the view.
        self.getUserInfo()
        self.setFieldsOnScreen()
        super.viewDidLoad()
        
        
    }
    
    func setFieldsOnScreen() {
        if userInfo.followers != -1 {
            nameLabel.text = userInfo.name
            tweetCount.text = "\(userInfo.tweets)"
            followingCount.text = "\(userInfo.following)"
            followerCount.text = "\(userInfo.followers)"
            descLabel.text = userInfo.desc
            let data = try? Data(contentsOf: userInfo.profileURL)
            
            if let imageData = data {
                profilePicture.image = UIImage(data: imageData)
            }
        }
        else {
            print("Something failed")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getUserInfo()
        self.setFieldsOnScreen()
        
        super.viewWillAppear(animated)
        
    }
    
    func getUserInfo() {
        let userInfoUrl = "https://api.twitter.com/1.1/account/verify_credentials.json"
        TwitterAPICaller.client?.getDictionaryRequest(url: userInfoUrl, parameters: [:], success: { (user: NSDictionary) in
            let temp = User(name: user["name"] as! String,
                        desc: user["description"] as! String,
                        followers: user["followers_count"] as! Int,
                        following: user["friends_count"] as! Int,
                        tweets: user["statuses_count"] as! Int,
                        profileURL: URL(string: user["profile_image_url_https"] as! String)!)
            self.userInfo = temp
        }, failure: { (Error) in
            print("Failed to retrieve user information: \(Error)")
        })

    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
