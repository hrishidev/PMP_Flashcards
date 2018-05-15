//
//  BaseView.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 15/05/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit

class BaseView: UIView {

    let infoLabel : UILabel
    
    override init(frame: CGRect) {
        infoLabel = UILabel(frame: frame)
        super.init(frame: frame)

        self.isUserInteractionEnabled = true
        
        var primaryColor = UIColor(red:(186.0/255.0), green: (236.0/255.0), blue: (255.0/255.0), alpha: 1.0).cgColor
        if #available(iOS 10.0, *) {
            primaryColor = UIColor(displayP3Red: (186.0/255.0), green: (236.0/255.0), blue: (255.0/255.0), alpha: 1.0).cgColor
        }
        
        let secondaryColor = UIColor.white.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [primaryColor,secondaryColor]
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        
        infoLabel.numberOfLines = 0
        if #available(iOS 10.0, *) {
            infoLabel.adjustsFontForContentSizeCategory = true
        }
        
        let margin = CGFloat(30.0)
        let width = (self.bounds.size.width - (2 * margin))
        let height = (self.bounds.size.height - (2 * margin))
        let textFrame = CGRect(x: margin, y: margin, width: width , height:  height)
        infoLabel.frame = textFrame
        self.addSubview(infoLabel)
        
    }
    
     required init?(coder aDecoder: NSCoder) {
        infoLabel = UILabel()
        super.init(coder: aDecoder)
    }
    
}
