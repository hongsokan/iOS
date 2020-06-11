//
//  Helpers.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2016 Erik J. Azar & Mario Eguiluz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import Foundation


public func makeArray(n: Int ) -> [Int] {
    var result:[Int] = []
    for _ in 0..<n {
        result.append(Int(arc4random_uniform(2000) + 1))
    }
    return result
}

public func makeList(n: Int, sorted: Bool = false, reverseSorted: Bool = false) -> LinkedList<Int> {
    var result = LinkedList<Int>()
    
    if sorted == false {
        for _ in 0..<n {
            result.push(Int(arc4random_uniform(2000) + 1))
        }
    }
    else {
        if reverseSorted == true {
            for i in stride(from: n, to: 0, by: -1){
                result.push(i)
            }
        }
        else {
            for i in 0 ..< n {
                result.push(i)
            }
        }
    }
    return result
}

public func swap<T>( _ list: inout [T], _ a: Int, _ b: Int) {
    if a != b {
        swap(&list[a], &list[b])
    }
}
