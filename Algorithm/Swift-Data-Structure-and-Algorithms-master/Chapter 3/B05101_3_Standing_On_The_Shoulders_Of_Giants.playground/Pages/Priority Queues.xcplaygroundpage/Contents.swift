//: [Previous](@previous)

import Foundation

//: ## Demonstrate use of the PriorityQueue type.
//:
//: ### Find the PriorityQueue implementation in the Sources/PriorityQueue.swift file located within this project.


var pq = PriorityQueue<Int>(ascending: true)

pq.push(5)
pq.push(3)
pq.push(10)

//: Demonstrate using the Sequence and IteratorProtocol protocols

for el in pq {
    print(el)
}

//: Initializing with starting values

var priorityQueue = PriorityQueue<String>(ascending: true, startingValues: ["Coldplay", "OneRepublic", "Maroon 5", "Imagine Dragons", "The Script"])


//: Demonstrate using the Sequence and IteratorProtocol protocols

for el in priorityQueue {
    print(el)
}

//: Remove an element from the queue

var el = priorityQueue.pop()

//: Display remaining elements

for x in priorityQueue {
    print(x)
}


/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */
