//
//  DataParser.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 07/04/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit
import Foundation

  struct PMPCard : Decodable {
    var  title : String
    var description : String
}

struct PMPData : Decodable {
    var FlashCards : [PMPCard]
}

struct ViewModel {
    var cards : PMPData
    
    func numberOfCards() -> Int {
        return cards.FlashCards.count
    }
    
    func displayString(At index: Int) -> NSAttributedString {
        let card = cards.FlashCards[index]
        let titleAttributedString = self.titleString(card: card)
        let descriptionString = self.descriptionString(card: card)
        titleAttributedString.append(descriptionString)
        
        return titleAttributedString
    }
    
    private func titleString(card : PMPCard)  -> NSMutableAttributedString {
        
        let centerParagraph = NSMutableParagraphStyle()
        centerParagraph.alignment = .center
        let boldAttributes : [ NSAttributedStringKey : Any]
        if #available(iOS 11.0, *) {
            boldAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle:.largeTitle), .paragraphStyle: centerParagraph]
        } else {
            boldAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle:.title1), .paragraphStyle: centerParagraph]
        }
        let titleAttributedString = NSMutableAttributedString(string:card.title + "\n\n", attributes: boldAttributes)
        return titleAttributedString
    }
    
    private func descriptionString( card : PMPCard) -> NSAttributedString {
        
        let centerParagraphStyle = NSMutableParagraphStyle()
        centerParagraphStyle.alignment = .center

        let normalTextAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .callout) , .paragraphStyle: centerParagraphStyle]
        let descriptionAttributedString = NSMutableAttributedString(string:card.description, attributes: normalTextAttributes)
        return descriptionAttributedString

    }
    
    init?() {
            do {
                let jsonData = try Data(contentsOf: Bundle.main.url(forResource: "PMPCards", withExtension: "json")!, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                self.cards = try decoder.decode(PMPData.self, from: jsonData)
            }
            catch {
                print(error.localizedDescription)
                return nil
            }
    }
}




