//
//  Concentration.swift
//  Concentration
//
//  Created by 안홍석 on 2020/01/07.
//  Copyright © 2020 안홍석. All rights reserved.
//

// Model (MVC)
// Concentration 게임의 모델

import Foundation

// API : 단지 클래스 안의 모든 메소드와 인스턴스 변수의 리스트
// 공개 API : 다른 클래스들의 사용을 허락한 메소드와 인스턴스 변수들
// 공개, 비공개

// 카드 게임
class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            // 1. 어떤 카드도 앞면이 아닌 경우
            // 2. 매칭됐든 안됐든 두 개의 카드가 앞면인 경우
            // 3. 하나는 앞면이 나오고 다른 카드를 선택했는데 매칭이 된 경우
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are faced up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // let matchingCard = card
            cards.append(card) // 구조체 복사, 2개 다른 카드
            cards.append(card) // matchingCard
            // 더 간편하게
            // cards += [card, card]
        }
        // TODO: Shuffle the cards
//        cards.shuffle();
    }
}
