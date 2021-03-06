//: [Previous](@previous)

import Foundation

//: ## Merge Sort - Using an Array
//:
//: ### The merge sort algorithm is a divide-and-conquer algorithm. It works by dividing an array into `n` sublists, repeatedly merging the sublists together until this is one sublist remaining.
//:



private func merge<T: Comparable>(_ leftHalf: [T], rightHalf: [T]) -> [T] {
    
    var leftIndex = 0
    var rightIndex = 0
    var tmpList = [T]()
    tmpList.reserveCapacity(leftHalf.count + rightHalf.count)
    
    while (leftIndex < leftHalf.count && rightIndex < rightHalf.count) {
        if leftHalf[leftIndex] < rightHalf[rightIndex] {
            tmpList.append(leftHalf[leftIndex])
            leftIndex += 1
        }
        else if leftHalf[leftIndex] > rightHalf[rightIndex] {
            tmpList.append(rightHalf[rightIndex])
            rightIndex += 1
        }
        else {
            tmpList.append(leftHalf[leftIndex])
            tmpList.append(rightHalf[rightIndex])
            leftIndex += 1
            rightIndex += 1
        }
    }
    
    
    tmpList += [T](leftHalf[leftIndex..<leftHalf.count])
    tmpList += [T](rightHalf[rightIndex..<rightHalf.count])
    return tmpList
    
}

public func mergeSort<T: Comparable>(_ list: [T]) -> [T] {
    
    if list.count < 2 {
        return list
    }
    
    let center = (list.count) / 2
    return merge(mergeSort([T](list[0..<center])), rightHalf: mergeSort([T](list[center..<list.count])))
}

let smallSize = 50
let mediumSize = 500
let largeSize = 1000

//: ## Small Data Set - Perform 3 sorts using data sorted that is random, in sorted order, and in reverse sorted order.
//:
//: We can compare the peformance charactistics of each to see how the algorithm behaves under various conditions.


//: ### Perform a sort on a small, random non-sorted `Int` dataset.

var arr = makeArray(n: smallSize)

var startSort = Date.timeIntervalSinceReferenceDate

//: Pre-sorted array
arr

arr = mergeSort(arr)

var totalSortTime: [String : Double] = ["small-random-array" : Date.timeIntervalSinceReferenceDate - startSort]

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a small, random sorted `Int` dataset.

arr = makeArray(n: smallSize).sorted()
startSort = Date.timeIntervalSinceReferenceDate

//: Pre-sorted array
arr

arr = mergeSort(arr)

totalSortTime["small-sorted-array"] = Date.timeIntervalSinceReferenceDate - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a small, random reverse-sorted `Int` dataset.

arr = makeArray(n: smallSize).sorted(by: >)
startSort = Date.timeIntervalSinceReferenceDate

//: Pre-sorted array
arr

arr = mergeSort(arr)

totalSortTime["small-reverse-sorted-array"] = Date.timeIntervalSinceReferenceDate - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime



//: ## Medium Data Set - Perform 3 sorts using data sorted that is random, in sorted order, and in reverse sorted order.
//:
//: We can compare the peformance charactistics of each to see how the algorithm behaves under various conditions.


//: ### Perform a sort on a medium, random non-sorted `Int` dataset.

arr = makeArray(n: mediumSize)
startSort = Date.timeIntervalSinceReferenceDate

// arr = mergeSort(arr)

// totalSortTime["medium-random-array"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a medium, random sorted `Int` dataset.

arr = makeArray(n: mediumSize).sorted()
startSort = Date.timeIntervalSinceReferenceDate

// arr = mergeSort(arr)

//totalSortTime["medium-sorted-array"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a medium, random reverse-sorted `Int` dataset.

arr = makeArray(n: mediumSize).sorted(by: >)
startSort = Date.timeIntervalSinceReferenceDate

// arr = mergeSort(arr)
//totalSortTime["medium-reverse-sorted-array"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime



//: ## Large Data Set -
//: Perform 3 sorts using data sorted that is random, in sorted order, and in reverse sorted order.
//:
//: We can compare the peformance charactistics of each to see how the algorithm behaves under various conditions.


//: ### Perform a sort on a large, random non-sorted `Int` dataset.

arr = makeArray(n: largeSize)
startSort = Date.timeIntervalSinceReferenceDate

arr = mergeSort(arr)
totalSortTime["large-random-array"] = Date.timeIntervalSinceReferenceDate - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime


//: ### Perform a sort on a large, random sorted `Int` dataset.

arr = makeArray(n: largeSize).sorted()
startSort = Date.timeIntervalSinceReferenceDate

// arr = mergeSort(arr)

// totalSortTime["large-sorted-array"] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime



//: ### Perform a sort on a large, random reverse-sorted `Int` dataset.

arr = makeArray(n: largeSize).sorted(by: >)
startSort = Date.timeIntervalSinceReferenceDate

// arr = mergeSort(arr)

////totalSortTime["large-reverse-sorted-array "] = NSDate.timeIntervalSinceReferenceDate() - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime


/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */
