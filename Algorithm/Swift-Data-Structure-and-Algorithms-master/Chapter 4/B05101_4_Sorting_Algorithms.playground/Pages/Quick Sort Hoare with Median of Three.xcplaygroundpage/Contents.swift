//: [Previous](@previous)

import Foundation

//: ## Quick Sort - Hoare Partitioning Scheme with Median of Three
//:
//: ### The Median of Three strategy is an optimized pivot selection method than ensures a random pivot value is selected.
//:
//: ### The quick sort algorithm is a fast sorting algorithm for smaller sized datasets that uses the *divide-and-conquer* pattern to implement the sorting algorithm. It sorts a sequence `S` in-place using a recursive approach. It divides `S` into subsequences.



public func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
    
    if lo < hi {
        
//: Returns an value representing the median value.
        let median = getMedianOfThree(&list, lo: lo, hi: hi)
        
//: The partition function returns a new pivot value based on the `lo`, `hi`, and `median` values.
        let pivot = partition(&list, lo: lo, hi: hi, median: median)
        
//: Recursively call quickSort to begin sorting the left subsequence of the array.
        quickSort(&list, lo: lo, hi: pivot)
        
//: Recusively call quickSort to begin sorting the right subsequence of the array.
        quickSort(&list, lo: pivot + 1, hi: hi)
        
    }
}

private func getMedianOfThree<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> T {
    
//: Calculate the center index position
    let center = lo + (hi - lo) / 2
    
//: Swap the `lo` and `center` values if `lo` is greater than `center`.
    if list[lo] > list[center] {
        swap(&list[lo], &list[center])
    }
    
    //: Swap the `lo` and `hi` values if `lo` is greater than `hi`.
    if list[lo] > list[hi] {
        swap(&list[lo], &list[hi])
    }
    
//: Swap the `center` and `hi` values if `center` is greater than `hi`.
    if list[center] > list[hi] {
        swap(&list[center], &list[hi])
    }
    
//: Swap the `center` and `hi` values before returning.
    swap(&list[center], &list[hi])
    
//: We return the value in the `hi` index position.
    return list[hi]
}

private func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int, median: T) -> Int {
    
    var i = lo - 1
    var j = hi + 1
    //: Create infinate loop
    while true {
        
//: Continue incrementing the `i` pointer until the array index is nolonger less than our median value.
        i += 1
        while list[i] < median { i += 1 }
        
//: We then continue to decrement the `j` point until it is no longer greater than our median value.
        j -= 1
        while list[j] > median { j -= 1 }
        
//: Then we check if our lower index pointer is equal or greater than our upper index pointer, if it is return the upper index pointer.
        if i >= j {
            return j
        }
        
//: If `i` less than `j` we swap the `i` elemennt with `j`.
        swap(&list[i], &list[j])
    }

}

var arr = makeArray(n: 11)

//: Pre-sorted array
arr


var startSort = Date.timeIntervalSinceReferenceDate

quickSort(&arr, lo: 0, hi: arr.count - 1)

var totalSortTime = Date.timeIntervalSinceReferenceDate - startSort

//: Sorted array
arr


//: Total run time in milliseconds
totalSortTime

/*:
 
 The license for this document is available [here](License).
 */


