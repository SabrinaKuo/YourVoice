//
//  BackgroundAnimationViewController.swift
//  YourVoice
//
//  Created by sabrina.kuo on 2017/3/23.
//  Copyright © 2017年 Sabrina Kuo. All rights reserved.
//

import UIKit
import Koloda
import Firebase
import FBSDKLoginKit
import pop

let numberOfCards: Int = 5
let frameAnimationSpringBounciness: CGFloat = 9
let frameAnimationSpringSpeed: CGFloat = 16
let kolodaCountOfVisibleCards = 2
let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

class BackgroundAnimationViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserPage" {
            
        }
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }

    //MARK: IBActions
    @IBAction func leftButtonTapped(_ sender: Any) {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped(_ sender: Any) {
//        kolodaView?.revertAction()
//        try!FIRAuth.auth()?.signOut()
//        let fbLoginManager = FBSDKLoginManager()
//        fbLoginManager.logOut()
    }
    
}

//MARK: KolodaViewDelegate
extension BackgroundAnimationViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.canOpenURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

// MARK: KolodaViewDataSource
extension BackgroundAnimationViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return numberOfCards
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: UIImage(named: "cards_\(index + 1)"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
