import UIKit

// Swift 3 Fun Algorithms: Recursive Search through Binary Tree

// perform a search through a binary tree to find if a value is contained in the set of numbers


// 1.
//       10
//      /  \
//     5    14
//    /    /  \
//   1    11  20


// 2.
class Node {
    let value: Int
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: Int, leftChild: Node?, rightChild: Node?) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

// left branch
let oneNode = Node(value: 1, leftChild: nil, rightChild: nil)
let fiveNode = Node(value: 5, leftChild: oneNode, rightChild: nil)

// right branch
let elevenNode = Node(value: 11, leftChild: nil, rightChild: nil)
let twentyNode = Node(value: 20, leftChild: nil, rightChild: nil)

let fourteenNode = Node(value: 14, leftChild: elevenNode, rightChild: twentyNode)

// root branch
let tenRootNode = Node(value: 10, leftChild: fiveNode, rightChild: fourteenNode)

//       10
//      /  \
//     5    14
//    /    /  \
//   1    11  20

// 3.
// Interviewer's question: Implement a search algorithm that searches through this tree for a particular searchValue
func search(node: Node?, searchValue: Int) -> Bool {
    if node == nil {
        return false
    }
    if node?.value == searchValue {
        return true
    } else {
        // recursion
        return search(node: node?.leftChild, searchValue: searchValue) || search(node: node?.rightChild, searchValue: searchValue)
    }
}
search(node: tenRootNode, searchValue: 14)  // 5 -> 1 -> 14
//search(node: tenRootNode, searchValue: 30)

// more efficient way
func searchBetter(node: Node?, searchValue: Int) -> Bool {
    if node == nil {
        return false
    }
    
    if node?.value == searchValue {
        return true
    } else if searchValue < node!.value {
        return search(node: node?.leftChild, searchValue: searchValue)
    } else {
        return search(node: node?.rightChild, searchValue: searchValue)
    }
}
searchBetter(node: tenRootNode, searchValue: 14)    // 14


// 4.

// let's talk about efficiency
let list = [1, 5, 10, 11, 14, 20]
let index = list.firstIndex(where: {$0 == 30})

