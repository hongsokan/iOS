/*:
# Chapter 2
## Working with Commonly Used Data Structures
*/

import Foundation

//: This section will look at the Collection Types from the Swift Standard Library.

//: ## Arrays

//: Create an array using full array syntax

var intArray = Array<Int>()

//: Create an array using shorthand syntax

intArray = [Int]()

//: Use array literal declaration

var intLiteralArray: [Int] = [1, 2, 3]

//: Use shorthand literal declaration

intLiteralArray = [1, 2, 3]

//: Create an array with a default value

intLiteralArray = [Int](repeating: 2, count: 5)


//: `intArray` has an initial capacity of `0`

intArray.capacity

//: For a reserve capacity of `500`

intArray.reserveCapacity(500)

//: `intArray` now has an initial capacity of `508`

intArray.capacity

/*:
Demonstrate the array methods to add and update elements

- append(_:)

- appendContentsOf(_:)

- insert(_:atIndex)

- subscript(_:)

*/

intArray.append(50)

intArray.append(contentsOf: [60, 65, 70, 75])

intArray.insert(55, at: 1)

intArray[2] = 63

intArray[5]

intArray[2..<5]

//: Iterate over the array element by element

for element in intArray {
    print(element)
}

//: Check if the array contains a specific element

intArray.contains(55)


/*:

[Next](@next)

The license for this document is available [here](License).
*/
