//
//  UserInfoViewController.swift
//  YourVoice
//
//  Created by Kuo Sabrina on 2017/3/29.
//  Copyright © 2017年 Sabrina Kuo. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var userProfile: UserInformation!

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyProfile()
        
    }
    
    func getMyProfile(){
        UserInformation.getUserInfomation { profile, error in
            if let error = error {
                print("get Profile error: \(error)")
                return
            }
            
            self.downloadImage(url: profile?.avatar)
            self.userProfile = profile
            self.titleLabel.text = profile?.name
            self.nameLabel.text = profile?.name
            self.ageLabel.text = "\(profile?.age)"
            self.genderLabel.text = profile?.gender   
        }
    }
    
    func downloadImage(url: URL!){
        
        if let avatarUrl = url {
            let session = URLSession.shared
            let task = session.dataTask(with: avatarUrl) { data, response, error in
                if let error = error {
                    print("download failed error: \(error)")
                    return
                }
                
                if let image = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }
            }
            task.resume()
            
        }
    }
}
