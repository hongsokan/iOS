import UIKit

// Swift Fun Algorithms #2: Binary Search

// random numbers, 11
let numbers = [1, 2, 4, 6, 8, 9, 11, 13, 16, 17, 20]

func linearSearchForSearchValue(searchValue: Int, array: [Int]) -> Bool {
    for num in array {
        if num == searchValue {
            return true
        }
    }
    return false
}

// 11 times for linear search
print(linearSearchForSearchValue(searchValue: 1, array: numbers))
print(linearSearchForSearchValue(searchValue: 5, array: numbers))
print()


// 1, 2, 4, 6, 8, 9, 11, 13, 16, 17, 20
// search starts from middle number (9)
func binarySearchForSearchValue(searchValue: Int, array: [Int]) -> Bool {
    
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex <= rightIndex {
        
        let middleIndex = (leftIndex + rightIndex) / 2
        let middleValue = array[middleIndex]
        
        print("middleValue: \(middleValue), leftIndex: \(leftIndex), rightIndex: \(rightIndex), [\(array[leftIndex]), \(array[rightIndex])]")
        
        if middleValue == searchValue {
            return true
        }
        
        if searchValue < middleValue {
            rightIndex = middleIndex - 1
        }
        
        if searchValue > middleValue {
            leftIndex = middleIndex + 1
        }
    }
    
    return false
}

// 1, 2, 4, 6, 8, 9, 11, 13, 16, 17, 20

// 9 -> 4 -> 1
print(binarySearchForSearchValue(searchValue: 1, array: numbers))

// 9 -> 4 -> 6
print(binarySearchForSearchValue(searchValue: 5, array: numbers))

print()


var hundredNumbers = [Int]()
for i in 1...100 {
    hundredNumbers.append(i)
}

print(binarySearchForSearchValue(searchValue: 18, array: hundredNumbers))

print(binarySearchForSearchValue(searchValue: 99, array: hundredNumbers))

