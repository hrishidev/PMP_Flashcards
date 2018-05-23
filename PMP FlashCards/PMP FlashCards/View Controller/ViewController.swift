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
    
    // MARK: View Outlet Methods
    var inshortBaseView = InshortsView(frame: CGRect.zero)
    @IBOutlet weak var toolbar: UIToolbar!
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
        self.updateColors()
    }
    
    override func viewWillLayoutSubviews() {
        self.inshortBaseView?.frame = baseViewForSwipeView.frame
        self.inshortBaseView?.layoutCards()
    }
    
    // MARK: Target Action Methods

    @IBAction func onAutoplayTapped(_ sender: Any) {
        
        print("onAutoPlayTapped")
    }
    
    @IBAction func onSettingsTapped(_ sender: Any) {
        
        let settingsViewController = SettingsViewController(nibName: String(describing: SettingsViewController.self), bundle: nil)
        self.present(settingsViewController, animated: true, completion: nil)
    }
    
    @IBAction func onVoiceOverTapped(_ sender: Any) {
        
        print("onVoiceOverTapped")
    }
    
}


// MARK: ThemeColorChangeResponser Methods

extension ViewController : ThemeColorChangeResponser {
    func addGradient(for colorSelection: ColorPalette) {
    }
    
    func updateColors () {
        
        let selectedTheme = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appTheme.rawValue)
        let colorSelection = ColorPalette(rawValue: selectedTheme)
        self.setColors(for: colorSelection!)
        inshortBaseView?.updateColors()
        
    }
    
    func setColors(for colorSelection : ColorPalette = .aqua ) {
        
        let selectedColor = UIColor.textColor(selection: colorSelection)
        self.autoPlay.tintColor = selectedColor
        self.voiceOver.tintColor = selectedColor
        self.settings.tintColor = selectedColor
        self.toolbar.barTintColor = UIColor.primaryFor(selection: colorSelection).lighter()
        
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
    
    func inshortsView(_ inshortsView: InshortsView!, viewForItemAt index: Int, reusing view: UIView!) -> PMPBaseView! {
        
        let baseView = PMPBaseView(frame: baseViewForSwipeView.frame)
        baseView.infoLabel.attributedText = viewModel?.displayString(At: index)
        return baseView 
    }
    
}
