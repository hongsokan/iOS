import UIKit

// Swift Fun Algorithms #3: Factorials & Recursion

func factorialOfValue(value: UInt) -> UInt {
    
    if value == 0 {
        return 1
    }
    
    var product: UInt = 1
    for i in 1...value {
        product = product * i
    }
    
    return product
}

// print(factorialOfValue(value: 3))
factorialOfValue(value: 3) // 6 = 1 * 2 * 3
factorialOfValue(value: 4) // 24 = 1 * 2 * 3 * 4
factorialOfValue(value: 5) // 120 = 1 * 2 * 3 * 4 * 5
print()

//factorialOfValue(value: 0)
// because it causes error, handle it first, return 1



// resursion works only when you have a terminating case !!
func recursiveFactorialOfValue(value: UInt) -> UInt {
    
    // terminating case should be pretty much specified on the top (before recursion)
    if value == 0 {
        return 1
    }
    
    print(value)
    
    return value * recursiveFactorialOfValue(value: value - 1)
}

recursiveFactorialOfValue(value: 1)
recursiveFactorialOfValue(value: 2)
recursiveFactorialOfValue(value: 3)

