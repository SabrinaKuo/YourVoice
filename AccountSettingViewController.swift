//
//  AccountSettingViewController.swift
//  YourVoice
//
//  Created by sabrina.kuo on 2017/3/30.
//  Copyright © 2017年 Sabrina Kuo. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class AccountSettingViewController: UIViewController {

    
    @IBAction func SignOutTapped(_ sender: Any) {
        try!FIRAuth.auth()?.signOut()
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
    }

}
