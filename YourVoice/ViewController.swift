//
//  ViewController.swift
//  YourVoice
//
//  Created by sabrina.kuo on 2017/3/23.
//  Copyright © 2017年 Sabrina Kuo. All rights reserved.
//

import UIKit
import Koloda

private var NumberOfCards: Int = 5

class ViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    fileprivate var dataSource: [UIImage] = {
        var array: [UIImage] = []
        for index in 0..<NumberOfCards {
            array.append(UIImage(named: "Card_like_\(index + 1)")!)
        }
        
        return array
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    // MARK: IBActions
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped(_ sender: Any) {
        kolodaView?.revertAction()
    }
}

// MARK: KolodaViewDelegate

extension ViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = kolodaView.currentCardIndex
        for i in 1...4 {
            dataSource.append(UIImage(named: "Card_like_\(i)")!)
        }
        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
         UIApplication.shared.canOpenURL(URL(string: "https://yalantis.com/")!)
    }
}

// MARK: KolodaViewDataSource

extension ViewController: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: dataSource[index])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0]as? OverlayView
    }
}

