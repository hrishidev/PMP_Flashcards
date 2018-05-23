//
//  SettingsViewController.swift
//  PMPFlashCards
//
//  Created by Hrishikesh Devhare on 22/05/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController  {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var baseGradientView: UIView!
    
    var selectedTheme = ColorPalette(rawValue: 0)
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaultTheme = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appTheme.rawValue)
        selectedTheme = ColorPalette(rawValue: userDefaultTheme)
        self.setColors(for: selectedTheme!)

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onDismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onSaveButtonTapped(_ sender: Any) {

        UserDefaults.standard.set(selectedTheme?.rawValue, forKey: UserDefaultsKeys.appTheme.rawValue)
        UserDefaults.standard.synchronize()
        self.dismiss(animated: true, completion: nil)
    }
}


extension SettingsViewController : ThemeColorChangeResponser {
    
    func addGradient(for colorSelection : ColorPalette = .aqua) {
        
        let primaryColor = UIColor.primaryFor(selection: colorSelection).cgColor
        let secondaryColor = UIColor.secondaryColor(selection: colorSelection).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [primaryColor,secondaryColor]
        gradientLayer.frame = baseGradientView.bounds

        baseGradientView.layer.addSublayer(gradientLayer)

    }
    
    func updateColors() {
        
    }
    
    func setColors(for colorSelection: ColorPalette) {
        
        self.addGradient(for: colorSelection)
        
        let selectionColor = UIColor.textColor(selection: colorSelection)
        closeButton.tintColor = selectionColor
        saveButton.tintColor = selectionColor

    }
    
    
}
