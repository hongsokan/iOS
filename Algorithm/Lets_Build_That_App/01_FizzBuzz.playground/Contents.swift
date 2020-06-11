import UIKit

// Swift Fun Algorithms #1: FizzBuzz

// To run through a list of numbers
// 1. print Fizz when divisible by 3
// 2. print Buzz when divisible by 5
// 3. print FizzBuzz 3 and 5

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

for num in numbers {
    if num % 3 == 0 && num % 5 == 0 {
        print("\(num) fizzbuzz")
    }
    else if num % 3 == 0 {
        print("\(num) fizz")
    }
    else if num % 5 == 0 {
        print("\(num) buzz")
    }
    else {
        print(num)
    }
}

// make 100 numbers in an array

var oneHundredNumbers = [Int]()
for i in 1...100 {
    oneHundredNumbers.append(i)
}
