//
//  ViewController.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 07/04/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setPropertiesToDisplay ()  {
        self.numberOfLines = 0
        if #available(iOS 10.0, *) {
            self.backgroundColor = UIColor(displayP3Red: (186.0/255.0), green: (236.0/255.0), blue: (255.0/255.0), alpha: 1.0)
        } else {
            self.backgroundColor = UIColor(red:(186.0/255.0), green: (236.0/255.0), blue: (255.0/255.0), alpha: 1.0)
        }
        self.isOpaque = true
        self.isUserInteractionEnabled = true
    }
}

class ViewController: UIViewController , InshortsViewDataSource {

    var viewModel = ViewModel()
    func numberOfItems(in inshortsView: InshortsView!) -> Int {
        
        if let numberofItems = viewModel?.numberOfCards() {
            return numberofItems
        }
        return 0
    }
    
    func inshortsView(_ inshortsView: InshortsView!, viewForItemAt index: Int, reusing view: UIView!) -> UIView! {
         
        let infoLabel = UILabel(frame: self.view.frame)
        infoLabel.setPropertiesToDisplay()
        infoLabel.attributedText = viewModel?.displayString(At: index)
        return infoLabel as UIView

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red:0.73, green:0.93, blue:1.00, alpha:1.0)
        
        if let view = InshortsView(frame: self.view.frame) {
            view.dataSource = self
            self.view.addSubview(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

