//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Trang Do on 10/6/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var follower: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var dateJoined: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var userInfo = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfile()
        // Do any additional setup after loading the view.
    }
    
    func loadProfile() {
        let url = "https://api.twitter.com/1.1/users/show.json"
        TwitterAPICaller.client?.getDictionaryRequest(url: url, parameters: ["screen_name": "@thuytrang0719"], success: {
            (NSDictionary) in
            self.userInfo = NSDictionary
         
            self.dateJoined.text = self.userInfo["created_at"] as? String
            self.handle.text = self.userInfo["screen_name"] as? String
            self.name.text = self.userInfo["name"] as? String
            let followerCount = self.userInfo["followers_count"] as? Int
            self.follower.text = "Follower: \(String(describing: followerCount))"
            let followingCount = self.userInfo["friend_count"] as? Int
            self.following.text = "Following: \(String(describing: followingCount))"

//            let profileImageURL = URL(string: (self.userInfo["profile_image_url_https"] as? String)!)
//            let data = try? Data(contentsOf: profileImageURL!)
//            let backgroundImageURL = URL(string: (self.userInfo["profile_image_url_https"] as? String)!)
//            let data1 = try? Data(contentsOf: backgroundImageURL!)
        }, failure: { (Error) in
            print("Could not retrieve tweets!")
            print(Error.localizedDescription)
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
