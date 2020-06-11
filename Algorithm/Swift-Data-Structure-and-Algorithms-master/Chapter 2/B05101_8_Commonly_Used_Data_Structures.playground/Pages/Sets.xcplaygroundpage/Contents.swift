//: [Previous](@previous)

import Foundation

//: ## Sets

//: ### Initializing Sets
//: Create a set

var settings = Set<String>()

//: Create a set from an array literal

var stringSet: Set = ["Erik", "Mary", "Michael", "John", "Sally"]
print(stringSet.debugDescription)

//: ### Modifying and Retrieving Elements of a Set

stringSet.insert("Patrick")

//: See if the set contains an element

if stringSet.contains("Erik") {
    print("Found element")
}
else {
    print("Element not found")
}

//: Remove an element from the set

stringSet.remove("Erik")

//: Remove an element by index

if let idx = stringSet.index(of: "John") {
    stringSet.remove(at: idx)
}

//: Remove the first element in the set

stringSet.removeFirst()

//: Remove all elements in the set

stringSet.removeAll()

//: Iterate over a set

stringSet = Set(["Erik", "Mary", "Michael", "John", "Sally"])
for name in stringSet {
    print("name = \(name)")
}

//: Sort and iterate over a set

for name in stringSet.sorted() {
    print("name = \(name)")
}

//: ### Set Operations
//:
//: Comparison Operations - Swift Sets contain four methods for performing common operations on two sets.

let adminRole: Set = [ "READ", "EDIT", "DELETE", "CREATE", "SETTINGS", "PUBLISH_ANY", "ADD_USER", "EDIT_USER", "DELETE_USER"]

let editorRole: Set = ["READ", "EDIT", "DELETE", "CREATE", "PUBLISH_ANY"]

let authorRole: Set = ["READ", "EDIT_OWN", "DELETE_OWN", "PUBLISH_OWN", "CREATE"]

let contributorRole: Set = [ "CREATE", "EDIT_OWN"]

let subscriberRole: Set = ["READ"]

//: Union - Contains values from both Sets

let fooResource = subscriberRole.union(contributorRole)

//: Intersect - Contains values common to both Sets

let commonPermissions = authorRole.intersection(contributorRole)

//: ExclusiveOr - Contains values in either Set but not both

let exclusivePermissions = authorRole.symmetricDifference(contributorRole)


//:
//: Membership and Equality Operations
//:

//: Note ordering of the sets does not matter
var sourceSet: Set = [1, 2, 3]
var destSet: Set = [2, 1, 3]

//: Test for equality

var isequal = sourceSet == destSet



let contactResource = authorRole
let userBob = subscriberRole
let userSally = authorRole

//: isSupersetOf - Determines if a set contains all of the values of the specified set

if userBob.isSuperset(of: fooResource){
    print("Access granted")
}
else {
    print("Access denied")
}

if userSally.isSuperset(of: fooResource){
    print("Access granted")
}
else {
    print("Access denied")
}

//: isDisjointWith - Determines if two sets have the same values in common

authorRole.isDisjoint(with: editorRole)

//: isSubsetOf - Determines if all of the values of a set are contained in a specified set

editorRole.isSubset(of: adminRole)


/*:

[Next](@next)

The license for this document is available [here](License).
*/
