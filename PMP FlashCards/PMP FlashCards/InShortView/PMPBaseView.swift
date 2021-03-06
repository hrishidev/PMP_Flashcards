//
//  BaseView.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 15/05/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit


protocol ThemeColorChangeResponser {
    func updateColors()
    func setColors(for colorSelection : ColorPalette)
    func addGradient(for colorSelection : ColorPalette)

}



 @objc class PMPBaseView: UIView ,ThemeColorChangeResponser {

    let infoLabel : UILabel
    
    override init(frame: CGRect) {
        infoLabel = UILabel(frame: frame)
        super.init(frame: frame)

        self.isUserInteractionEnabled = true
        
        infoLabel.numberOfLines = 0
        if #available(iOS 10.0, *) {
            infoLabel.adjustsFontForContentSizeCategory = true
        }
        
        let margin = CGFloat(30.0)
        let width = (self.bounds.size.width - (2 * margin))
        let height = (self.bounds.size.height - (2 * margin))
        let textFrame = CGRect(x: margin, y: margin, width: width , height:  height)
        infoLabel.frame = textFrame
        self.updateColors()
        self.addSubview(infoLabel)
        
    }
    
     required init?(coder aDecoder: NSCoder) {
        infoLabel = UILabel()
        super.init(coder: aDecoder)
    }
    
    
    // MARK: Theme based color Methods
    @objc public func updateColors() {
     
        // find out current saved color and set colors
        
        let selectedTheme = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appTheme.rawValue)
        if let colorSelection = ColorPalette(rawValue:selectedTheme) {
            self.setColors(for: colorSelection)
        }
    }
    
    func setColors(for colorSelection : ColorPalette = .aqua) {
        
        self.addGradient(for: colorSelection)
        let textColorForLabel = UIColor.textColor(selection: colorSelection)
        infoLabel.textColor = textColorForLabel
    }
    
    
    func addGradient(for colorSelection : ColorPalette = .aqua) {

        let primaryColor = UIColor.primaryFor(selection: colorSelection).cgColor
        let secondaryColor = UIColor.secondaryColor(selection: colorSelection).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [primaryColor,secondaryColor]
        gradientLayer.frame = self.bounds
        
        if let layersArray = self.layer.sublayers {
            if layersArray.count > 0 {
                let previousLayer = layersArray[0]
                previousLayer.removeFromSuperlayer()
            }
        }
        
        self.layer.addSublayer(gradientLayer)
    }
}
