//
//  main.swift
//  Test
//
//  Created by 안홍석 on 2020/08/01.
//  Copyright © 2020 안홍석. All rights reserved.
//

import Foundation













// toss 모의테스트
// [iOS] 색상 코드 변환하기

/*
Ex1

Input:
3
#3A7B9F
#EFC2E7
#C050F5

Output
58 123 159
239 194 231
192 80 245

Ex2

Input:
5
#40A1A7
#27A0CF
#846175
#C9913C
#15FBE2

Output:
64 161 167
39 160 207
132 97 117
201 145 60
21 251 226
*/

func read() -> [String] {
    let n = Int(readLine()!)!
    var colorCodes = [String](repeating: "", count: n)
    
    for index in 0..<n {
        colorCodes[index] = readLine()!
    }
    return colorCodes
}

func write(_ result: [(Int, Int, Int)]) {
    result.forEach {
        print("\($0) \($1) \($2)")
    }
}

func solve(_ colorCodes: [String]) -> [(Int, Int, Int)] {
    
    var result = [(Int, Int, Int)]()
    
    //    var colorCodes = [String]()
    //    colorCodes = ["3A7B9F"]
    
    for code in colorCodes {
        
        var code = code
        
//        var code = colorCodes.first!
        if code.hasPrefix("#") {
            code.remove(at: code.startIndex)
        }
        
        if code.count != 6 {
            code = "000000"
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: code).scanHexInt64(&rgbValue)
        let redValue = (rgbValue & 0xFF0000) >> 16
        let greenValue = (rgbValue & 0x00FF00) >> 8
        let blueValue = (rgbValue & 0x0000FF)
        
        result.append((Int(redValue), Int(greenValue), Int(blueValue)))
    }
    
    //    print(result)
    
    return result
}

write(solve(read()))

