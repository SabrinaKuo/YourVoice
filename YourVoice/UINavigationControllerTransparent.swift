//
//  UINavigationControllerTransparent.swift
//  YourVoice
//
//  Created by Kuo Sabrina on 2017/3/25.
//  Copyright © 2017年 Sabrina Kuo. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the navigation bar transparent
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.white
//        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Rubik-Medium", size: 20)!,
//                                                  NSForegroundColorAttributeName: UIColor.white]
        
    }
}
