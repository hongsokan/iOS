//: [Previous](@previous)

import Foundation

//: ## Demonstrate use of the Queue type.
//:
//: ### Find the Queue implementation in the Sources/Queue.swift file located within this project.


//: Demonstrate using array literal notation

var q1: Queue<Int> = [1,2,3,4,5]

//: Demonstrate using array initializer

var q2 = Queue<Int>(q1)

//: Remove the first element from the queue.

q1.dequeue()

//: Display the remaining elements in the queue.

q1

//: Add an element to the end of the queue.

q2.enqueue(element: 55)


//: Demonstrate using the Sequence and IteratorProtocol protocols
for el in q1 {
    print(el)
}


/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */
