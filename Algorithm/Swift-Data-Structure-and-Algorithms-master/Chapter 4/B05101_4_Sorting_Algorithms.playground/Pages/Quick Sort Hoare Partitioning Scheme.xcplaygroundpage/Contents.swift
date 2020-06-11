//: [Previous](@previous)

import Foundation

//: ## Quick Sort - Hoare Partitioning Scheme
//:
//: ### The Hoare scheme uses the lowest index value for the pivot. It also performs 3 times fewer swaps on average than the Lomuto scheme.
//:
//: ### The quick sort algorithm is a fast sorting algorithm for smaller sized datasets that uses the *divide-and-conquer* pattern to implement the sorting algorithm. It sorts a sequence `S` in-place using a recursive approach. It divides `S` into subsequences.


func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
    
    if lo < hi {
        
//: The partition function returns a new pivot value based on the `lo` and `hi` indexes.
        let pivot = partition(&list, lo: lo, hi: hi)

//: Recursively call quickSort to begin sorting the left subsequence of the array.
        quickSort(&list, lo: lo, hi: pivot)
        
//: Recusively call quickSort to begin sorting the right subsequence of the array.
        quickSort(&list, lo: pivot + 1, hi: hi)
        
    }
}

private func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {
    
//: The Hoare scheme always selects the lowest index elemenet as the pivot value.
    let pivot = list[lo]
    var i = lo - 1
    var j = hi + 1
    
//: Create infinate loop
    while true {
        
//: Continue incrementing the `i` pointer until the array index is nolonger less than our pivot value.
        i += 1
        while list[i] < pivot { i += 1}
        
//: We then continue to decrement the `j` point until it is no longer greater than our pivot value.
        j -= 1
        while list[j] > pivot { j -= 1 }
        
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

print("high")


//: Total run time in milliseconds
totalSortTime


/*:
 
 [Next](@next)
 
 The license for this document is available [here](License).
 */

