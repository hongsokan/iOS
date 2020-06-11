//: [Previous](@previous)

import Foundation

//: ## Merge Sort - Using a Linked List
//:
//: ### The merge sort algorithm is a divide-and-conquer algorithm. It works by dividing an array into `n` sublists, repeatedly merging the sublists together until this is one sublist remaining.
//:


private func frontBackSplit<T: Comparable>( list: inout LinkedList<T>, front: inout Node<T>?, back: inout Node<T>?){
    
    var fast: Node<T>?
    var slow: Node<T>?
    
    if list.head == nil || list.head?.next == nil {
        front = list.head
        back = nil
    }
    else {
        slow = list.head
        fast = list.head?.next
        
        while fast != nil {
            fast = fast?.next
            if fast != nil {
                slow = slow?.next
                fast = fast?.next
            }
        }
        
        front = list.head
        back = slow?.next
        slow?.next = nil
    }
}

private func merge<T: Comparable>(left: Node<T>?, right: Node<T>?) -> Node<T>? {
    
    var result: Node<T>? = nil
    
    if left == nil {
        return right
    }
    else if right == nil {
        return left
    }
    
    if left!.data <= right!.data {
        result = left
        result?.next = merge(left: left?.next, right: right)
    }
    else {
        result = right
        result?.next = merge(left: left, right: right?.next)
    }
    
    return result
}


func mergeSort<T: Comparable>( list: inout LinkedList<T>) {
    
    var left: Node<T>? = nil
    var right: Node<T>? = nil

    if list.head == nil || list.head?.next == nil {
        return
    }
    
    frontBackSplit(list: &list, front: &left, back: &right)
    
    var leftList = LinkedList<T>()
    leftList.head = left
    
    var rightList = LinkedList<T>()
    rightList.head = right
    
    mergeSort(list: &leftList)
    mergeSort(list: &rightList)
    
    list.head = merge(left: leftList.head, right: rightList.head)
}

let smallSize = 50
let mediumSize = 500
let largeSize = 1000


//: ## Small Data Set - Perform 3 sorts using data sorted that is random, in sorted order, and in reverse sorted order.
//:
//: We can compare the peformance charactistics of each to see how the algorithm behaves under various conditions.


//: ### Perform a sort on a small, random non-sorted `Int` dataset.

var list = makeList(n: smallSize)

//: Pre-sorted list
list


var startSort = NSDate.timeIntervalSinceReferenceDate

mergeSort(list: &list)

var totalSortTime: [String : Double] = ["small-random-list" : NSDate.timeIntervalSinceReferenceDate - startSort]

//: Sorted list
list

//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a small, sorted `Int` dataset.

list = makeList(n: smallSize, sorted: true)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

//mergeSort(&list)

//totalSortTime["small-sorted-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a small, random reverse-sorted `Int` dataset.

list = makeList(n: smallSize, sorted: false, reverseSorted: true)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

//mergeSort(&smallReverseSortedlist)

//totalSortTime["small-reverse-sorted-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime




//: ## Medium Data Set - Perform 3 sorts using data sorted that is random, in sorted order, and in reverse sorted order.
//:
//: We can compare the peformance charactistics of each to see how the algorithm behaves under various conditions.


//: ### Perform a sort on a medium, random non-sorted `Int` dataset.

list = makeList(n: mediumSize)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

// mergeSort(&list)

// totalSortTime["medium-random-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime




//: ### Perform a sort on a medium, random sorted `Int` dataset.

list = makeList(n: mediumSize, sorted: true)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

//mergeSort(&list)

//totalSortTime["medium-sorted-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a medium, random reverse-sorted `Int` dataset.

list = makeList(n: mediumSize, sorted: false, reverseSorted: true)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

//mergeSort(&list)
//totalSortTime["medium-reverse-sorted-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime




//: ## Large Data Set -
//: Perform 3 sorts using data sorted that is random, in sorted order, and in reverse sorted order.
//:
//: We can compare the peformance charactistics of each to see how the algorithm behaves under various conditions.


//: ### Perform a sort on a large, random non-sorted `Int` dataset.

list = makeList(n: largeSize)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

// mergeSort(&list)
// totalSortTime["large-random-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime




//: ### Perform a sort on a large, random sorted `Int` dataset.

list = makeList(n: largeSize, sorted: true)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

// mergeSort(&list)

// totalSortTime["large-sorted-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a large, random reverse-sorted `Int` dataset.

list = makeList(n: largeSize, sorted: false, reverseSorted: true)

//: Pre-sorted list
list

startSort = NSDate.timeIntervalSinceReferenceDate

// mergeSort(&list)

// totalSortTime["large-reverse-sorted-list"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted list
list


//: Total run time in milliseconds
totalSortTime



/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */

