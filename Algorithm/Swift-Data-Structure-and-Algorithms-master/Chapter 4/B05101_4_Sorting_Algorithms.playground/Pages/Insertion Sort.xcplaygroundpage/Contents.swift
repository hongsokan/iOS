/*:
 # Chapter 4
 ## Sorting Algorithms
 */

import Foundation

//: ## Insertion Sort
//:
//: ### The insertion sort iterates over elements in collection. It sorts a collection in-place, iterating over the collection comparing elements against the largest sorted element.


func insertionSort<T: Comparable>(_ list: inout [T]){
    
    if list.count <= 1 {
        return
    }
    
//: The outer loop iterates over the collection beginning at the 2nd element.
    
    for i in 1..<list.count {
        
//: Store current element.
        let x = list[i]
        var j = i
        
//: Iterate over the collection as `j` decrements, shifting elements to the right to make room to insert the current element `x`.
        while j > 0 && list[j - 1] > x {

//: Swap element moving it to the right and decrement `j`.
            list[j] = list[j - 1]
            j -= 1
        }
        
//: The next position element is a greater value so we insert the current element immediately before the next position.
        list[j] = x
    }
    
}



//: ## Performing an Insertion Sort on a small sample dataset.
//:
//: Given a collection of non-sorted `Int` values.

var smallSampleDataSet = makeArray(n: 10)

print(smallSampleDataSet)
var startSort = Date.timeIntervalSinceReferenceDate

insertionSort(&smallSampleDataSet)

var totalSortTime: [String : Double] = ["small-non-sorted" : Date.timeIntervalSinceReferenceDate - startSort]

print(smallSampleDataSet)


//: ## Performing an Insertion Sort on a mid-size sample dataset.
//:
//: Given a collection of non-sorted `Int` values.

var midsizeSampleDataSet = makeArray(n: 100)

print(midsizeSampleDataSet)
startSort = Date.timeIntervalSinceReferenceDate

// midsizeSampleDataSet.insertionSort()

// totalSortTime["midsize-non-sorted"] = NSDate.timeIntervalSinceReferenceDate() - startSort

print(midsizeSampleDataSet)


//: ## Performing an Insertion Sort on a large sample dataset.
//:
//: Given a collection of non-sorted `Int` values.

var largeSampleDataSet = makeArray(n: 500)

print(largeSampleDataSet)
startSort = Date.timeIntervalSinceReferenceDate

// largeSampleDataSet.insertionSort()

// totalSortTime["large-non-sorted"] = NSDate.timeIntervalSinceReferenceDate() - startSort

print(largeSampleDataSet)

//: ## Performing an Insertion Sort on a large sorted sample dataset.
//:
//: Given a collection of ordered `Int` values.

largeSampleDataSet = makeArray(n: 500).sorted()

print(largeSampleDataSet)
startSort = Date.timeIntervalSinceReferenceDate

// largeSampleDataSet.insertionSort()

// totalSortTime["large-ordered"] = NSDate.timeIntervalSinceReferenceDate() - startSort


//: ## Performing an Insertion Sort on a large reverse sorted sample dataset.
//:
//: Given a collection of reverse-sorted `Int` values.

largeSampleDataSet = makeArray(n: 500).sorted(by: >)

print(largeSampleDataSet)
startSort = Date.timeIntervalSinceReferenceDate

//largeSampleDataSet.insertionSort()

// totalSortTime["large-reverse-sorted"] = NSDate.timeIntervalSinceReferenceDate() - startSort

print(largeSampleDataSet)

//: ## Running Time for Insertion Sort with Different Sample Sizes
//:
//: Based on these running times we can clearly see as the data set size increases the running time increases signigicantly.

totalSortTime


/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */


