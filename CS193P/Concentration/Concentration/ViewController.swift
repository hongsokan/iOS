//
//  ViewController.swift
//  Concentration
//
//  Created by 안홍석 on 2019/12/27.
//  Copyright © 2019 안홍석. All rights reserved.
//

// Controller (MV)

import UIKit

class ViewController: UIViewController {
    
    // 어떤 변수든 사용하기 전에 초기화해야 된다. lazy는 초기화되었다고 해준다. (그대신 didSet 사용할 수 없다. optional 방법도 있다)
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount : Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            // 모델 Concentration에서 chooseCard 메소드 호출
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            //            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        else {
            print("chosen not in cardButtons")
        }
    }
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        }
        else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🦇", "😱", "🙀", "👿", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    // 딕셔너리, 여기서 Int는 키, String은 값(이모티콘)
    //var emoji = Dictionary<Int, String>()
    var emoji = [Int:String]()
    
    func emoji (for card: Card) -> String {
        // 여기서 chosenEmoji 는 옵셔널 값을 받는다
        // let chosenEmoji = emoji[card.identifier]
        // !, ?, if let 등으로 다룰 수 있지만, 더 좋은 방법은?
        
        // Swift에선 if문 내부에 또 if문이 있는 경우 "," 로 한번에 쓸 수도 있음
        if emoji[card.identifier] != nil, emojiChoices.count > 0 {
            // arc4random_uniform 함수는 pseudo 임의 번호 생성 기능, UInt32
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        //        if emoji[card.identifier] != nil {
        //            return emoji[card.identifier]!
        //        } else {
        //            return "?"
        //        }
        
        // 위 문법 간결하게 표현
        return emoji[card.identifier] ?? "?"
        // 이 다음에는 딕셔너리에 값을 넣어줘야 한다
    }
}

