//: [Previous](@previous)

import Foundation

//: ## Demonstrate use of the StackList type.
//:
//: ### Find the StackList implementation in the Sources/StackList.swift file located within this project.

//: Create a new StackList of integers.

var sl = StackList<Int>()

//: Add 3 elements to the stack.

sl.push(element: 34)
sl.push(element: 77)
sl.push(element: 67)

//: Remove the last element added. "x" should contain the value 67.

let x = sl.pop()

//: Remove the next element added. "y" should contain the value 77.

let y = sl.pop()

//: Display the remaining items in the stack. Only one value should remain which is 34.

for el in sl {
    print(el)
}

//: Add three more elements to the stack.

sl.push(element: 16)
sl.push(element: 18)
sl.push(element: 20)

//: Display the remaining items in the stack. We should have four items display in the output display.
for el in sl {
    print(el)
}

/*:
 
 The license for this document is available [here](License).
 */