//: [Previous](@previous)

import Foundation

//: ## Dictionaries

//: ### Initializing Dictionaries
//: Create a dictionary using full syntax

var myDict = Dictionary<Int, String>()

//: Create a dictionary using shorthand syntax

myDict = [Int: String]()

//: Use array literal declaration

var myLiteralDict: [Int: String] = [1: "One", 2: "Two", 3: "Three"]

//: Use shorthand literal declaration

myLiteralDict = [1: "One", 2: "Two", 3: "Three"]

//: ### Adding, Modifying, and Removing a Key-Value Pair
//: Update an existing pair, or if it doesn't exist add a new pair

myDict = [1: "One", 2: "Two", 3: "Three"]
myDict.updateValue("Four", forKey: 4)

//: Adding a new pair using subscript

myDict[5] = "Five"

//: Remove a pair from the dictionary - returns the pair that was removed.
let removdPair = myDict.removeValue(forKey: 1)

//: Remove a pair using subscipt
myDict[2] = nil

//: ### Retrieve values from a dictionary using Optional Binding
myDict = [1: "One", 2: "Two", 3: "Three"]
if let optResult = myDict[3] {
    print(optResult)
}
else {
    print("Key not found")
}

//: ### Retrieve values from a dictionary using Forced Unwrapping
//: Only use this method if you know the key will exist

let result = myDict[3]

//: Iterate over the dictionary pairs

let states = [ "AL" : "Alabama", "CA" : "California", "AK" : "Alaska", "AZ" : "Arizona", "AR" : "Arkansas"]

for (stateAbbr, stateName) in states {
    print("The state abbreviation for \(stateName) is \(stateAbbr)")
}

//: Iterate over the dictionay using the keys

for (stateAbbr) in states.keys {
    print("State abbreviation: \(stateAbbr)")
}

//: Iterate over the dictionary using the values

for (stateName) in states.values {
    print("State name: \(stateName)")
}

//: ### Sorting the pairs in a dictionary

// Sort the dictionary by the value of the key
let sortedArrayFromDictionary = states.sorted(by: { $0.0 < $1.0 })

//: Iterate using keys

for (key) in sortedArrayFromDictionary.map({ $0.0}) {
    print("The key: \(key)")
}

//: Iterate using values

for (value) in sortedArrayFromDictionary.map({ $0.1}) {
    print("The value: \(value)")
}


/*: 

[Next](@next)

The license for this document is available [here](License).
*/
