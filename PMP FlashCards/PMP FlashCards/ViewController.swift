//
//  ViewController.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 07/04/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    var viewModel = ViewModel()
    
    // MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = InshortsView(frame: self.view.frame) {
            view.dataSource = self
            self.view.addSubview(view)
        }
    }
}

extension ViewController : InshortsViewDataSource {
    
    // MARK: InshortsViewDataSource Methods

    func numberOfItems(in inshortsView: InshortsView!) -> Int {
        
        if let numberofItems = viewModel?.numberOfCards() {
            return numberofItems
        }
        return 0
    }
    
    func inshortsView(_ inshortsView: InshortsView!, viewForItemAt index: Int, reusing view: UIView!) -> UIView! {
        
        let baseView = BaseView(frame: self.view.frame)
        baseView.infoLabel.attributedText = viewModel?.displayString(At: index)
        return baseView as UIView
    }
    
}
