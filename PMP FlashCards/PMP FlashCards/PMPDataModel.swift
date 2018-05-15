//
//  DataParser.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 07/04/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit
import Foundation

struct PMPData : Decodable {
    var FlashCards : [PMPCard]
    
    struct PMPCard : Decodable {
        var  title : String
        var description : String
        
        var displayString: NSAttributedString {
            get {
              
                let centerParagraph = NSMutableParagraphStyle()
                centerParagraph.alignment = .center
                let boldAttributes : [ NSAttributedStringKey : Any]
                if #available(iOS 11.0, *) {
                    boldAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle:.largeTitle), .paragraphStyle: centerParagraph]
                } else {
                    boldAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle:.title1), .paragraphStyle: centerParagraph]
                }
                let titleAttributedString = NSMutableAttributedString(string:self.title + "\n\n", attributes: boldAttributes)

                let normalTextAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .body) , .paragraphStyle: centerParagraph]
                let descriptionAttributedString = NSMutableAttributedString(string:self.description, attributes: normalTextAttributes)

                titleAttributedString.append(descriptionAttributedString)
                return titleAttributedString
            }
        }
    }
}

struct ViewModel {
    var cards : PMPData
    
    func numberOfCards() -> Int {
        return cards.FlashCards.count
    }
    
    func displayString(At index: Int) -> NSAttributedString {
        let cardValue = cards.FlashCards[index]
        return cardValue.displayString
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




