//: [Previous](@previous)

import Foundation

//: ## Quick Sort - Lomuto Partitioning Scheme
//:
//: ### The Lomuto scheme uses the highest index value for the pivot and is often used when initially explaining the quicksort algorith.
//:
//: ### The quick sort algorithm is a fast sorting algorithm for smaller sized datasets that uses the *divide-and-conquer* pattern to implement the sorting algorithm. It sorts a sequence `S` in-place using a recursive approach. It divides `S` into subsequences.



func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {

    
    if lo < hi {

//: The partition function returns a new pivot value based on the `lo` and `hi` indexes.
         let pivot = partition(&list, lo: lo, hi: hi)

//: Recursively call quickSort to begin sorting the left subsequence of the array.
         quickSort(&list, lo: lo, hi: pivot - 1)
        
//: Recusively call quickSort to begin sorting the right subsequence of the array.
         quickSort(&list, lo: pivot + 1, hi: hi)
        
    }
}

func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {

//: The Lomuto scheme always selects the highest index elemenet as the pivot value.
    let pivot = list[hi]
    var i = lo
    
//: Iterate over the array from `lo` to `hi - 1`
    for j in lo..<hi {
        if list[j] <= pivot {
//: if the current array element is less than or equal to pivot we swap its position with the current lowest index position.
            swap(&list, i, j)
            i += 1
        }
    }
    
//: We swap the element we used for the pivot and move it into ordered position within the array sequence.
    swap(&list, i, hi)
    return i
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
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */

