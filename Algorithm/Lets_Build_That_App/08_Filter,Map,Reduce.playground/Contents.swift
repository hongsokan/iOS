import UIKit

// Swift Fun Algorithms: Filter, Map, Reduce Higher Order Functions


// 1. filter

let numbers = [1, 2, 3, 4, 3, 3]

var filteredArray = [Int]()
for number in numbers {
    if number == 3 {
        filteredArray.append(number)
    }
}
filteredArray

// using filter
let filtered = numbers.filter( { return $0 == 3 } )
filtered

let filterEvenNums = numbers.filter( { return $0 % 2 == 0 } )
filterEvenNums

let filterOddNums = numbers.filter( { return $0 % 2 == 1 } )
filterOddNums


// 2. map
// transform [1, 2, 3, 4] -> [2, 4, 6, 8] using map

var transformedArray = [Int]()
for number in [1, 2, 3, 4] {
//    print(number * 2)
    transformedArray.append(number * 2)
}
transformedArray

// using map
let transformed = [1, 2, 3, 4].map( { return $0 * 3} )
transformed


// 3. reduce
// sum [1, 2, 3, 4] -> 10 using reduce

var sumElements = 0
for number in [1, 2, 3, 4] {
    sumElements += number
}
sumElements

// using reduce
let sum = [1, 2, 3, 4].reduce(0, {sum, number in sum + number})
sum
