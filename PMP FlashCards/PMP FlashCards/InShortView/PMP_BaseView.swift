//
//  BaseView.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 15/05/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit

final class BaseView: UIView {

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
        self.setColors(for: .apricot)
        self.addSubview(infoLabel)
        
    }
    
     required init?(coder aDecoder: NSCoder) {
        infoLabel = UILabel()
        super.init(coder: aDecoder)
    }
    
    
    func setColors(for colorSelection : ColorPalette = .aqua) {
        
        let primaryColor = UIColor.primaryFor(selection: colorSelection).cgColor
        let secondaryColor = UIColor.secondaryColor(selection: colorSelection).cgColor
        let textColorForLabel = UIColor.textColor(selection: colorSelection)
        
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
        infoLabel.textColor = textColorForLabel
    }
    
}
