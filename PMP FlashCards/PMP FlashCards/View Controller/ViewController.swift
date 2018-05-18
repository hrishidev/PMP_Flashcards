//
//  ViewController.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 07/04/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit



final class ViewController: UIViewController {

    var viewModel = ViewModel()
    var inshortBaseView = InshortsView(frame: CGRect.zero)

    
    @IBOutlet weak var autoPlay: UIBarButtonItem!
    @IBOutlet weak var voiceOver: UIBarButtonItem!
    @IBOutlet weak var settings: UIBarButtonItem!
    
    @IBOutlet weak var baseViewForSwipeView: UIView!
    
    // MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        inshortBaseView?.dataSource = self
        self.view.addSubview(inshortBaseView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setColors(for: .aqua)
    }
    
    override func viewWillLayoutSubviews() {
        self.inshortBaseView?.frame = baseViewForSwipeView.frame
        self.inshortBaseView?.layoutCards()
    }
    
    func setColors(for colorSelection : ColorPalette) {
        
        self.autoPlay.tintColor = UIColor.textColor(selection: colorSelection)
        self.voiceOver.tintColor = UIColor.textColor(selection: colorSelection)
        self.settings.tintColor = UIColor.textColor(selection: colorSelection)

//        let textAttribute = [NSAttributedStringKey.foregroundColor : UIColor.primaryFor(selection: colorSelection) ]
//
//        self.autoPlay.setTitleTextAttributes(textAttribute, for: .normal)
//        self.voiceOver.setTitleTextAttributes(textAttribute, for: .normal)
//        self.settings.setTitleTextAttributes(textAttribute, for: .normal)
    }
    
    
    @IBAction func onAutoplayTapped(_ sender: Any) {
        
        print("onAutoPlayTapped")
    }
    
    @IBAction func onSettingsTapped(_ sender: Any) {
        
        print("onSettingsTapped")
    }
    
    @IBAction func onVoiceOverTapped(_ sender: Any) {
        
        print("onVoiceOverTapped")
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
        
        let baseView = BaseView(frame: baseViewForSwipeView.frame)
        baseView.infoLabel.attributedText = viewModel?.displayString(At: index)
        return baseView as UIView
    }
    
}
