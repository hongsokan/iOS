//
// Examples.swift
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

public func firstElement(array:[Int]) -> Int? {
    return array.first
}

public func fibonacci(number:Int) -> Int {
    if number <= 1 {
        return number
    }
    
    return fibonacci(number: number - 2) + fibonacci(number: number - 1)
}


public func test() {
    let number = 5
    let result = number + 4
    var myString:String = "Hey"
    
    
    let array:[Int] = [1,2,3,4]
    if array[0] == 1 {
        //O(1)
        print(array[0])
    }else {
        //O(array.lenght)
        for number in array {
            print(number)
        }
    }
    
    // n = 4
    let intArray:[Int] = [1,2,3,4]
    for number in intArray {
        // O(n) = 4 x O(1) = O(4)
        print(number)
    }
    
    
    let intsArray:[Int] = [1,2,3,4] //O(n) = 1
    var total = 0 //O(n) = 1
    for number in intsArray { //O(n) = 4^2 = 16
        for nestedNumber in intsArray {
            total = total + number * nestedNumber
        }
    }
    //O(n) = 16 + 1 + 1    
}
