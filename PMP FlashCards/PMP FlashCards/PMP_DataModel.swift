//
//  DataParser.swift
//  PMP FlashCards
//
//  Created by Hrishikesh Devhare on 07/04/18.
//  Copyright © 2018 Hrishikesh Devhare. All rights reserved.
//

import UIKit
import Foundation


extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}


  struct PMPCard : Decodable {
    var  title : String
    var description : String
}

struct PMPData : Decodable {
    var FlashCards : [PMPCard]
    var shuffledCards : [PMPCard] {
        get  {
            return FlashCards.shuffled()
        }
    }
}

struct ViewModel {
    var cards : PMPData
    
    func numberOfCards() -> Int {
        return cards.shuffledCards.count
    }
    
    func displayString(At index: Int) -> NSAttributedString {
        let card = cards.shuffledCards[index]
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

        let normalTextAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .body) , .paragraphStyle: centerParagraphStyle]
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




