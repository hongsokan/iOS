//: [Previous](@previous)

import Foundation

/*:

## Bridging Collection Classes

Swift provides bridging from the Foundation collection types, `NSArray`, `NSSet`, and `NSDictionary` to the native Swift `Array`, `Set`, and `Dictionary` types. This allows you to work with Foundation collection types and Swift collection types and use them interchangeably with many of the native Swift algorithms that work with collections.

*/


/*:

### NSArray to Array

Bridging from an `NSArray` with a parameterized type will create an array of type `[ObjectType]`. If the `NSArray` does not specify a parameterized type then an array of `[AnyObject]` is created.

*/

// Uses forced unwrapping of NSArray
let  nsFibonacciArray: NSArray = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
let swiftFibonacciArray: [Int] = nsFibonacciArray as! [Int]

// Uses type casting operator
if let swiftFibonacciArray: [Int] = nsFibonacciArray as? [Int] {
    // Use the swiftFibonacciArray array
}

// An example with NSArray containing different types
let mixedNSArray: NSArray = NSArray(array: [0, 1, "1", 2, "3", 5, "8", 13, 21, 34])

/*:

The follow statement will throw an exception because not all types were `Int`

    let swiftArrayMixed: [Int] = mixedNSArray as! [ Int]

*/


// Using the type casting operator
if let swiftArrayMixed: [Int] = mixedNSArray as? [Int]{
    // The condition was false so this body is skipped
    print("Type cast succeeded")
}
else {
    print("Type cast failed")
}


/*:

### NSSet to Set

Bridging from an `NSSet` with a parameterized type will create a set of type `Set<ObjectType>`. If the `NSSet` does not specify a parameterized type then a Swift set of `Set<AnyObject>` is created. Use the same methods of forced unwrapping and the type casting operator that we discussed for arrays to work with sets.

*/


/*:

### NSDictionary to Dictionary

Bridging from an `NSDictionary` with a parameterized type will create a dictionary of type `[ObjectType]`. If the `NSDictionary` does not specify a parameterized type then a Swift dictionary of `[NSObject:AnyObject]` is created.


*/


/*:

[Next](@next)

The license for this document is available [here](License).
*/
