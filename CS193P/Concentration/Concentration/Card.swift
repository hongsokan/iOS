//
//  Card.swift
//  Concentration
//
//  Created by 안홍석 on 2020/01/07.
//  Copyright © 2020 안홍석. All rights reserved.
//

// Model(MVC)
// 카드에 대한 모델

import Foundation

// class & struct
// 구조체: 상속성 없다, 간단, 아니면 상속받는 것과 어떻게 받아들이는지 등
// 구조체 값 타입(value): 인자로 보내거나, 배열에 넣거나, 다른 변수에 할당해도 복사(copied), 배열,정수형,문자열,딕셔너리 모두 구조체, 쓰기 시 복사 전달 체계
// 클래스 참조 타입(reference): 실제 자료형을 보내는 것이 아닌 그 자료형을 가리키는 포인터를 보내는 것

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
